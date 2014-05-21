//
//  FakeAnswerBuilder.m
//  BrowseOverflow
//
//  Created by Andrew Melis on 5/21/14.
//  Copyright (c) 2014 Baller Status Inc. All rights reserved.
//

#import "FakeAnswerBuilder.h"

@implementation FakeAnswerBuilder

- (BOOL)addAnswersToQuestion:(Question *)question fromJSON:(NSString *)objectNotation error:(NSError **)error
{
    _JSON = objectNotation;
    if (question) {
        _questionNeedingAnswers = question;
    }
    
    if (error) {
        *error = _error;
    }
    
    return _successful;
}

@end
