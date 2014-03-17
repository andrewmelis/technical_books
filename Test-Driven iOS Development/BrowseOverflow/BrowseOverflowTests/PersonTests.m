//
//  PersonTests.m
//  BrowseOverflow
//
//  Created by Andrew Melis on 3/17/14.
//  Copyright (c) 2014 Baller Status Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Person.h"

@interface PersonTests : XCTestCase
{
    Person *person;
}
@end

@implementation PersonTests

- (void)setUp
{
    person = [[Person alloc] initWithName: @"Graham Lee" avatarLocation: @"http://example.com/avatar.png"];
}

- (void)tearDown
{
    person = nil;
}

- (void)testThatPersonHasTheRightName {
    XCTAssertEqualObjects(person.name, @"Graham Lee", @"expecting a person to provide its name");
}

- (void)testThatPersonHasAnAvatarURL
{
    NSURL *url = person.avatarURL;
    XCTAssertEqualObjects([url absoluteString], @"http://example.com/avatar.png", @"The Person's avatar should be represented by a URL");
}
@end
