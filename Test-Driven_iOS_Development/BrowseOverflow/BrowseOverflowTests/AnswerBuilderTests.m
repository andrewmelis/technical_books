//
//  AnswerBuilderTests.m
//  BrowseOverflow
//
//  Created by Andrew Melis on 5/19/14.
//  Copyright (c) 2014 Baller Status Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AnswerBuilder.h"
#import "Answer.h"
#import "Question.h"
#import "Person.h"

@interface AnswerBuilderTests : XCTestCase

@property AnswerBuilder *answerBuilder;
@property Answer *answer;
@property Question *question;

@end

@implementation AnswerBuilderTests

static NSString *answerJSON =
@"{\"items\":[{\"owner\":{\"reputation\":2739,\"user_id\":1050482,\"user_type\":\"registered\",\"accept_rate\":93,\"profile_image\":\"http://i.stack.imgur.com/b25Fd.jpg?s=128&g=1\",\"display_name\":\"Paul Cezanne\",\"link\":\"http://stackoverflow.com/users/1050482/paul-cezanne\"},\"is_accepted\":true,\"score\":10,\"last_activity_date\":1400189815,\"creation_date\":1400189815,\"answer_id\":23689131,\"question_id\":23685631,\"body\":\"<p>Use a web proxy</p>\"},{\"owner\":{\"reputation\":1983,\"user_id\":3060469,\"user_type\":\"registered\",\"accept_rate\":100,\"profile_image\":\"http://i.stack.imgur.com/HyOEr.jpg?s=128&g=1\",\"display_name\":\"Samkit Jain\",\"link\":\"http://stackoverflow.com/users/3060469/samkit-jain\"},\"is_accepted\":false,\"score\":-1,\"last_activity_date\":1400180163,\"creation_date\":1400180163,\"answer_id\":23686513,\"question_id\":23685631,\"body\":\"<p>Set iadBanner delegate to self</p>\\n\"}],\"has_more\":false,\"quota_max\":300,\"quota_remaining\":247}";

static NSString *stringIsNotJSON = @"Not JSON";
static NSString *noAnswersJSONString = @"{ \"noanswers\": true }";
static NSString *emptyQuestionsArray = @"{ \"items\": [] }";

- (void)setUp
{
    _answerBuilder = [[AnswerBuilder alloc] init];
    _answer = [[Answer alloc] init];
    _question = [[Question alloc] init];
}

- (void)tearDown
{
    _answerBuilder = nil;
    _answer = nil;
    _question = nil;
}

- (void)testThatNilIsNotAnAcceptableParameter
{
    XCTAssertThrows([_answerBuilder addAnswersToQuestion:_question fromJSON:nil error:NULL], @"Not receiving data should have been handled earlier");
}

- (void)testAddingAnswersToNilQuestionCannotBeTried
{
    XCTAssertThrows([_answerBuilder addAnswersToQuestion:nil fromJSON:@"Fake JSON" error:NULL], @"No reason to expect that a nil question is passed");
}

- (void)testSendingNonJSONIsAnError
{
    NSError *error = nil;
    [_answerBuilder addAnswersToQuestion:_question fromJSON:stringIsNotJSON error:&error];
    XCTAssertEqual([error code], AnswerBuilderInvalidJSONError, @"This case should be an AnswerBuilder error");
}

- (void)testErrorParameterMayBeNull
{
    XCTAssertNoThrow([_answerBuilder addAnswersToQuestion:_question fromJSON:stringIsNotJSON error:NULL], @"Answer Builder should handle null error pointer gracefully");
}

- (void)testSendingJSONWithIncorrectKeysIsAnError
{
    NSError *error = nil;
    XCTAssertFalse([_answerBuilder addAnswersToQuestion:_question fromJSON:noAnswersJSONString error:&error], @"There must be at least one answer");
}

- (void)testSendingRealJSONIsNotAnError
{
    XCTAssertTrue([_answerBuilder addAnswersToQuestion:_question fromJSON:answerJSON error:NULL], @"passing real JSON should not throw an error");
}

- (void)testNumberOfAnswersAddedMatchesNumberInData
{
    [_answerBuilder addAnswersToQuestion:_question fromJSON:answerJSON error:NULL];
    XCTAssertEqual([_question.answers count], (NSUInteger)2, @"Two answers should be added");
}

- (void)testAnswerPropertiesMatchDataReceived
{
    [_answerBuilder addAnswersToQuestion:_question fromJSON:answerJSON error:NULL];
    Answer *answer = [_question.answers objectAtIndex:0];
    XCTAssertEqual(answer.score, (NSUInteger)10, @"Score should match data");
    XCTAssertEqual(answer.accepted, YES, @"Accepted status should match data");
    XCTAssertEqualObjects(answer.text, @"<p>Use a web proxy</p>", @"Body text should be added");
}

- (void)testAnswererMatchesDataReceived
{
    [_answerBuilder addAnswersToQuestion:_question fromJSON:answerJSON error:NULL];
    Answer *answer = [_question.answers objectAtIndex:0];
    Person *answerer = [[Person alloc] initWithName:@"Paul Cezanne" avatarLocation:@""];
    XCTAssertEqualObjects(answer.person.name, answerer.name, @"Asker should match data");
}
@end
