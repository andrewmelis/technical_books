//
//  Topic.m
//  BrowseOverflow
//
//  Created by Andrew Melis on 3/16/14.
//  Copyright (c) 2014 Baller Status Inc. All rights reserved.
//

#import "Topic.h"
#import "Question.h"

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

- (NSArray *)sortedQuestionsLatestFirst: (NSArray *)questionList
{
    return [questions sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2)
    {
        Question *q1 = (Question *)obj1;
        Question *q2 = (Question *)obj2;
        return [q2.date compare: q1.date];
    }];
}

- (NSArray *)recentQuestions {
    return [self sortedQuestionsLatestFirst:questions];
}

- (void)addQuestion: (Question *)question
{
    NSArray *newQuestions = [questions arrayByAddingObject:question];
    newQuestions = [self reduceQuestionListToMaxSize:newQuestions];
    questions = newQuestions;
}

- (NSArray *)reduceQuestionListToMaxSize: (NSArray *)questionList
{
    if ([questionList count] > 20) {
        questionList = [self sortedQuestionsLatestFirst:questionList];
        questionList = [questionList subarrayWithRange:NSMakeRange(0, 20)];
    }
    return questionList;
}

@end
