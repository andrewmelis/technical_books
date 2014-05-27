//
//  Answer.m
//  BrowseOverflow
//
//  Created by Andrew Melis on 3/17/14.
//  Copyright (c) 2014 Baller Status Inc. All rights reserved.
//

#import "Answer.h"

@implementation Answer

- (NSComparisonResult)compare:(Answer *)otherAnswer
{
    if (_accepted && !(otherAnswer.accepted)) {
        return NSOrderedAscending;
    } else if (!_accepted && otherAnswer.accepted) {
        return NSOrderedDescending;
    }
    if (_score > otherAnswer.score) {
        return NSOrderedAscending;
    } else if (_score < otherAnswer.score) {
        return NSOrderedDescending;
    } else {
        return NSOrderedSame;
    }
}

@end
