//
//  pi_saverView.h
//  pi_saver
//
//  Created by Lewis O'Driscoll on 13/03/2017.
//  Copyright © 2017 Lewis O'Driscoll. All rights reserved.
//

#import <ScreenSaver/ScreenSaver.h>

@interface pi_saverView : ScreenSaverView {    
    float totalPoints;
    float inCircle;
    
    NSPoint lastPoint;
    NSMutableArray *points;
    
    NSDate *lastPointAdded;
}

@end
