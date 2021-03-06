/**
 * Copyright (c) 2015-present, Horcrux.
 * All rights reserved.
 *
 * This source code is licensed under the MIT-style license found in the
 * LICENSE file in the root directory of this source tree.
 */
#import "RNSVGLinearGradient.h"
#import "RNSVGPainter.h"
#import "RNSVGBrushType.h"

@implementation RNSVGLinearGradient


- (void)setX1:(NSString *)x1
{
    if ([x1 isEqualToString:_x1]) {
        return;
    }
    
    _x1 = x1;
    [self invalidate];
}

- (void)setY1:(NSString *)y1
{
    if ([y1 isEqualToString:_y1]) {
        return;
    }
    
    _y1 = y1;
    [self invalidate];
}

- (void)setX2:(NSString *)x2
{
    if ([x2 isEqualToString:_x2]) {
        return;
    }
    
    _x2 = x2;
    [self invalidate];
}

- (void)setY2:(NSString *)y2
{
    if ([y2 isEqualToString:_y2]) {
        return;
    }
    
    _y2 = y2;
    [self invalidate];
}

- (void)setGradient:(NSArray<NSNumber *> *)gradient
{
    if (gradient == _gradient) {
        return;
    }
    
    _gradient = gradient;
    [self invalidate];
}

- (void)setGradientUnits:(RNSVGUnits)gradientUnits
{
    if (gradientUnits == _gradientUnits) {
        return;
    }
    
    _gradientUnits = gradientUnits;
    [self invalidate];
}

- (void)setGradientTransform:(CGAffineTransform)gradientTransform
{
    _gradientTransform = gradientTransform;
    [self invalidate];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    return nil;
}

- (void)parseReference
{
    NSArray<NSString *> *points = @[self.x1, self.y1, self.x2, self.y2];
    RNSVGPainter *painter = [[RNSVGPainter alloc] initWithPointsArray:points];
    [painter setUnits:self.gradientUnits];
    [painter setTransform:self.gradientTransform];
    [painter setLinearGradientColors:self.gradient];
    
    if (self.gradientUnits == kRNSVGUnitsUserSpaceOnUse) {
        [painter setUserSpaceBoundingBox:[self.svgView getContextBounds]];
    }
    
    [self.svgView definePainter:painter painterName:self.name];
}
@end

