//
//  QuestionBuilder.m
//  BrowseOverflow
//
//  Created by Andrew Melis on 4/4/14.
//  Copyright (c) 2014 Baller Status Inc. All rights reserved.
//

#import "QuestionBuilder.h"
#import "Question.h"

@implementation QuestionBuilder

NSString *QuestionBuilderErrorDomain = @"QuestionBuilderErrorDomain";

- (NSArray *)questionsFromJSON:(NSString *)objectNotation error:(NSError **)error
{
    NSParameterAssert(objectNotation != nil);
    NSData *unicodeNotation = [objectNotation dataUsingEncoding:NSUTF8StringEncoding];
    NSError *localError;
    
    id jsonObject = [NSJSONSerialization JSONObjectWithData:unicodeNotation options:0 error:&localError];
    
    NSDictionary *parsedObject = (id)jsonObject;
    if (parsedObject == nil) {
        if (error != NULL) {
            *error = [NSError errorWithDomain:QuestionBuilderErrorDomain code:QuestionBuilderInvalidJSONError userInfo:nil];
        }
    }
    
    NSArray *jsonQuestions = [parsedObject objectForKey:@"items"];  //should name jsonItems?
    if (jsonQuestions == nil) {
        if (error != NULL) {
            *error = [NSError errorWithDomain:QuestionBuilderErrorDomain code:QuestionBuilderMissingDataError userInfo:nil];
        }
        return nil;
    }
    
    return [self createQuestionsArrayFrom:jsonQuestions];

}


- (NSMutableArray *)createQuestionsArrayFrom:(NSArray *)jsonQuestions
{
    NSMutableArray *questions = [[NSMutableArray alloc] initWithCapacity:[jsonQuestions count]];
    
    for (NSDictionary *parsedQuestion in jsonQuestions) {
        //create local question type
        Question *thisQuestion = [[Question alloc] init];
        thisQuestion.date = [NSDate dateWithTimeIntervalSince1970:[[parsedQuestion objectForKey:@"creation_date"] doubleValue]];
        thisQuestion.title = [parsedQuestion objectForKey:@"title"];
        thisQuestion.score = [[parsedQuestion objectForKey:@"score"] integerValue];
        
        [questions addObject:thisQuestion];
    }
    
    return questions;
}


@end
