//
//  Person.m
//  BrowseOverflow
//
//  Created by Andrew Melis on 3/17/14.
//  Copyright (c) 2014 Baller Status Inc. All rights reserved.
//

#import "Person.h"

@implementation Person

- (id)initWithName:(NSString *)aName avatarLocation:(NSString *)location
{
    if ((self = [super init]))
    {
        _name = [aName copy];
        _avatarURL = [[NSURL alloc] initWithString:location];
    }
    return self;
}




@end
