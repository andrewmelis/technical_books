//
//  AnswerBuilder.m
//  BrowseOverflow
//
//  Created by Andrew Melis on 5/19/14.
//  Copyright (c) 2014 Baller Status Inc. All rights reserved.
//

#import "AnswerBuilder.h"
#import "Question.h"
#import "Answer.h"
#import "PersonBuilder.h"

@implementation AnswerBuilder

NSString *AnswerBuilderErrorDomain = @"AnswerBuilderErrorDomain";

- (BOOL)addAnswersToQuestion:(Question *)question fromJSON:(NSString *)objectNotation error:(NSError *__autoreleasing *)error
{
    NSParameterAssert(question != nil);
    NSParameterAssert(objectNotation != nil);
    
    NSData *unicodeNotation = [objectNotation dataUsingEncoding:NSUTF8StringEncoding];
    NSError *localError;
    
    id jsonObject = [NSJSONSerialization JSONObjectWithData:unicodeNotation options:0 error:&localError];
    
    NSDictionary *parsedObject = (id)jsonObject;
    if (parsedObject == nil) {
        if (error != NULL) {
            *error = [NSError errorWithDomain:AnswerBuilderErrorDomain code:AnswerBuilderInvalidJSONError userInfo:nil];
        }
        return NO;
    }
    
    NSArray *jsonAnswers = [parsedObject objectForKey:@"items"];
    if (jsonAnswers == nil) {
        if (error != NULL) {
            *error = [NSError errorWithDomain:AnswerBuilderErrorDomain code:AnswerBuilderMissingDataError userInfo:nil];
        }
        return NO;
    }
    
    [self addAnswers:jsonAnswers toQuestion:question];
    
    return YES;
}

- (void)addAnswers:(NSArray *)jsonAnswers toQuestion:(Question *)question
{
    NSMutableArray *answers = [self createAnswersArrayFrom:jsonAnswers];
    
    for (Answer *answer in answers) {
        [question addAnswer:answer];
    }
}


- (NSMutableArray *)createAnswersArrayFrom:(NSArray *)jsonAnswers
{
    NSMutableArray *answers = [[NSMutableArray alloc] initWithCapacity:[jsonAnswers count]];
    
    for (NSDictionary *parsedAnswer in jsonAnswers) {
        Answer *thisAnswer = [[Answer alloc] init];
        thisAnswer.score = [[parsedAnswer objectForKey:@"score"] integerValue];
        thisAnswer.accepted = [[parsedAnswer objectForKey:@"is_accepted"] boolValue];
        thisAnswer.text = [parsedAnswer objectForKey:@"body"];
        
        
        NSDictionary *parsedAnswerer = [parsedAnswer objectForKey:@"owner"];
        thisAnswer.person = [PersonBuilder personFromDictionary:parsedAnswerer];
        
        [answers addObject:thisAnswer];
    }
    
    return answers;
}

@end
