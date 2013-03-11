//
//  HighchartsHelper.m
//  HighchartsObjC
//
//  Created by Tomasz Janeczko on 11-08-05.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HighchartsHelper.h"
#import "HighchartsXYOptions.h"
#import "HighchartsPieOptions.h"
#import "HighstockOptions.h"

@implementation HighchartsHelper

+ (void)initWebView:(UIWebView *)webView withOptions:(HighchartsBaseOptions *)options {
    [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"$('body').css('background-color', '%@');", [self getJSStringWithUIColor:options.backgroundColor]]];
}

+ (void)createLineChartInWebView:(UIWebView*)webView withOptions:(HighchartsXYOptions *)options{
    [self initWebView:webView withOptions:options];
    
    NSString *yAxisTitle = options.yAxisTitle;
    if ([yAxisTitle length] == 0) {
        yAxisTitle = @"null";
    } else {
        yAxisTitle = [NSString stringWithFormat:@"\"%@\"", yAxisTitle];
    }
    
    NSString *jsString = [NSString stringWithFormat:@"createLineChart(\"%@\", %@, \"My own title\", %@);", options.chartTitle, yAxisTitle, [self getJSDataPointsWithXValues:options.xValues andYValues:options.yValues]];
    
    [webView stringByEvaluatingJavaScriptFromString:jsString];
}

+ (void)createStockChartInWebView:(UIWebView*)webView withOptions:(HighstockOptions*)options {
    [self initWebView:webView withOptions:options];
    [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"createLineScopingChart(\"%@\",\"%@\",\"%@\",%@);", options.title, options.axisTitle, options.title, [options getSeriesString]]];
}

+ (void)createScatterChartWithLineChartInWebView:(UIWebView *)webView withOptions:(HighstockOptions *)options {
    [self initWebView:webView withOptions:options];
    [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"createCombinedPlot(\"%@\", \"%@\", \"%@\", %@, %@, %@);", options.title, options.axisTitle, options.dataAxisTitle, [options getSeriesStringForSeries:SeriesEnumCurrentScatterSeries], [options getSeriesStringForSeries:SeriesEnumPeriodScatterSeries], [options getSeriesStringForSeries:SeriesEnumAvgLineSeries]]];
    
    NSLog(@"%@", [options getSeriesStringForSeries:SeriesEnumPeriodScatterSeries]);
}

+ (NSString*)getJSDataPointsWithXValues:(NSArray*)xValues andYValues:(NSArray*)yValues {
    if ([xValues count] != [yValues count]) {
        return nil;
    }
    
    NSString *output = @"[";
    int limit = [xValues count];
    for (int i = 0; i < limit; i++) {
        output = [output stringByAppendingFormat:@"[%@, %@]", [self getJSString:[xValues objectAtIndex:i]], [self getJSString:[yValues objectAtIndex:i]]];
        if (i < limit - 1) {
            output = [output stringByAppendingString:@", "];
        }
    }
    
    output = [output stringByAppendingString:@"]"];
              
  return output;
}

+ (NSString*)getJSString:(NSObject*)object {
    if ([object isKindOfClass:[NSNumber class]]) {
        return [NSString stringWithFormat:@"%@", [object description]];
    } else {
        return [NSString stringWithFormat:@"\"%@\"", [object description]];
    }
}

+ (void)createPieChartInWebView:(UIWebView *)webView withOptions:(HighChartsPieOptions *)options {
    [self initWebView:webView withOptions:options];
    NSString *jsString = [NSString stringWithFormat:@"createPieChart(\"%@\", %@);", options.chartTitle, [options getSectionsArrayAsJSString]];
    
    [webView stringByEvaluatingJavaScriptFromString:jsString];
}

+ (NSString *)getJSStringWithUIColor:(UIColor *)color {
    if ([color isEqual:[UIColor whiteColor]]) {
        return @"#FFFFFF";
    } else if ([color isEqual:[UIColor blackColor]]) {
        return @"#000000";
    }
    
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    int r = 0xFF * components[0];
    int g = 0xFF * components[1];
    int b = 0xFF * components[2];
    int a = 0xFF * components[3];
    
    //    NSLog(@"%02X %02X %02X, %i %i %i", r, g, b, r, g, b);
    
    NSString *colorAsString = [NSString stringWithFormat:@"#%02X%02X%02X", r, g, b];
    NSLog(@"%@", colorAsString);
    return colorAsString;
}

+ (void)setSeriesInWebView:(UIWebView *)webView withOptions:(id<OptionsWithSeries>)options {
    [webView stringByEvaluatingJavaScriptFromString:[options getSeriesString]];
}

@end
