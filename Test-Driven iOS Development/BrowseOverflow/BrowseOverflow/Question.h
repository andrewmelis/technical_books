//
//  Question.h
//  BrowseOverflow
//
//  Created by Andrew Melis on 3/16/14.
//  Copyright (c) 2014 Baller Status Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Answer;

@interface Question : NSObject
{
    NSMutableSet *answerSet;
}

@property NSDate *date;
@property NSString *title;
@property NSInteger score;
@property (readonly) NSArray *answers;

- (void)addAnswer: (Answer *)answer;
- (NSArray *)answers;




@end
