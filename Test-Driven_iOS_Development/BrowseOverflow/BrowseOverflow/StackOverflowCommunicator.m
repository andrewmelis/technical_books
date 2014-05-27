//
//  StackOverflowCommunicator.m
//  BrowseOverflow
//
//  Created by Andrew Melis on 3/29/14.
//  Copyright (c) 2014 Baller Status Inc. All rights reserved.
//

#import "StackOverflowCommunicator.h"

@implementation StackOverflowCommunicator

- (void)fetchContentAtURL:(NSURL *)url
{
    fetchingURL = url;
}

- (void)searchForQuestionsWithTag:(NSString *)tag
{
    [self fetchContentAtURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.stackexchange.com/2.2/search?tagged=%@&site=stackoverflow&pagesize=20", tag]]];
}

- (void)downloadInformationForQuestionWithID:(NSInteger)identifier
{
    [self fetchContentAtURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.stackexchange.com/2.2/questions/%d?body=true&site=stackoverflow",identifier]]];
}

- (void)searchForAnswersForQuestionWithID:(NSInteger)questionID
{
    [self fetchContentAtURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.stackexchange.com/2.2/questions/%d/answers?body=true&site=stackoverflow",questionID]]];
}

@end
