//
//  CustomViewViewController.h
//  FEMADemo
//
//  Created by Frank on 3/19/13.
//  Copyright (c) 2013 Esri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ArcGIS/ArcGIS.h>
#import "BarChartViewController.h"


@protocol CustomCalloutViewControllerDelegate <NSObject>

-(void)closeCallout;
-(void)showPDFViewWithUrl:(NSString*)url1 andUrl:(NSString*)url2;

@end

@interface CustomCalloutViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) id<CustomCalloutViewControllerDelegate> delegate;

@property (nonatomic, strong) IBOutlet UIView *tableViewContainer;
@property (nonatomic, strong) IBOutlet UIView *chartViewContainer;
@property (nonatomic, strong) IBOutlet UIWebView *pdfWebView;

@property (nonatomic, strong) IBOutlet UITableView *leftTableView;

@property (nonatomic, strong) IBOutlet UIButton *showPDFsButton;
@property (nonatomic, strong) IBOutlet UIButton *showAttributesButton;
@property (nonatomic, strong) IBOutlet UIButton *showChartButton;
@property (nonatomic, strong) IBOutlet UIButton *closeButton;

@property (nonatomic, strong) AGSGraphic *feature;
@property (nonatomic, strong) NSArray* fieldNames;
@property (nonatomic, strong) NSArray* fieldAlias;

@property (nonatomic, strong) BarChartViewController *barChartViewController;
@property (nonatomic, strong) NSArray *chartLabels;
@property (nonatomic, strong) NSArray *chartValues;
@property (nonatomic, strong) IBOutlet UILabel *hhIncome;
@property (nonatomic, strong) IBOutlet UILabel *hhNoVehicle;

@property (nonatomic, strong) NSArray *tapstrySegNames;

@property (nonatomic) BOOL doAnimation;


-(IBAction)showPDFsButtonClicked:(id)sender;
-(IBAction)showChartButtonClicked:(id)sender;
-(IBAction)showAttributesButtonClicked:(id)sender;
-(IBAction)closeFButtonClicked:(id)sender;

-(void)refresh;

@end
