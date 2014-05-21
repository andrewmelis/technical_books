//
//  QuestionCreationTests.m
//  BrowseOverflow
//
//  Created by Andrew Melis on 3/29/14.
//  Copyright (c) 2014 Baller Status Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "StackOverflowManager.h"
#import "MockStackOverflowManagerDelegate.h"
#import "MockStackOverflowCommunicator.h"
#import "FakeQuestionBuilder.h"
#import "Topic.h"
#import "Question.h"

@interface QuestionCreationWorkflowTests : XCTestCase

@end

@implementation QuestionCreationWorkflowTests
{
@private
    StackOverflowManager *mgr;
    MockStackOverflowManagerDelegate *delegate;
    NSError *underlyingError;
    FakeQuestionBuilder *questionBuilder;
    NSArray *questionArray;
    Question *questionToFetch;
    MockStackOverflowCommunicator *communicator;
}

- (void)setUp
{
    mgr = [[StackOverflowManager alloc] init];
    delegate = [[MockStackOverflowManagerDelegate alloc] init];
    mgr.delegate = delegate;
    underlyingError = [NSError errorWithDomain: @"Test Domain" code: 0 userInfo: nil];
    questionBuilder = [[FakeQuestionBuilder alloc] init];
    mgr.questionBuilder = questionBuilder;
    
    questionToFetch = [[Question alloc] init];
    questionToFetch.questionID = 1234;
    questionArray = [NSArray arrayWithObject:questionToFetch];
    
    communicator = [[MockStackOverflowCommunicator alloc] init];
    mgr.communicator = communicator;
}

- (void)tearDown
{
    mgr = nil;
    delegate = nil;
    underlyingError = nil;
    questionBuilder = nil;
    questionArray = nil;
    questionToFetch = nil;
    communicator = nil;
}

- (void)testConformingObjectCanBeDelegate
{
    XCTAssertNoThrow(mgr.delegate = delegate, @"Object conforming to the delegate protocol should be used as the delegate");
}

- (void)testManagerAcceptsNilAsADelegate
{
    XCTAssertNoThrow(mgr.delegate = nil, @"It should be acceptable to use nil as an object's delegate");
}

- (void)testAskingForQuestionsMeansRequestingData
{
    Topic *topic = [[Topic alloc] initWithName: @"iPhone" tag: @"iphone"];
    [mgr fetchQuestionsOnTopic: topic];
    XCTAssertTrue([communicator wasAskedToFetchQuestions], @"The communicator should need to fetch data.");
    
}

- (void)testErrorReturnedToDelegateIsNotErrorNotifiedByCommunicator
{
    [mgr searchingForQuestionsFailedWithError: underlyingError];
    XCTAssertFalse(underlyingError == [delegate fetchError], @"Error should be at the correct level of abstraction");
}

- (void)testErrorReturnedToDelegateDocumentsUnderlyingError
{
    [mgr searchingForQuestionsFailedWithError: underlyingError];
    XCTAssertEqualObjects([[[delegate fetchError] userInfo] objectForKey: NSUnderlyingErrorKey], underlyingError, @"The underlying error should be available to client code");
}

- (void)testQuestionJSONIsPassedToQuestionBuilder
{
    [mgr receivedQuestionsJSON: @"Fake JSON"];
    XCTAssertEqualObjects(questionBuilder.JSON, @"Fake JSON", @"Downloaded JSON is set to the builder");
}

- (void)testDelegateNotifiedOfErrorWhenQuestionBuilderFails
{
    questionBuilder.arrayToReturn = nil;
    questionBuilder.errorToSet = underlyingError;
    [mgr receivedQuestionsJSON: @"Fake JSON"];
    XCTAssertNotNil([[[delegate fetchError] userInfo] objectForKey: NSUnderlyingErrorKey], @"The delegate should have found out about the error" );
}

- (void)testDelegateNotToldAboutErrorWhenQuestionReceived
{
    questionBuilder.arrayToReturn = questionArray;
    [mgr receivedQuestionsJSON: @"Fake JSON"];
    XCTAssertNil([delegate fetchError], @"No error should be received on success");
}

- (void)testDelegateReceivesTheQuestionsDiscoveredByManager
{
    questionBuilder.arrayToReturn = questionArray;
    [mgr receivedQuestionsJSON: @"Fake JSON"];
    XCTAssertEqualObjects([delegate receivedQuestions], questionArray, @"The manager should have sent its questions to the delegate");
}

- (void)testEmptyArrayIsPassedToDelegate
{
    questionBuilder.arrayToReturn = [NSArray array];
    [mgr receivedQuestionsJSON:@"Fake JSON"];
    XCTAssertEqualObjects([delegate receivedQuestions], [NSArray array], @"Return an empty array is not an error");
}

- (void)testAskingForQuestionBodyMeansRequestingData
{
    [mgr fetchBodyForQuestion:questionToFetch];
    XCTAssertTrue([communicator wasAskedToFetchBody], @"The communicator should need to retrieve data for the question body");
}

- (void)testDelegateNotifiedOfFailureToFetchQuestion
{
    [mgr fetchingQuestionBodyFailedWithError:underlyingError];
    XCTAssertNotNil([[[delegate fetchError] userInfo] objectForKey:NSUnderlyingErrorKey], @"Delegate should have found out about this error");
}

- (void)testManagerPassesRetrievedQuestionBodyToQuestionBuilder

{
    [mgr receivedQuestionBodyJSON:@"Fake JSON"];
    XCTAssertEqualObjects(questionBuilder.JSON, @"Fake JSON", @"Successfully-retrieved data should be passed to the builder");
}

- (void)testManagerPassesQuestionItWasSentToQuestionBuilderForFillingIn
{
    [mgr fetchBodyForQuestion:questionToFetch];
    [mgr receivedQuestionBodyJSON:@"Fake JSON"];
    XCTAssertEqualObjects(questionBuilder.questionToFill, questionToFetch, @"The question should have been passed to the builder");
}

@end
