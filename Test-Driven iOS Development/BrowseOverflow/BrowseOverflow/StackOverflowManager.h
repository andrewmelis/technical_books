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

@class Topic;
@class Question;

@interface StackOverflowManager : NSObject

@property (weak,nonatomic) id<StackOverflowManagerDelegate> delegate;
@property (strong) StackOverflowCommunicator *communicator;
@property (strong) QuestionBuilder *questionBuilder;
@property (strong) Question *questionNeedingBody;

- (void)receivedQuestionsJSON:(NSString *)objectNotation;
- (void)fetchQuestionsOnTopic: (Topic *)topic;
- (void)searchingForQuestionsFailedWithError:(NSError *)error;
- (void)fetchBodyForQuestion:(Question *)question;
- (void)fetchingQuestionBodyFailedWithError:(NSError *)error;
- (void)receivedQuestionBodyJSON:(NSString *)objectNotation;

extern NSString *StackOverflowManagerError;

enum
{
    StackOverflowManagerErrorQuestionSearchCode,
    StackOverflowManagerErrorQuestionBodyFetchCode
};

@end
