//
//  QuestionBuilderTests.m
//  BrowseOverflow
//
//  Created by Andrew Melis on 5/15/14.
//  Copyright (c) 2014 Baller Status Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "QuestionBuilder.h"
#import "Question.h"

@interface QuestionBuilderTests : XCTestCase

@end

@implementation QuestionBuilderTests
{
@private
    QuestionBuilder *questionBuilder;
    Question *question;
}

static NSString *questionJSON =
@"{\"tags\":[\"ios\",\"iphone\",\"iads\"],\"owner\":{\"reputation\":106,\"user_id\":3597877,\"user_type\":\"registered\",\"profile_image\":\"http://i.stack.imgur.com/1r3pH.png?s=128&g=1\",\"display_name\":\"GlennRay\",\"link\":\"http://stackoverflow.com/users/3597877/glennray\"},\"is_answered\":false,\"view_count\":13,\"answer_count\":1,\"score\":0,\"last_activity_date\":1400180163,\"creation_date\":1400177211,\"question_id\":23685631,\"link\":\"http://stackoverflow.com/questions/23685631/how-can-i-tell-if-iads-are-being-requested\",\"title\":\"How can I tell if iAds are being requested?\"}";

- (void)setUp
{
    questionBuilder = [[QuestionBuilder alloc] init];
    question = [[questionBuilder questionsFromJSON:questionJSON error:NULL] objectAtIndex:0];
}

- (void)tearDown
{
    questionBuilder = nil;
    question = nil;
}

- (void)testThatNilIsNotAnAcceptableParameter
{
    XCTAssertThrows([questionBuilder questionsFromJSON:nil error:NULL], @"Lack of data should have been handled elsewhere");
}

- (void)testNilReturnedWhenStringIsNotJSON
{
    XCTAssertNil([questionBuilder questionsFromJSON:@"Not JSON" error:NULL
                  ], @"This parameter should not be parseable");
}

- (void)testErrorSetWhenStringIsNotJSON
{
    NSError *error = nil;
    [questionBuilder questionsFromJSON:@"Not JSON" error:&error];
    XCTAssertNotNil(error, @"An error occurred, we should be told");
}

- (void)testPassingNullErrorDoesNotCauseCrash
{
    XCTAssertNoThrow([questionBuilder questionsFromJSON:@"Not JSON" error:NULL], @"Using a NULL error parameter should not be a problem");
}

- (void)testRealJSONWithoutQuestionsArrayReturnsMissingDataError
{
    NSString *jsonString = @"{ \"noquestions\": true}";
    NSError *error = nil;
    [questionBuilder questionsFromJSON:jsonString error:&error];
    XCTAssertEqual([error code], QuestionBuilderMissingDataError, @"This case should not be an invalid JSON error");
}

- (void)testJSONWithOneQuestionReturnsOneQuestionObject
{
    NSError *error = nil;
    NSArray *questions = [questionBuilder questionsFromJSON:questionJSON error:&error];
    XCTAssertEqual([questions count], (NSUInteger)1, @"The builder should have created a question");
}

@end
