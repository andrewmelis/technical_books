//
//  Topic.h
//  BrowseOverflow
//
//  Created by Andrew Melis on 3/16/14.
//  Copyright (c) 2014 Baller Status Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Topic : NSObject

@property (readonly) NSString *name;
@property (readonly) NSString *tag;

-(id)initWithName:(NSString *)newName tag:(NSString *)newTag;
-(NSArray *) recentQuestions;

@end
