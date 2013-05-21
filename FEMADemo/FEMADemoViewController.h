//
//  FEMADemoViewController.h
//  FEMADemo
//
//  Created by Frank on 3/15/13.
//  Copyright (c) 2013 Esri. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <ArcGIS/ArcGIS.h>

#import "MyLayerDelegate.h"
#import "DriveTime.h"
#import "SettingsViewController.h"
#import "CustomCalloutViewController.h"
#import "PDFViewController.h"
#import "SchoolCalloutViewController.h"


@interface FEMADemoViewController : UIViewController <AGSMapViewTouchDelegate, DriveTimeResponseDelegate, SettingsViewControllerDelegate,CustomCalloutViewControllerDelegate, SchoolCalloutViewControllerDelegate, AGSQueryTaskDelegate, PDFViewControllerDelegate, AGSIdentifyTaskDelegate>

@property (nonatomic, strong) IBOutlet AGSMapView *mapView;
@property (nonatomic, strong) IBOutlet UIButton* tocButton;
@property (nonatomic, strong) IBOutlet UIButton* settingsButton;
@property (nonatomic, retain) IBOutlet UILabel *statusLabel;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, retain) IBOutlet UIView *statusView;

@property (nonatomic, strong) UIPopoverController *popOverController; //Only used with iPad

@property (nonatomic, strong) MyLayerDelegate *myLayerDelegate;
@property (nonatomic) BOOL tocViewVisible;

@property (nonatomic, strong) AGSGraphicsLayer *startPointGraphicsLayer;
@property (nonatomic, strong) AGSGraphicsLayer *travelZoneGraphicsLayer;
@property (nonatomic, strong) DriveTime *driveTime;

@property (nonatomic, strong) SettingsViewController *settingsViewController;
@property (nonatomic, strong) UIPopoverController *settingsPopoverController;

@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString* driveTimeInMinutes;
@property (nonatomic) BOOL runDriveTime;

@property (nonatomic, strong) NSString *token;


@property (nonatomic, strong) AGSQueryTask *queryTask;
@property (nonatomic, strong) AGSQuery *query;
@property (nonatomic, strong) CustomCalloutViewController *customCalloutViewController;
@property (nonatomic, strong) NSArray *fieldNames;
@property (nonatomic, strong) NSArray *fieldAlias;

@property (nonatomic, strong) PDFViewController *pdfViewController;

@property (nonatomic, strong) AGSQueryTask *schoolQueryTask;
@property (nonatomic, strong) AGSQuery *schoolQuery;
@property (nonatomic, strong) SchoolCalloutViewController* schoolCalloutViewController;
@property (nonatomic, strong) NSArray *schoolFieldNames;
@property (nonatomic, strong) NSArray *schoolFieldAlias;

@property (nonatomic, strong) AGSIdentifyParameters *identifyParameters;
@property (nonatomic, strong) AGSIdentifyTask *identifyTask;

- (IBAction)presentTableOfContents:(id)sender;
- (IBAction)presentSettings:(id)sender;

- (void) calculateDriveTime;

@end
