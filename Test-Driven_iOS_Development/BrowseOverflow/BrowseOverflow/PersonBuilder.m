//
//  PersonBuilder.m
//  BrowseOverflow
//
//  Created by Andrew Melis on 5/19/14.
//  Copyright (c) 2014 Baller Status Inc. All rights reserved.
//

#import "PersonBuilder.h"
#import "Person.h"

@implementation PersonBuilder


+ (Person *)personFromDictionary:(NSDictionary *)parsedAsker
{
    Person *asker;
    if (parsedAsker != nil) {
        NSString *askerName = [parsedAsker objectForKey:@"display_name"];
        NSString *askerAvatarURLString = [parsedAsker objectForKey:@"profile_image"];
        asker = [[Person alloc] initWithName:askerName avatarLocation: askerAvatarURLString];
    }
    return asker;
}

@end
