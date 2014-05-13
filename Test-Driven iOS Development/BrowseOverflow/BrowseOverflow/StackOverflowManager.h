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

@interface StackOverflowManager : NSObject

@property (weak,nonatomic) id<StackOverflowManagerDelegate> delegate;
@property (strong) StackOverflowCommunicator *communicator;
@property (strong) QuestionBuilder *questionBuilder;


extern NSString *StackOverflowManagerError;

enum
{
    StackOverflowManagerErrorQuestionSearchCode
};

- (void)searchingForQuestionsFailedWithError:(NSError *)error;
- (void)fetchQuestionsOnTopic: (Topic *)topic;
- (void)receivedQuestionsJSON:(NSString *)objectNotation;


@end
