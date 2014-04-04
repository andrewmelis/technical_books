//
//  StackOverflowManagerDelegateProtocol.h
//  BrowseOverflow
//
//  Created by Andrew Melis on 3/29/14.
//  Copyright (c) 2014 Baller Status Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Topic;

@protocol StackOverflowManagerDelegate <NSObject>

- (void) fetchingQuestionsFailedWithError: (NSError *)error;

@end
