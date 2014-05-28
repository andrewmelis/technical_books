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
    
    //test
}

@end
