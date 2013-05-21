//
//  SchoolCalloutViewViewController.m
//  FEMADemo
//
//  Created by Frank on 3/21/13.
//  Copyright (c) 2013 Esri. All rights reserved.
//

#import "SchoolCalloutViewController.h"
#import "CustomCalloutCell.h"

@interface SchoolCalloutViewController ()

@end

@implementation SchoolCalloutViewController

@synthesize delegate;
@synthesize closeButton;
@synthesize schoolInfoView;

@synthesize feature;
@synthesize fieldAlias;
@synthesize fieldNames;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.schoolInfoView.delegate = self;
    self.schoolInfoView.dataSource = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    //NSLog(@"viewWillAppear %@", feature);
    [self.schoolInfoView reloadData];
}

-(IBAction)closeButtonClicked:(id)sender
{
    [self.delegate closeSchoolCallout];
}

#pragma mark Table view methods

//one section in this table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


//the section in the table is as large as the number of attributes the feature has
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //NSLog(@"# of attributes=%@", feature);
    
	if (nil == self.feature) {
		return 0;
	}
    NSLog(@"# of attributes=%d", [feature.allAttributes count]);
    
    return [self.fieldNames count];
}


//called by table view when it needs to draw one of its rows
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	//static instance to represent a single kind of cell. Used if the table has cells formatted differently
    static NSString *DetailsViewControllerCellIdentifier = @"DetailsViewControllerCellIdentifier2";
    
    //as cells roll off screen get the reusable cell, if we can't create a new one
    CustomCalloutCell *cell = (CustomCalloutCell*)[tableView dequeueReusableCellWithIdentifier:DetailsViewControllerCellIdentifier];
    if (cell == nil) {
        cell = [[CustomCalloutCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:DetailsViewControllerCellIdentifier];
        CGRect frame = CGRectMake(100, 3, 360, 40);
        cell.valueLabel = [[UILabel alloc] initWithFrame:frame];
        [cell addSubview:cell.valueLabel];
    }
    
    
	//extract the attribute and its value and display both in the cell
    NSString *key = [self.fieldNames objectAtIndex:indexPath.row];
    
//    NSString *value = [self.feature attributeAsStringForKey:key];
//    NSLog(@"key=%@, value=%@", key, value);
//    
//    NSEnumerator *enumerator1 = [self.feature.allAttributes keyEnumerator];
//    id obj1 = enumerator1.nextObject;
//    while (obj1 != nil) {
//        NSLog(@"key=%@", obj1);
//        obj1 = enumerator1.nextObject;
//    }
//    
//    NSEnumerator *enumerator = [self.feature.allAttributes objectEnumerator];
//    id obj = enumerator.nextObject;
//    while (obj != nil) {
//        NSLog(@"value=%@", obj);
//        obj = enumerator.nextObject;
//    }
    
    cell.textLabel.text = [self.fieldAlias objectAtIndex:indexPath.row];
	cell.valueLabel.text = [NSString stringWithFormat:@"%@", [self.feature attributeAsStringForKey:key]];
    
//	//as cells roll off screen get the reusable cell, if we can't create a new one
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DetailsViewControllerCellIdentifier];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:DetailsViewControllerCellIdentifier];
//    }
//    
//    
//	//extract the attribute and its value and display both in the cell
//    NSString *key = [self.fieldNames objectAtIndex:indexPath.row];
//    NSString *alias = [self.fieldAlias objectAtIndex:indexPath.row];
//	cell.textLabel.text = [NSString stringWithFormat:@"%@: %@", alias, [self.feature attributeAsStringForKey:key]];
	
    return cell;
}

-(void)refresh
{
    [self.schoolInfoView reloadData];
}
@end
