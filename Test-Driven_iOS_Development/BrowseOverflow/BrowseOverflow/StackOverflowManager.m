//
//  StackOverflowManager.m
//  BrowseOverflow
//
//  Created by Andrew Melis on 3/29/14.
//  Copyright (c) 2014 Baller Status Inc. All rights reserved.
//

#import "StackOverflowManager.h"
#import "Topic.h"
#import "Question.h"

@implementation StackOverflowManager

NSString *StackOverflowManagerError = @"StackOverflowManagerError";


- (void)receivedQuestionsJSON:(NSString *)objectNotation {
    NSError *error = nil;
    NSArray *questions = [_questionBuilder questionsFromJSON: objectNotation error: &error];
    if (!questions) {
        [self tellDelegateAboutQuestionSearchError: error];
    } else {
        [_delegate didReceiveQuestions: questions];
    }
}

- (void)setDelegate:(id<StackOverflowManagerDelegate>)delegate
{
    if (delegate && ![delegate conformsToProtocol:@protocol(StackOverflowManagerDelegate)]) {
        [self throwDelegateException];
    }
    _delegate = delegate;
}

-(void)throwDelegateException
{
    [[NSException exceptionWithName:NSInvalidArgumentException reason:@"Delegate object does not conform to the delegate protocol" userInfo:nil]raise];
}

- (void)fetchQuestionsOnTopic:(Topic *)topic
{
    [_communicator searchForQuestionsWithTag:[topic tag]];
}

- (void)searchingForQuestionsFailedWithError:(NSError *)error
{
    [self tellDelegateAboutQuestionSearchError:error];
}

- (void)tellDelegateAboutQuestionSearchError:(NSError *)error {
    NSDictionary *errorInfo = nil;
    if (error) {
        errorInfo = [NSDictionary dictionaryWithObject: error forKey:NSUnderlyingErrorKey];
    }
    NSError *reportableError = [NSError errorWithDomain: StackOverflowManagerError code: StackOverflowManagerErrorQuestionSearchCode userInfo:errorInfo];
    [_delegate fetchingQuestionsFailedWithError:reportableError];
}

- (void)fetchBodyForQuestion:(Question *)question
{
    self.questionNeedingBody = question;
    [_communicator downloadInformationForQuestionWithID:question.questionID];
}

- (void)fetchingQuestionBodyFailedWithError:(NSError *)error
{
    NSDictionary *errorInfo = nil;
    if (error)
    {
        errorInfo = [NSDictionary dictionaryWithObject:error forKey:NSUnderlyingErrorKey];
    }
    NSError *reportableError = [NSError errorWithDomain:StackOverflowManagerError code:StackOverflowManagerErrorQuestionBodyFetchCode userInfo:errorInfo];
    [_delegate fetchingQuestionBodyFailedWithError:reportableError];
    self.questionNeedingBody = nil;
}

- (void)receivedQuestionBodyJSON:(NSString *)objectNotation
{
    [_questionBuilder fillInDetailsForQuestion:_questionNeedingBody fromJSON:objectNotation];
}

- (void)fetchAnswersForQuestion:(Question *)question
{
    self.questionNeedingAnswers = question;
    [_communicator searchForAnswersForQuestionWithID:question.questionID];
}

- (void)fetchingQuestionAnswersFailedWithError:(NSError *)error
{
    NSDictionary *errorInfo = nil;
    if (error)
    {
        errorInfo = [NSDictionary dictionaryWithObject:error forKey:NSUnderlyingErrorKey];
    }
    NSError *reportableError = [NSError errorWithDomain:StackOverflowManagerError code:StackOverflowManagerErrorAnswerFetchCode userInfo:errorInfo];
    [_delegate fetchingAnswersFailedWithError:reportableError];
    self.questionNeedingBody = nil;
}

- (void)receivedAnswerJSON:(NSString *)objectNotation
{
    NSError *error = nil;
    if ([_answerBuilder addAnswersToQuestion:_questionNeedingAnswers fromJSON:objectNotation error:&error])
    {
        [_delegate answersReceivedForQuestion:_questionNeedingAnswers];
        _questionNeedingAnswers = nil;
    }
    else
    {
        [self fetchingQuestionAnswersFailedWithError:error];
    }
}


@end
