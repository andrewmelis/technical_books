//
//  Question.m
//  BrowseOverflow
//
//  Created by Andrew Melis on 3/16/14.
//  Copyright (c) 2014 Baller Status Inc. All rights reserved.
//

#import "Question.h"

@implementation Question


- (id)init
{
    if (self = [super init]) {
        answerSet = [[NSMutableSet alloc] init];
    }
    return self;
}

- (void)addAnswer:(Answer *)answer
{
    [answerSet addObject:answer];
    
}

- (NSArray *)answers
{
    return [[answerSet allObjects] sortedArrayUsingSelector:@selector(compare:)];
}

@end
