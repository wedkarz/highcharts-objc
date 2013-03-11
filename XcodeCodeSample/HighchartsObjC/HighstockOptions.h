//
//  HighstockOptions.h
//  HighchartsObjC
//
//  Created by Tomasz Janeczko on 11-08-10.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HighchartsBaseOptions.h"
#import "OptionsWithSeries.h"

@class DatePoint;

@interface HighstockOptions : HighchartsBaseOptions <OptionsWithSeries> {
    NSMutableArray *datePoints;
    NSMutableArray *datePointsSeries2;
    NSMutableArray *datePointsSeries3;
    NSString *title;
    NSString *axisTitle;
}

@property (nonatomic, retain) NSMutableArray *datePoints;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *axisTitle;
@property (nonatomic, retain) NSString *dataAxisTitle;
@property (nonatomic, retain) NSMutableArray *datePointsSeries2;
@property (nonatomic, retain) NSMutableArray *datePointsSeries3;

- (void)addDatePoint:(DatePoint*)datePoint;
- (void)addDatePoint:(DatePoint*)datePoint toSeries:(enum SeriesEnum)seriesEnum;

@end
