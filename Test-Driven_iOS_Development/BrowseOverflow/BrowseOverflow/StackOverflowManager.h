//
//  StackOverflowManager.h
//  BrowseOverflow
//
//  Created by Andrew Melis on 3/29/14.
//  Copyright (c) 2014 Baller Status Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StackOverflowManagerDelegate.h"
#import "StackOverflowCommunicator.h"
#import "QuestionBuilder.h"
#import "AnswerBuilder.h"

@class Topic;
@class Question;

@interface StackOverflowManager : NSObject

@property (strong) AnswerBuilder *answerBuilder;
@property (weak,nonatomic) id<StackOverflowManagerDelegate> delegate;
@property (strong) StackOverflowCommunicator *communicator;
@property (strong) QuestionBuilder *questionBuilder;
@property (strong) Question *questionNeedingBody;
@property (strong) Question *questionNeedingAnswers;

- (void)receivedQuestionsJSON:(NSString *)objectNotation;
- (void)fetchQuestionsOnTopic: (Topic *)topic;
- (void)searchingForQuestionsFailedWithError:(NSError *)error;
- (void)fetchBodyForQuestion:(Question *)question;
- (void)fetchingQuestionBodyFailedWithError:(NSError *)error;
- (void)receivedQuestionBodyJSON:(NSString *)objectNotation;
- (void)fetchAnswersForQuestion:(Question *)question;
- (void)fetchingQuestionAnswersFailedWithError:(NSError *)error;
- (void)receivedAnswerJSON:(NSString *)objectNotation;

extern NSString *StackOverflowManagerError;

enum
{
    StackOverflowManagerErrorQuestionSearchCode,
    StackOverflowManagerErrorQuestionBodyFetchCode,
    StackOverflowManagerErrorAnswerFetchCode
};

@end
