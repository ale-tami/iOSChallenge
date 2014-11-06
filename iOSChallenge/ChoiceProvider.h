//
//  ChoiceProvider.h
//  iOSChallenge
//
//  Created by Alejandro Tami on 5/11/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChoiceProvider : NSObject

+ (instancetype) sharedProvider;

- (NSArray *) getRandomChoiceArray;

@end
