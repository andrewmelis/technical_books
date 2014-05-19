//
//  FakeQuestionBuilder.m
//  BrowseOverflow
//
//  Created by Andrew Melis on 4/4/14.
//  Copyright (c) 2014 Baller Status Inc. All rights reserved.
//

#import "FakeQuestionBuilder.h"

@implementation FakeQuestionBuilder

- (NSArray *)questionsFromJSON:(NSString *)objectNotation error:(NSError **)error
{
    _JSON = objectNotation;
    if (error) {
        *error = _errorToSet;
    }
    return _arrayToReturn;
}

- (void)fillInDetailsForQuestion:(Question *)question fromJSON:(NSString *)objectNotation
{
    _JSON = objectNotation;
    if (question) {
        _questionToFill = question;
    }
}


@end