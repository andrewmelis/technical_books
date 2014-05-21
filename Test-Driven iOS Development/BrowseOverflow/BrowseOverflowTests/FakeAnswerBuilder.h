//
//  FakeAnswerBuilder.h
//  BrowseOverflow
//
//  Created by Andrew Melis on 5/21/14.
//  Copyright (c) 2014 Baller Status Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AnswerBuilder.h"

@interface FakeAnswerBuilder : AnswerBuilder

@property (strong) NSError *error;
@property (copy) NSString *JSON;
@property BOOL successful;
@property (strong) Question *questionNeedingAnswers;

@end
