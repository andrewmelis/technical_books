//
//  AnswerBuilder.h
//  BrowseOverflow
//
//  Created by Andrew Melis on 5/19/14.
//  Copyright (c) 2014 Baller Status Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnswerBuilder : NSObject

- (NSArray *)questionsFromJSON: (NSString *)objectNotation error: (NSError **)error;

@end
