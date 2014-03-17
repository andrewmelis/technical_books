//
//  QuestionTests.m
//  BrowseOverflow
//
//  Created by Andrew Melis on 3/16/14.
//  Copyright (c) 2014 Baller Status Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Question.h"

@interface QuestionTests : XCTestCase

@end

@implementation QuestionTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testQuestionHasADate
{
    Question *question = [[Question alloc] init];
    XCTAssertTrue([question.date isKindOfClass: [NSDate class]], @"Question needs to provide its date");
}

@end
