//
//  HighchartsObjCViewController.m
//  HighchartsObjC
//
//  Created by Tomasz Janeczko on 11-08-05.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HighchartsObjCViewController.h"
#import "HighchartsHelper.h"
#import "HighchartsXYOptions.h"
#import "HighChartsPieOptions.h"
#import "ExamplePieSection.h"
#import "HighstockOptions.h"
#import "DatePoint.h"

@implementation HighchartsObjCViewController
@synthesize webView=_webView;

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)webView:(UIWebView *)webView2
shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType {
    
    NSString *requestString = [[[request URL] absoluteString] stringByReplacingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    //NSLog(requestString);
    
    if ([requestString hasPrefix:@"ios-log:"]) {
        NSString* logString = [[requestString componentsSeparatedByString:@":#iOS#"] objectAtIndex:1];
        NSLog(@"UIWebView console: %@", logString);
        return NO;
    }
    
    return YES;
}

- (IBAction)createScatterPlot {
    HighstockOptions *options = [HighstockOptions new];
    options.title = @"Zomg!";
    options.axisTitle = @"Cukier";
    options.dataAxisTitle = @"Godzina";
    
    NSString *dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:dateFormat];
    
    // PeriodSeries
    [options addDatePoint:[DatePoint datePointWithDate:[dateFormatter dateFromString:@"2013-03-09 18:45:00"] andValue:[NSNumber numberWithInt:170]] toSeries:SeriesEnumPeriodScatterSeries];
    [options addDatePoint:[DatePoint datePointWithDate:[dateFormatter dateFromString:@"2013-03-09 13:45:00"] andValue:[NSNumber numberWithInt:100]] toSeries:SeriesEnumPeriodScatterSeries];
    [options addDatePoint:[DatePoint datePointWithDate:[dateFormatter dateFromString:@"2013-03-09 10:45:00"] andValue:[NSNumber numberWithInt:90]] toSeries:SeriesEnumPeriodScatterSeries];
    [options addDatePoint:[DatePoint datePointWithDate:[dateFormatter dateFromString:@"2013-03-09 18:45:00"] andValue:[NSNumber numberWithInt:170]] toSeries:SeriesEnumPeriodScatterSeries];
    [options addDatePoint:[DatePoint datePointWithDate:[dateFormatter dateFromString:@"2013-03-08 12:45:00"] andValue:[NSNumber numberWithInt:120]] toSeries:SeriesEnumPeriodScatterSeries];
    [options addDatePoint:[DatePoint datePointWithDate:[dateFormatter dateFromString:@"2013-03-08 07:45:00"] andValue:[NSNumber numberWithInt:310]] toSeries:SeriesEnumPeriodScatterSeries];
    [options addDatePoint:[DatePoint datePointWithDate:[dateFormatter dateFromString:@"2013-03-07 07:20:00"] andValue:[NSNumber numberWithInt:310]] toSeries:SeriesEnumPeriodScatterSeries];
    [options addDatePoint:[DatePoint datePointWithDate:[dateFormatter dateFromString:@"2013-03-07 22:21:00"] andValue:[NSNumber numberWithInt:200]] toSeries:SeriesEnumPeriodScatterSeries];
    [options addDatePoint:[DatePoint datePointWithDate:[dateFormatter dateFromString:@"2013-03-06 14:14:00"] andValue:[NSNumber numberWithInt:180]] toSeries:SeriesEnumPeriodScatterSeries];
    
    
    // CurrentSeries
    [options addDatePoint:[DatePoint datePointWithDate:[dateFormatter dateFromString:@"2013-03-10 23:23:00"] andValue:[NSNumber numberWithInt:200]] toSeries:SeriesEnumCurrentScatterSeries];
    [options addDatePoint:[DatePoint datePointWithDate:[dateFormatter dateFromString:@"2013-03-10 22:00:00"] andValue:[NSNumber numberWithInt:160]] toSeries:SeriesEnumCurrentScatterSeries];
    [options addDatePoint:[DatePoint datePointWithDate:[dateFormatter dateFromString:@"2013-03-10 21:30:00"] andValue:[NSNumber numberWithInt:150]] toSeries:SeriesEnumCurrentScatterSeries];
    [options addDatePoint:[DatePoint datePointWithDate:[dateFormatter dateFromString:@"2013-03-10 16:45:00"] andValue:[NSNumber numberWithInt:120]] toSeries:SeriesEnumCurrentScatterSeries];
    
    [HighchartsHelper createScatterChartWithLineChartInWebView:self.webView withOptions:options];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    //NSArray *xValues = [NSArray arrayWithObjects:[NSNumber numberWithFloat:3.0], [NSNumber numberWithFloat:4.0], [NSNumber numberWithFloat:5.0], nil];
    //NSArray *yValues = [NSArray arrayWithObjects:[NSNumber numberWithFloat:6.0], [NSNumber numberWithFloat:-2.0], [NSNumber numberWithFloat:5.0], nil];
    
    //HighchartsXYOptions *options = [[HighchartsXYOptions alloc] initWithTitle:@"ChartTitle" andXValues:xValues andYValues:yValues];
    //options.yAxisTitle = @"My Title";
    
    /*HighChartsPieOptions *options = [HighChartsPieOptions new];
    options.chartTitle = @"My title";
    ExamplePieSection *section1 = [ExamplePieSection pieSectionWithName:@"Car" andValue:[NSNumber numberWithInt:4] andColor:[UIColor redColor]];
    ExamplePieSection *section2 = [ExamplePieSection pieSectionWithName:@"Credit Card" andValue:[NSNumber numberWithInt:1] andColor:[UIColor redColor]];
    ExamplePieSection *section3 = [ExamplePieSection pieSectionWithName:@"Salary" andValue:[NSNumber numberWithInt:6] andColor:[UIColor greenColor]];
    [options addObject: section1];
    [options addObject: section2];
    [options addObject: section3];*/
    
    //[HighchartsHelper createLineChartInWebView:self.webView withOptions:options];
    //[HighchartsHelper createPieChartInWebView:self.webView withOptions:options];
    
    //    [options release];
    
    // Odczytaj wszystkie dane dla jakiegos okresu z core data
    
    // tablica = wszystkie (wez z Core Data)
    // tablica daj mi wszystkie - ostatni dzien --> NSPredicate
    // ostatni dzien
    // liniowe wyliczyc
    
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"main" ofType:@"html"];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
