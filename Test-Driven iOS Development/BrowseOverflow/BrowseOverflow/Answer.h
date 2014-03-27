//
//  Answer.h
//  BrowseOverflow
//
//  Created by Andrew Melis on 3/17/14.
//  Copyright (c) 2014 Baller Status Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Person;

@interface Answer : NSObject

@property NSString *text;
@property Person *person;
@property NSInteger score;
@property (getter = isAccepted) Boolean accepted;

- (NSComparisonResult)compare:(Answer *)otherAnswer;

@end
