//
//  Question.h
//  BrowseOverflow
//
//  Created by Andrew Melis on 3/16/14.
//  Copyright (c) 2014 Baller Status Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Answer;
@class Person;

@interface Question : NSObject
{
    NSMutableSet *answerSet;
}

@property NSDate *date;
@property NSString *title;
@property NSInteger score;
@property NSInteger questionID;
@property (readonly) NSArray *answers;
@property Person *asker;
@property (copy) NSString *body;

- (void)addAnswer: (Answer *)answer;
- (NSArray *)answers;

@end
