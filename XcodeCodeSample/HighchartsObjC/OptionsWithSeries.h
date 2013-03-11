//
//  OptionsWithSeries.h
//  HighchartsObjC
//
//  Created by Tomasz Janeczko on 11-08-19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

enum SeriesEnum {
    SeriesEnumCurrentScatterSeries = 0,
    SeriesEnumPeriodScatterSeries = 1,
    SeriesEnumAvgLineSeries = 2
};

@protocol OptionsWithSeries <NSObject>
- (NSString *)getSeriesString;
- (NSString *)getSeriesStringForSeries:(enum SeriesEnum)seriesEnum;
@end
