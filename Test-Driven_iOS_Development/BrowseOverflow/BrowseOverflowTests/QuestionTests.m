//
//  QuestionTests.m
//  BrowseOverflow
//
//  Created by Andrew Melis on 3/16/14.
//  Copyright (c) 2014 Baller Status Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Question.h"
#import "Answer.h"
#import "Person.h"

@interface QuestionTests : XCTestCase
{
    Question *question;
    Answer *lowScore;
    Answer *highScore;
    Person *asker;
}

@end

@implementation QuestionTests

- (void)setUp
{
    question = [[Question alloc] init];
    question.date = [NSDate distantPast];
    question.title = @"Do iPhones also dream of electric sheep?";
    question.score = 42;
    
    Answer *accepted = [[Answer alloc] init];
    accepted.score = 1;
    accepted.accepted = YES;
    [question addAnswer: accepted];
    
    lowScore = [[Answer alloc] init];
    lowScore.score = -4;
    [question addAnswer: lowScore];
    
    highScore = [[Answer alloc] init];
    highScore.score = 4;
    [question addAnswer: highScore];
    
    asker = [[Person alloc] initWithName:@"Graham Lee" avatarLocation:@"http://example.com/avatar.png"];
    question.asker = asker;
}

- (void)tearDown
{
    question = nil;
    lowScore = nil;
    highScore = nil;
}

- (void)testQuestionHasADate
{
    NSDate *testDate = [NSDate distantPast];
    question.date = testDate;
    XCTAssertEqualObjects(question.date, testDate, @"Question needs to provide its date");
}

- (void)testQuestionsKeepScore
{
    XCTAssertEqual(question.score, 42, @"Questions need a numeric score");
}

- (void) testQuestionHasATitle
{
    XCTAssertEqualObjects(question.title, @"Do iPhones also dream of electric sheep?", @"Question should know its title");
}

- (void)testQuestionCanHaveAnswerAdded
{
    Answer *myAnswer = [[Answer alloc] init];
    XCTAssertNoThrow([question addAnswer:myAnswer], @"Must be able to add answer");
}

- (void)testAcceptedAnswerIsFirst
{
    XCTAssertTrue([[question.answers objectAtIndex:0] isAccepted], @"Accepted answer comes first");
}

- (void)testHighScoreAnswerBeforeLow
{
    NSArray *answers = question.answers;
    NSInteger highIndex = [answers indexOfObject:highScore];
    NSInteger lowIndex = [answers indexOfObject:lowScore];
    XCTAssertTrue(highIndex < lowIndex , @"High-scoring answer comes first");
}

- (void)testQuestionWasAskedBySomeone
{
    XCTAssertEqualObjects(question.asker, asker, @"Question should keep track of who asked it");
}

@end
