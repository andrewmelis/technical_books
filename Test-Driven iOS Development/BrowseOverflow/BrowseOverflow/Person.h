//
//  Person.h
//  BrowseOverflow
//
//  Created by Andrew Melis on 3/17/14.
//  Copyright (c) 2014 Baller Status Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (readonly) NSString *name;
@property (readonly) NSURL *avatarURL;

- (id) initWithName:(NSString *)aName avatarLocation:(NSString *)location;

@end
