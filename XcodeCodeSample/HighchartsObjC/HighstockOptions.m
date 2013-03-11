//
//  HighstockOptions.m
//  HighchartsObjC
//
//  Created by Tomasz Janeczko on 11-08-10.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HighstockOptions.h"
#import "DatePoint.h"



@implementation HighstockOptions
@synthesize datePoints;
@synthesize datePointsSeries2;
@synthesize datePointsSeries3;
@synthesize title;
@synthesize axisTitle;
@synthesize dataAxisTitle;

- (id)init {
    self = [super init];
    if (self) {
        self.datePoints = [NSMutableArray array];
        self.datePointsSeries2 = [NSMutableArray array];
        self.datePointsSeries3 = [NSMutableArray array];
    }
    return self;
}

- (void)dealloc {
    self.datePoints = nil;
    [super dealloc];
}

- (NSString *)getSeriesString {
    NSMutableString *string = [[[NSMutableString alloc] init] autorelease];
    [string appendString:@"["];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy,MM'-1',dd"];
    for (DatePoint *point in self.datePoints) {
        [string appendFormat:@"[Date.UTC(%@), %@]", [dateFormatter stringFromDate:point.date], point.value];
        if ([self.datePoints indexOfObject:point] != [self.datePoints count] - 1) {
            [string appendString:@", "];
        }
    }
    
    [string appendString:@"]"];
    
    return [NSString stringWithString:string];
}

- (NSString *)getSeriesStringForSeries:(enum SeriesEnum)seriesEnum {
    NSArray *dataSeries = self.datePoints;
    
    switch (seriesEnum) {
        case SeriesEnumPeriodScatterSeries:
            dataSeries = self.datePointsSeries2;
            break;
        case SeriesEnumAvgLineSeries:
            dataSeries = self.datePointsSeries3;
            break;
        case SeriesEnumCurrentScatterSeries:
        default:
            dataSeries = self.datePoints;
            break;
    }
    
    NSMutableString *string = [[[NSMutableString alloc] init] autorelease];
    [string appendString:@"["];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy,MM'-1',dd,HH,mm,ss"];
    
    for (DatePoint *point in dataSeries) {
        [string appendFormat:@"[Date.UTC(%@),%@]", [dateFormatter stringFromDate:point.date], point.value];
        if ([dataSeries indexOfObject:point] != [dataSeries count] - 1) {
            [string appendString:@", "];
        }
    }
    
    [string appendString:@"]"];
    
    return [NSString stringWithString:string];
}


- (void)addDatePoint:(DatePoint*)datePoint {
    [self.datePoints addObject:datePoint];
}

- (void)addDatePoint:(DatePoint*)datePoint toSeries:(enum SeriesEnum)seriesEnum {
    switch (seriesEnum) {
        case SeriesEnumPeriodScatterSeries:
            [self.datePointsSeries2 addObject:datePoint];
            break;
        case SeriesEnumAvgLineSeries:
            [self.datePointsSeries3 addObject:datePoint];
            break;
        case SeriesEnumCurrentScatterSeries:
        default:
            [self.datePoints addObject:datePoint];
            break;
    }
}

@end
