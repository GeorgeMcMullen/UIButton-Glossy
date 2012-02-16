// Code from: http://www.mlsite.net/blog/?p=232
// Modified to include a shadow

#import "UIButton+Glossy.h"
#import <QuartzCore/QuartzCore.h>

void UIButton_Glossy_touch()
{
    // This is a trick to help categories link properly in static libraries
    NSLog(@"Do nothing, just to make categories link correctly for static files.");
}

@implementation UIButton (Glossy)

- (void)makeGlossy
{
    CALayer *thisLayer = self.layer;

    // Add a border
    thisLayer.cornerRadius = 8.0f;
    thisLayer.masksToBounds = NO;
    thisLayer.borderWidth = 2.0f;
    thisLayer.borderColor = self.backgroundColor.CGColor;
	
    // Give it a shadow
    if ([thisLayer respondsToSelector:@selector(shadowOpacity)]) // For compatibility, check if shadow is supported
    {
        thisLayer.shadowOpacity = 0.7;
        thisLayer.shadowColor = [[UIColor blackColor] CGColor];
        thisLayer.shadowOffset = CGSizeMake(0.0, 3.0);
        
        // TODO: Need to test these on iPad
        if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2)
        {
            thisLayer.rasterizationScale=2.0;
        }
	thisLayer.shouldRasterize = YES; // FYI: Shadows have a poor effect on performance
    }
	
    // Add backgorund color layer and make original background clear
    CALayer *backgroundLayer = [CALayer layer];
    backgroundLayer.cornerRadius = 8.0f;
    backgroundLayer.masksToBounds = YES;
    backgroundLayer.frame = thisLayer.bounds;
    backgroundLayer.backgroundColor=self.backgroundColor.CGColor;
    [thisLayer insertSublayer:backgroundLayer atIndex:0];
	
    thisLayer.backgroundColor=[UIColor colorWithWhite:0.0f alpha:0.0f].CGColor;
	
    // Add gloss to the background layer
    CAGradientLayer *glossLayer = [CAGradientLayer layer];
    glossLayer.frame = thisLayer.bounds;
    glossLayer.colors = [NSArray arrayWithObjects:
                         (id)[UIColor colorWithWhite:1.0f alpha:0.4f].CGColor,
                         (id)[UIColor colorWithWhite:1.0f alpha:0.2f].CGColor,
                         (id)[UIColor colorWithWhite:0.75f alpha:0.0f].CGColor,
                         (id)[UIColor colorWithWhite:1.0f alpha:0.2f].CGColor,
                         nil];
    glossLayer.locations = [NSArray arrayWithObjects:
                            [NSNumber numberWithFloat:0.0f],
                            [NSNumber numberWithFloat:0.5f],
                            [NSNumber numberWithFloat:0.5f],
                            [NSNumber numberWithFloat:1.0f],
                            nil];
    [backgroundLayer addSublayer:glossLayer];	
}	

@end

