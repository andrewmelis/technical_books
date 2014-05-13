//
//  StackOverflowManager.m
//  BrowseOverflow
//
//  Created by Andrew Melis on 3/29/14.
//  Copyright (c) 2014 Baller Status Inc. All rights reserved.
//

#import "StackOverflowManager.h"
#import "Topic.h"

@implementation StackOverflowManager

NSString *StackOverflowManagerError = @"StackOverflowManagerError";


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
    NSDictionary *errorInfo = [NSDictionary dictionaryWithObject:error forKey:NSUnderlyingErrorKey];
    NSError *reportableError = [NSError errorWithDomain:StackOverflowManagerError code:StackOverflowManagerErrorQuestionSearchCode userInfo:errorInfo];
    [self tellDelegateAboutQuestionSearchError: reportableError];
}

- (void)receivedQuestionsJSON:(NSString *)objectNotation {
    NSError *error = nil;
    NSArray *questions = [_questionBuilder questionsFromJSON: objectNotation error: &error];
    if (!questions) {
        NSDictionary *errorInfo = nil;
        if (error) {
            errorInfo = [NSDictionary dictionaryWithObject: error forKey:NSUnderlyingErrorKey];
        }
        NSError *reportableError = [NSError errorWithDomain: StackOverflowManagerError code: StackOverflowManagerErrorQuestionSearchCode userInfo: errorInfo];
        [self tellDelegateAboutQuestionSearchError: reportableError];
    }
}

- (void)tellDelegateAboutQuestionSearchError:(NSError*)error
{
    [_delegate fetchingQuestionsFailedWithError: error];
}


@end
