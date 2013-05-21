//
//  SchoolCalloutViewViewController.h
//  FEMADemo
//
//  Created by Frank on 3/21/13.
//  Copyright (c) 2013 Esri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ArcGIS/ArcGIS.h>

@protocol SchoolCalloutViewControllerDelegate <NSObject>

-(void)closeSchoolCallout;

@end

@interface SchoolCalloutViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id<SchoolCalloutViewControllerDelegate> delegate;

@property (nonatomic, strong) IBOutlet UITableView *schoolInfoView;
@property (nonatomic, strong) IBOutlet UIButton *closeButton;

@property (nonatomic, strong) AGSGraphic *feature;
@property (nonatomic, strong) NSArray* fieldNames;
@property (nonatomic, strong) NSArray* fieldAlias;

-(IBAction)closeButtonClicked:(id)sender;


-(void)refresh;

@end
