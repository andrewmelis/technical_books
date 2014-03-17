//
//  Topic.m
//  BrowseOverflow
//
//  Created by Andrew Melis on 3/16/14.
//  Copyright (c) 2014 Baller Status Inc. All rights reserved.
//

#import "Topic.h"

@implementation Topic
{
    NSArray *questions;
}

- (id)initWithName:(NSString *)newName tag:(NSString *)newTag
{
    if ((self = [super init]))
    {
        _name = [newName copy];
        _tag = [newTag copy];
        questions = [[NSArray alloc] init];

    }
    return self;
}

- (NSArray *)recentQuestions
{
    return [NSArray array];
}

- (void)addQuestion: (Question *)question
{
    questions = [questions arrayByAddingObject:question];
}

@end
