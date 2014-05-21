//
//  AnswerBuilder.h
//  BrowseOverflow
//
//  Created by Andrew Melis on 5/19/14.
//  Copyright (c) 2014 Baller Status Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Question;

@interface AnswerBuilder : NSObject

- (BOOL)addAnswersToQuestion:(Question *)question fromJSON:(NSString *)objectNotation error:(NSError **)error;

@end
