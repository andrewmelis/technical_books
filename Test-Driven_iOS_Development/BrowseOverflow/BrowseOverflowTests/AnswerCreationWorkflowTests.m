#import <XCTest/XCTest.h>

#import "FakeAnswerBuilder.h"
#import "StackOverflowManager.h"
#import "MockStackOverflowManagerDelegate.h"
#import "MockStackOverflowCommunicator.h"
#import "Answer.h"
#import "Question.h"

@interface AnswerCreationWorkflowTests : XCTestCase

@property FakeAnswerBuilder *answerBuilder;
@property StackOverflowManager *mgr;
@property MockStackOverflowManagerDelegate *delegate;
@property MockStackOverflowCommunicator *communicator;
@property NSError *underlyingError;
@property Question *question;

@end

@implementation AnswerCreationWorkflowTests

- (void)setUp
{
    _mgr = [[StackOverflowManager alloc] init];
    _delegate = [[MockStackOverflowManagerDelegate alloc] init];
    _mgr.delegate = _delegate;
    
    _answerBuilder = [[FakeAnswerBuilder alloc] init];
    _mgr.answerBuilder = _answerBuilder;
    _communicator = [[MockStackOverflowCommunicator alloc] init];
    _mgr.communicator = _communicator;
    
    _underlyingError = [NSError errorWithDomain:@"Test Domain" code:0 userInfo:nil];
    
    _question = [[Question alloc] init];
    _question.questionID = 1234;
    
}

- (void)tearDown
{
    _mgr = nil;
    _delegate = nil;
    _communicator = nil;
    _underlyingError = nil;
    _question = nil;
}

- (void)testNonCOnformingOBjectCannotBeDelegate
{
    XCTAssertNoThrow(_mgr.delegate = _delegate, @"Object conforming to the delegate protocol should be used as the delegate");
}

- (void)testManagerAcceptsNilAsADelegate
{
    XCTAssertNoThrow(_mgr.delegate = nil, @"It should be acceptable to use nil as an object's delegate");
}

- (void)testAskingForAnswersMeansCommunicatingWithSite
{
    Question *question = [[Question alloc] init];
    [_mgr fetchAnswersForQuestion:question];
    XCTAssertTrue([_communicator wasAskedToFetchAnswers], @"The communicator should need to fetch answers");
}

- (void)testDelegateNotifiedOfFailureToGetAnswers
{
    [_mgr fetchingQuestionAnswersFailedWithError:_underlyingError];
    XCTAssertFalse(_underlyingError == [_delegate fetchError], @"Error should be at the correct level of abstraction");
}

- (void)testManagerRemembersWhichQuestionToAddAnswersTo
{
    [_mgr fetchAnswersForQuestion:_question];
    XCTAssertEqualObjects(_mgr.questionNeedingAnswers, _question, @"Manager should know how to retrieve answers");
}

- (void)testAnswerResponseJSONIsPassedToQuestionBuilder
{
    [_mgr receivedAnswerJSON: @"Fake JSON"];
    XCTAssertEqualObjects(_answerBuilder.JSON, @"Fake JSON", @"Downloaded JSON is set to the builder");
}

- (void)testQuestionPassedToAnswerBuilder
{
    _mgr.questionNeedingAnswers = _question;
    [_mgr receivedAnswerJSON:@"Fake JSON"];
    XCTAssertEqualObjects(_answerBuilder.questionNeedingAnswers, _question, @"Manager must pass question to answer builder");
}

- (void)testManagerNotifiesDelegateWhenAnswersAdded
{
    _answerBuilder.successful = YES;
    _mgr.questionNeedingAnswers = _question;
    [_mgr receivedAnswerJSON:@"Fake JSON"];
    XCTAssertEqualObjects(_delegate.questionWithAnswers, _question, @"Manager should call the delegate method");
}

- (void)testManagerNotifiesDelegateWhenAnswersNotAdded
{
    _answerBuilder.successful = NO;
    _answerBuilder.error = _underlyingError;
    [_mgr receivedAnswerJSON:@"Fake JSON"];
    XCTAssertEqualObjects([[_delegate.fetchError userInfo] objectForKey:NSUnderlyingErrorKey], _underlyingError, @"Manager should pass an error on to the delegate");
}


@end
