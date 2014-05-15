//
//  QuestionBuilder.h
//  BrowseOverflow
//
//  Created by Andrew Melis on 4/4/14.
//  Copyright (c) 2014 Baller Status Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionBuilder : NSObject

- (NSArray *)questionsFromJSON: (NSString *)objectNotation error: (NSError **)error;

extern NSString *QuestionBuilderErrorDomain;

enum
{
    QuestionBuilderInvalidJSONError,
    QuestionBuilderMissingDataError,
};

@end
