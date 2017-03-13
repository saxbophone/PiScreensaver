//
//  pi_saverView.m
//  pi_saver
//
//  Created by Lewis O'Driscoll on 13/03/2017.
//  Copyright © 2017 Lewis O'Driscoll. All rights reserved.
//

#import "pi_saverView.h"

@implementation pi_saverView

- (instancetype)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
        [self setAnimationTimeInterval:1/30.0];
    }
    return self;
}

- (void)startAnimation
{
    [super startAnimation];
    
    totalPoints = 0;
    inCircle = 0;
    lastPointAdded = [NSDate date];
    points = [[NSMutableArray alloc] init];
}

- (void)stopAnimation
{
    [super stopAnimation];
}

- (void)drawRect:(NSRect)rect
{
    [super drawRect:rect];

    NSRect screenSize = [self bounds];
    float centreX = NSMaxX(screenSize)/2;
    float centreY = NSMaxY(screenSize)/2;
    
    float boardDiameter = NSMaxY(screenSize) * 0.75;
    float boardX = centreX - boardDiameter/2.0 - NSMaxX(screenSize) * 0.25;
    float boardY = centreY - boardDiameter/2.0;
    
    [[NSColor redColor] set];
    [[NSBezierPath bezierPathWithOvalInRect:NSMakeRect(boardX, boardY, boardDiameter, boardDiameter)] fill];
    [[NSColor whiteColor] set];
    [[NSBezierPath bezierPathWithRect:NSMakeRect(boardX, boardY, boardDiameter, boardDiameter)] stroke];
    
    for (NSValue *value in points) {
        NSPoint dartPoint = [value pointValue];
        NSPoint boardCentre = NSMakePoint(boardX + boardDiameter/2, boardY + boardDiameter/2);
        [self drawDartWithCoords:dartPoint onBoardOfDiameter:boardDiameter withCentre:boardCentre];
    }
    
    [self drawTextWithScreenCentre:NSMakePoint(centreX, centreY)];
}

- (void)drawDartWithCoords:(NSPoint)point onBoardOfDiameter:(float)boardDiameter withCentre:(NSPoint)boardCentre
{
    float dartRadius = boardDiameter / 30.0;
    
    float dartX = boardCentre.x + ((boardDiameter/2) * point.x) - dartRadius/2;
    float dartY = boardCentre.y + ((boardDiameter/2) * point.y) - dartRadius/2;
    
    [[NSColor greenColor] set];
    [[NSBezierPath bezierPathWithOvalInRect:NSMakeRect(dartX, dartY, dartRadius, dartRadius)] fill];
}

- (void)drawTextWithScreenCentre:(NSPoint)centre
{
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[NSFont fontWithName:@"Helvetica" size:35], NSFontAttributeName, [NSColor whiteColor], NSForegroundColorAttributeName, nil];
    
    float piEst = 0;
    if (totalPoints > 0) {
        piEst = (inCircle / totalPoints) * 4;
    }
    NSString *pointString = [NSString stringWithFormat:@"π ≈ %f", piEst];
    NSAttributedString *label = [[NSAttributedString alloc] initWithString:pointString attributes:attributes];
    
    float textX = centre.x + self.bounds.size.width*0.25 - label.size.width/2;
    float textY = centre.y - [label size].height/2;
    [label drawAtPoint:NSMakePoint(textX, textY)];
}

- (void)animateOneFrame
{
    // Add a point if it's been more than .25 secs
    if ([lastPointAdded timeIntervalSinceNow] < -0.25) {
        NSPoint lastPoint = [self addPoint];
        [points addObject:[NSValue valueWithPoint:lastPoint]];
        lastPointAdded = [NSDate date];
    }
    
    [self setNeedsDisplay:YES];
    return;
}

- (BOOL)hasConfigureSheet
{
    return NO;
}

- (BOOL)isOpaque
{
    return YES;
}

- (NSWindow*)configureSheet
{
    return nil;
}

#pragma mark Pi Calculator

- (CGPoint)addPoint
{
    float x = SSRandomFloatBetween(-1, 1);
    float y = SSRandomFloatBetween(-1, 1);
    
    bool isInsideCircle = sqrt(x*x + y*y) < 1.0;
    if (isInsideCircle) {
        inCircle += 1.0;
    }
    totalPoints += 1.0;
    
    return NSMakePoint(x, y);
}

@end
