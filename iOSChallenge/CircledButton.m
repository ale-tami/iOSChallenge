//
//  CircledButton.m
//  iOSChallenge
//
//  Created by Alejandro Tami on 4/11/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import "CircledButton.h"
#import "ChoiceProvider.h"
#import <AudioToolbox/AudioToolbox.h>

#define kButtonSize 118
#define kDistanceFillArcs 10
#define kFillSublayerIndex 0
#define kFirstArcSublayerIndex 1

//Private properties
@interface CircledButton ()

@property float radius;
@property int optionsArrayIndex;
@property (strong, nonatomic) NSArray *optionsArray;
@property CAShapeLayer *previousLayer;

@end


@implementation CircledButton


- (id)initWithCoder:(NSCoder*)coder
{
    if ((self = [super initWithCoder:coder])) {
        
        self.frame = CGRectMake(0,0, kButtonSize, kButtonSize);
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        self.radius = self.frame.size.width / 2.0f;
        self.optionsArrayIndex = 0;
        
        [self fillButton];
        [self setupButton];
        [self updateTitle];
        
    }
    return self;
}

/*! Fills the button with a transparent black color but leaves some space between
     that fill and the arcs, and compensates this by centering that fill
 */
- (void) fillButton
{
    CAShapeLayer *fillLayer = [CAShapeLayer layer];
    float fillRadius = (2*self.radius) - kDistanceFillArcs;
    
    [fillLayer setFillColor:[[UIColor colorWithRed:0 green:0 blue:0 alpha:0.2] CGColor]];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:
                          CGRectMake(self.frame.origin.x + (kDistanceFillArcs/2),
                                     self.frame.origin.y + (kDistanceFillArcs/2),
                                     fillRadius, fillRadius)
                                                    cornerRadius: self.radius ];
    [fillLayer setPath:[path CGPath]];
    [self.layer insertSublayer:fillLayer atIndex:kFillSublayerIndex];
}

/*! Sets up the button with the arcs
 */
- (void) setupButton
{
    
    self.optionsArray = [[ChoiceProvider sharedProvider] getRandomChoiceArray];
    CAShapeLayer *circleLayer;
    UIBezierPath *path;
    
    float spaceArc = 0.25f;                                              // Space between arcs, magic number
    float arcLength = ((2 * M_PI) / self.optionsArray.count) - spaceArc; // Divide the entire cirumference and rest space arc
    float startAngle = 0;                                                // Lets start drawing form 0
    float endAngle = arcLength;                                          // Initialize the end of the arc
        
    for (int i = 0 ; i < self.optionsArray.count; i++) {
        
        circleLayer = [CAShapeLayer layer];
        path = [UIBezierPath bezierPathWithArcCenter:self.center
                                                            radius:self.radius
                                                        startAngle:startAngle
                                                          endAngle:endAngle
                                                         clockwise:YES];
        
        [circleLayer setPath:[path CGPath]];
        
        [circleLayer setFillColor:[[UIColor colorWithRed:0 green:0 blue:0 alpha:0.0] CGColor]]; // no fill color
        
        struct CGColor* color = [[UIColor colorWithRed:0.54 green:0.36 blue:0.40 alpha:1] CGColor]; // Exact same color
        
        [circleLayer setStrokeColor: color];
        
        [circleLayer setLineWidth:2.0f];
        
        [self.layer insertSublayer:circleLayer atIndex:kFirstArcSublayerIndex + i];
        
        // This increments the start and end angles, to complete the circumference 
        startAngle = endAngle + spaceArc;
        endAngle = (startAngle + arcLength);
        
    }

}

- (void) updateTitle
{
    [self setTitle:[self.optionsArray objectAtIndex:self.optionsArrayIndex] forState:UIControlStateNormal ];
    // Adds +1 to the index and if it exceeds the amount of objects in the array sets the index to 0
    self.optionsArrayIndex = (self.optionsArrayIndex == self.optionsArray.count - 1) ? 0 : self.optionsArrayIndex + 1;

    CAShapeLayer* layer = [[self.layer sublayers] objectAtIndex:self.optionsArrayIndex + 1]; // Sublayer 0 is our fill/shade
    
    [layer setStrokeColor:[[UIColor colorWithRed:0.97 green:0.39 blue:0.47 alpha:1] CGColor]]; //exact same color yet again
    
    [self.previousLayer setStrokeColor:[[UIColor colorWithRed:0.54 green:0.36 blue:0.40 alpha:1] CGColor]];
    
    self.previousLayer = layer; // save previous layer so we can change it back
    
}


@end
