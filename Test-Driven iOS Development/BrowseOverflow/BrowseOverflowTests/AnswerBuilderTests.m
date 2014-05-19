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

@interface AnswerBuilderTests : XCTestCase

@property AnswerBuilder *answerBuilder;
@property Answer *answer;

@end

@implementation AnswerBuilderTests

static NSString *answerJSON =
@"{\"items\":[{\"owner\":{\"reputation\":2739,\"user_id\":1050482,\"user_type\":\"registered\",\"accept_rate\":93,\"profile_image\":\"http://i.stack.imgur.com/b25Fd.jpg?s=128&g=1\",\"display_name\":\"Paul Cezanne\",\"link\":\"http://stackoverflow.com/users/1050482/paul-cezanne\"},\"is_accepted\":true,\"score\":0,\"last_activity_date\":1400189815,\"creation_date\":1400189815,\"answer_id\":23689131,\"question_id\":23685631,\"body\":\"<p>Use a web proxy</p>\"},{\"owner\":{\"reputation\":1983,\"user_id\":3060469,\"user_type\":\"registered\",\"accept_rate\":100,\"profile_image\":\"http://i.stack.imgur.com/HyOEr.jpg?s=128&g=1\",\"display_name\":\"Samkit Jain\",\"link\":\"http://stackoverflow.com/users/3060469/samkit-jain\"},\"is_accepted\":false,\"score\":0,\"last_activity_date\":1400180163,\"creation_date\":1400180163,\"answer_id\":23686513,\"question_id\":23685631,\"body\":\"<p>Set iadBanner delegate to self</p>\\n\"}],\"has_more\":false,\"quota_max\":300,\"quota_remaining\":247}";

- (void)setUp
{
    _answerBuilder = [[AnswerBuilder alloc] init];
    _answer = [[Answer alloc] init];
}

- (void)tearDown
{
    _answerBuilder = nil;
    _answer = nil;
}

- (void)testExample
{
    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

@end
