//
//  MockStackOverflowManagerDelegate.m
//  BrowseOverflow
//
//  Created by Andrew Melis on 3/29/14.
//  Copyright (c) 2014 Baller Status Inc. All rights reserved.
//

#import "MockStackOverflowManagerDelegate.h"

@implementation MockStackOverflowManagerDelegate

- (void) fetchingQuestionsFailedWithError: (NSError *)error
{
    _fetchError = error;
}

- (void) didReceiveQuestions:(NSArray *)questions
{
    _receivedQuestions = questions;
}

@end
