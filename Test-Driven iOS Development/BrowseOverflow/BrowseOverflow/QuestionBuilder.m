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
    NSDictionary *parsedObject = [self buildValidJSONDictionaryFromObjectNotation:objectNotation error:error];
    
    NSArray *jsonQuestions;
    jsonQuestions = [parsedObject objectForKey:@"questions"];
    if (jsonQuestions == nil ) {
        [self setError:error withCode:QuestionBuilderMissingDataError];
    }
    
    //this is super ugly -- how else to break out of private methods if there's an error?
    if (error != NULL) {
        return nil;
    } else {
        return [self createQuestionsArrayFrom:jsonQuestions];
    }
    
//    return (&error != NULL) ? nil : [self createQuestionsArrayFrom:jsonQuestions];
}

- (NSDictionary *)buildValidJSONDictionaryFromObjectNotation:(NSString *)objectNotation error:(NSError **)error
{
    NSParameterAssert(objectNotation != nil);
    NSData *unicodeNotation = [objectNotation dataUsingEncoding:NSUTF8StringEncoding];
    NSError *localError;
    
    id jsonObject = [NSJSONSerialization JSONObjectWithData:unicodeNotation options:0 error:&localError];
    
    NSDictionary *parsedObject = (id)jsonObject;
    if (parsedObject == nil ) {
        [self setError:error withCode:QuestionBuilderInvalidJSONError];
    }
    return parsedObject;
}

- (void)setError:(NSError **)error withCode:(NSInteger)errorCode
{
    if (error != NULL) {
        *error = [NSError errorWithDomain:QuestionBuilderErrorDomain code:errorCode userInfo:nil];
    }
}

- (NSMutableArray *)createQuestionsArrayFrom:(NSArray *)jsonQuestions
{
    NSMutableArray *questions = [[NSMutableArray alloc] initWithCapacity:[jsonQuestions count]];
    
    for (NSDictionary *parsedQuestion in jsonQuestions) {
        //create local question type
        Question *thisQuestion = [[Question alloc] init];
        thisQuestion.date = [parsedQuestion objectForKey:@"creation_date"];
        thisQuestion.title = [parsedQuestion objectForKey:@"title"];
        thisQuestion.score = [[parsedQuestion objectForKey:@"score"] integerValue];
        
        [questions addObject:thisQuestion];
    }
    NSLog(@"how many objects in questions? %d", [questions count]);
    return questions;
    
}


@end
