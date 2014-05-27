//
//  MockStackOverflowManagerDelegate.m
//  BrowseOverflow
//
//  Created by Andrew Melis on 3/29/14.
//  Copyright (c) 2014 Baller Status Inc. All rights reserved.
//

#import "MockStackOverflowManagerDelegate.h"

@implementation MockStackOverflowManagerDelegate

- (void)fetchingQuestionsFailedWithError: (NSError *)error
{
    _fetchError = error;
}

- (void)fetchingQuestionBodyFailedWithError:(NSError *)error
{
    _fetchError = error;
}

- (void)didReceiveQuestions:(NSArray *)questions
{
    _receivedQuestions = questions;
}

- (void)bodyReceivedForQuestion:(Question *)question
{
    _bodyQuestion = question;
}

- (void)answersReceivedForQuestion:(Question *)question
{
    _questionWithAnswers = question;
}

- (void)fetchingAnswersFailedWithError:(NSError *)error
{
    _fetchError = error;
}



@end
