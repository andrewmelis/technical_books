#import <XCTest/XCTest.h>
#import "StackOverflowCommunicator.h"
#import "InspectableStackOverflowCommunicator.h"

@interface StackOverflowCommunicatorTests : XCTestCase

@property InspectableStackOverflowCommunicator *communicator;

@end

@implementation StackOverflowCommunicatorTests



- (void)setUp
{
    _communicator = [[InspectableStackOverflowCommunicator alloc] init];

}

- (void)tearDown
{
    _communicator = nil;
}

- (void)testSearchingForQuestionsOnTopicCallsTopicAPI
{
    [_communicator searchForQuestionsWithTag:@"ios"];
    XCTAssertEqualObjects([[_communicator URLToFetch] absoluteString], @"http://api.stackexchange.com/2.2/search?tagged=ios&site=stackoverflow&pagesize=20", @"Use the search API to find questions with a particular tag");
}

- (void)testFillingInQuestionBodyCallsQuestionAPI
{
    [_communicator downloadInformationForQuestionWithID:12345678];
    XCTAssertEqualObjects([[_communicator URLToFetch] absoluteString], @"http://api.stackexchange.com/2.2/questions/12345678?body=true&site=stackoverflow", @"Use the question API to get the body for a question");
}

- (void)testFetchingAnswersToQuestionCallsQuestionAPI
{
    [_communicator searchForAnswersForQuestionWithID:12345678];
    XCTAssertEqualObjects([[_communicator URLToFetch] absoluteString], @"http://api.stackexchange.com/2.2/questions/12345678/answers?body=true&site=stackoverflow", @"Use the question API to get answers on a given question" );
}

- (void)testSearchingForQuestionsCreatesURLConnection
{
    [_communicator searchForQuestionsWithTag:@"ios"];
    XCTAssertNotNil([_communicator currentURLConnection], @"There should be a URL connection in-flight now.");
    [_communicator cancelAndDiscardURLConnection];
}

- (void)testStartingNewSeachThrowsOutOldConnection
{
    [_communicator searchForQuestionsWithTag:@"ios"];
    NSURLConnection *firstConnection = [_communicator currentURLConnection];
    [_communicator searchForQuestionsWithTag:@"cocoa"];
    XCTAssertFalse([[_communicator currentURLConnection] isEqual:firstConnection], @"The communicator needs to replace its URL connection to start a new one");
    [_communicator cancelAndDiscardURLConnection];
}

- (void)testDownloadingBodyInformationCreatesURLConnection
{
    [_communicator downloadInformationForQuestionWithID:12345678];
    XCTAssertNotNil([_communicator currentURLConnection], @"Should be a url in flight now");
    [_communicator cancelAndDiscardURLConnection];
}

- (void)testDownloadingBodyInformationThrowsOutOldConnection
{
    [_communicator downloadInformationForQuestionWithID:12345678];
    NSURLConnection *firstConnection = [_communicator currentURLConnection];
    [_communicator downloadInformationForQuestionWithID:23456789];
    XCTAssertFalse([[_communicator currentURLConnection] isEqual:firstConnection], @"The communicator needs to replace its URL connection to start a new one");
    [_communicator cancelAndDiscardURLConnection];
    
}

@end
