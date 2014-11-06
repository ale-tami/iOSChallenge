//
//  ChoiceProvider.m
//  iOSChallenge
//
//  Created by Alejandro Tami on 5/11/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import "ChoiceProvider.h"

@interface ChoiceProvider()

@property (strong,nonatomic) NSMutableArray * choices;
@property int randomLimit;

@end

@implementation ChoiceProvider

/*! Singleton class method, has everything we need to get started
    with the randomization of the possible values
 */
+ (instancetype) sharedProvider
{
    static ChoiceProvider *provider = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        provider = [ChoiceProvider new];
        
        NSArray * choice1 = @[@"one of a kind", @"small batch", @"large batch", @"mass market"];
        NSArray * choice2 = @[@"savory", @"sweet", @"umami"];
        NSArray * choice3 = @[@"spicy", @"mild"];
        NSArray * choice4 = @[@"crunchy", @"mushy", @"smooth"];
        NSArray * choice5 = @[@"a little", @"a lot"];
        NSArray * choice6 = @[@"breakfast", @"brunch", @"lunch", @"snack", @"dinner"];
        
        provider.choices = [@[choice1, choice2, choice3, choice4, choice5, choice6] mutableCopy];
        
    });
    
    return provider;
}

/*! Randomly pick one of the arrays and return it
 */
- (NSArray *) getRandomChoiceArray
{
    if (self.choices.count > 0) {
        
        self.randomLimit = (int) self.choices.count - 1;
        
        int x = self.randomLimit != 0 ? arc4random() % self.randomLimit : 0;
        
        self.randomLimit--;
        
        NSArray *randomArray = [self.choices objectAtIndex:x];
        [self.choices removeObjectAtIndex:x];
        
        return randomArray;
        
    } else {
        return nil;
    }
    
}


@end
