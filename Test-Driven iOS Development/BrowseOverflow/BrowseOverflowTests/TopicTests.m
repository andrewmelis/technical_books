//
//  TopicTests.m
//  BrowseOverflow
//
//  Created by Andrew Melis on 3/16/14.
//  Copyright (c) 2014 Baller Status Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Topic.h"

@interface TopicTests : XCTestCase {
    Topic *topic;
}

@end

@implementation TopicTests

- (void)setUp
{
    topic = [[Topic alloc] initWithName: @"iPhone" tag: @"iphone"];
}

- (void)tearDown
{
    topic = nil;
}

- (void)testThatTopicExists
{

    XCTAssertNotNil(topic, @"should be able to create a Topic instance");
}

- (void)testThatTopicCanBeName
{
    XCTAssertEqualObjects(topic.name, @"iPhone", @"the Topic should have the name I gave it");
}

- (void)testThatTopicHasATag
{
    XCTAssertEqualObjects(topic.tag, @"iphone", @"Topics need to have tags");
}

- (void)testForAListOfQuestions
{
    XCTAssertTrue([[topic recentQuestions] isKindOfClass: [NSArray class]], @"Topics should provide a list of recent questions");
}

@end
