//
//  MockStackOverflowCommunicator.m
//  BrowseOverflow
//
//  Created by Andrew Melis on 3/29/14.
//  Copyright (c) 2014 Baller Status Inc. All rights reserved.
//

#import "MockStackOverflowCommunicator.h"
#import "StackOverflowCommunicator.h"

@implementation MockStackOverflowCommunicator
{
    BOOL wasAskedToFetchQuestions;
    BOOL wasAskedToFetchBody;
    BOOL wasAskedToFetchAnswers;
}

- (void)searchForQuestionsWithTag:(NSString *)tag
{
    wasAskedToFetchQuestions = YES;
}

- (BOOL)wasAskedToFetchQuestions 
{
    return wasAskedToFetchQuestions;
}

- (void)downloadInformationForQuestionWithID:(NSInteger)identifier
{
    wasAskedToFetchBody = YES;
}

- (BOOL)wasAskedToFetchBody
{
    return wasAskedToFetchBody;
}

- (void)searchForAnswersForQuestionWithID:(NSInteger)questionID
{
    wasAskedToFetchAnswers = YES;
}

- (BOOL)wasAskedToFetchAnswers
{
    return wasAskedToFetchAnswers;
}

@end
