//
//  PersonBuilder.h
//  BrowseOverflow
//
//  Created by Andrew Melis on 5/19/14.
//  Copyright (c) 2014 Baller Status Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Person;

@interface PersonBuilder : NSObject

+ (Person *)personFromDictionary:(NSDictionary *)parsedAsker;

@end
