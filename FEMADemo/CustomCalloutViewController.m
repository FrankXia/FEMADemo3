//
//  CustomViewViewController.m
//  FEMADemo
//
//  Created by Frank on 3/19/13.
//  Copyright (c) 2013 Esri. All rights reserved.
//

#import "CustomCalloutViewController.h"
#import "CustomCalloutCell.h"

@interface CustomCalloutViewController ()

@end

@implementation CustomCalloutViewController

@synthesize tableViewContainer;
@synthesize chartViewContainer;
@synthesize pdfWebView;

@synthesize leftTableView;
@synthesize showChartButton;
@synthesize showPDFsButton;
@synthesize showAttributesButton;
@synthesize closeButton;
@synthesize feature;
@synthesize fieldNames;
@synthesize fieldAlias;


@synthesize barChartViewController;
@synthesize chartLabels;
@synthesize chartValues;
@synthesize hhIncome;
@synthesize hhNoVehicle;

@synthesize doAnimation;
@synthesize tapstrySegNames;

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
    
    self.leftTableView.delegate = self;
    self.leftTableView.dataSource = self;
    
    self.chartLabels = [NSArray arrayWithObjects:
                        @"Total",
                        @"Night",
                        @"Day",
                        @"< 9",
                        @"65 & Up",
                        nil];
    

    self.tapstrySegNames = [NSArray arrayWithObjects:
                            @"Top Rung",@"Suburban Splendor",@"Connoisseurs",@"Boomburbs",@"Wealthy Seaboard Suburbs",@"Sophisticated Squires",
                            @"Exurbanites",@"Laptops and Lattes",@"Urban Chic",@"Pleasant-Ville",@"Pacific Heights",@"Up and Coming Families",
                            @"In Style",@"Prosperous Empty Nesters",@"Silver and Gold",@"Enterprising Professionals",@"Green Acres",@"Cozy and Comfortable",
                            @"Milk and Cookies",@"City Lights",@"Urban Villages",@"Metropolitans",@"Trendsetters",@"Main Street USA",@"Salt of the Earth",
                            @"Midland Crowd",@"Metro Renters",@"Aspiring Young Families",@"Rustbelt Retirees",@"Retirement Communities",
                            @"Rural Resort Dwellers",@"Rustbelt Traditions",@"Midlife Junction",@"Family Foundations",@"International Marketplace",
                            @"Old and Newcomers",@"Prairie Living",@"Industrious Urban Fringe",@"Young and Restless",@"Military Proximity",
                            @"Crossroads",@"Southern Satellites",@"The Elders",@"Urban Melting Pot",@"City Strivers",@"Rooted Rural",@"Las Casas",
                            @"Great Expectations",@"Senior Sun Seekers",@"Heartland Communities",@"Metro City Edge",@"Inner City Tenants",@"Home Town",@"Urban Rows",@"College Towns",
                            @"Rural Bypasses",@"Simple Living",@"NeWest Residents",@"Southwestern Families",@"City Dimensions",@"High Rise Renters",
                            @"Modest Income Homes",@"Dorms to Diplomas",
                            @"City Commons",
                            @"Social Security Set",
                            @"Unclassified",nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    //NSLog(@"viewWillAppear %@", feature);
    [self.leftTableView reloadData];
    
    self.doAnimation = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    self.doAnimation = NO;
}

-(IBAction)showPDFsButtonClicked:(id)sender {
    NSString *url1 = @"http://184.73.156.57/AndroidApps/18SWJ5276.pdf";
    NSString *url2 = @"http://184.73.156.57/AndroidApps/18SWJ5276_update.pdf";
    
    url1 = [self.feature attributeAsStringForKey:@"URL"];
    url2 = [self.feature attributeAsStringForKey:@"UPDATE_URL"];
    
    NSLog(@"URL1=%@", url1);
    NSLog(@"URL2=%@", url2);
    
    [self.delegate showPDFViewWithUrl:url1 andUrl:url2];
}

-(IBAction)showChartButtonClicked:(id)sender {
    
    if(self.doAnimation){
        [UIView beginAnimations:@"test" context:nil];
        //[UIView setAnimationDidStopSelector:@selector(finishAnimateOutReportForm)];
        [UIView setAnimationDuration:1.0];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        //[UIView setAnimationPosition:actualScreenPoint];
        [UIView setAnimationTransition:103 forView:self.view cache:YES];
        [UIView commitAnimations];
    }
    else{
        self.doAnimation = YES;
    }
    
    self.pdfWebView.hidden = YES;
    self.chartViewContainer.hidden = NO;
    self.tableViewContainer.hidden = YES;
    
    self.showAttributesButton.enabled = YES;
    self.showChartButton.enabled = NO;
    
    if (self.feature) {
        self.chartValues = [NSArray arrayWithObjects:
							[NSNumber numberWithInt:[self.feature attributeAsIntegerForKey:[self.fieldNames objectAtIndex:0] exists:NO]],
							[NSNumber numberWithInt:[self.feature attributeAsIntegerForKey:[self.fieldNames objectAtIndex:1] exists:NO]],
							[NSNumber numberWithInt:[self.feature attributeAsIntegerForKey:[self.fieldNames objectAtIndex:2] exists:NO]],
							[NSNumber numberWithInt:[self.feature attributeAsIntegerForKey:[self.fieldNames objectAtIndex:3] exists:NO]],
							[NSNumber numberWithInt:[self.feature attributeAsIntegerForKey:[self.fieldNames objectAtIndex:4] exists:NO]],
							nil];
        
        if(self.barChartViewController) {
            [self.barChartViewController.view  removeFromSuperview];
        }
        self.barChartViewController = [[BarChartViewController alloc] initWithNibName:@"BarChartViewController"
                                                             labels:self.chartLabels
                                                             values:self.chartValues];
        self.hhIncome.text = [self.feature attributeAsStringForKey:[self.fieldNames objectAtIndex:5]];
        self.hhNoVehicle.text = [self.feature attributeAsStringForKey:[self.fieldNames objectAtIndex:6]];
        
        [self.chartViewContainer addSubview:self.barChartViewController.view];
    }
}

-(IBAction)showAttributesButtonClicked:(id)sender {
    if(self.doAnimation){
        [UIView beginAnimations:@"test" context:nil];
        //[UIView setAnimationDidStopSelector:@selector(finishAnimateOutReportForm)];
        [UIView setAnimationDuration:1.0];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        //[UIView setAnimationPosition:actualScreenPoint];
        [UIView setAnimationTransition:103 forView:self.view cache:YES];
        [UIView commitAnimations];
    }
    else{
        self.doAnimation = YES;
    }
    
    
    self.pdfWebView.hidden = YES;
    self.chartViewContainer.hidden = YES;
    self.tableViewContainer.hidden = NO;
    
    self.showAttributesButton.enabled = NO;
    self.showChartButton.enabled = YES;
}
-(IBAction)closeFButtonClicked:(id)sender {
    [self.delegate closeCallout];
}


-(void)refresh
{
    [self.leftTableView reloadData];
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
    static NSString *DetailsViewControllerCellIdentifier = @"DetailsViewControllerCellIdentifier";
    
	//as cells roll off screen get the reusable cell, if we can't create a new one
    CustomCalloutCell *cell = (CustomCalloutCell*)[tableView dequeueReusableCellWithIdentifier:DetailsViewControllerCellIdentifier];
    if (cell == nil) {
        cell = [[CustomCalloutCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:DetailsViewControllerCellIdentifier];
        CGRect frame = CGRectMake(316, 3, 314, 40);
        cell.valueLabel = [[UILabel alloc] initWithFrame:frame];
        [cell addSubview:cell.valueLabel];
    }
    
    
	//extract the attribute and its value and display both in the cell
    NSString *key = [self.fieldNames objectAtIndex:indexPath.row];
    cell.textLabel.text = [self.fieldAlias objectAtIndex:indexPath.row];
	cell.valueLabel.text = [NSString stringWithFormat:@"%@", [self.feature attributeAsStringForKey:key]];
	
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *columnName = [self.fieldNames objectAtIndex:indexPath.row];
    if (![columnName isEqualToString:@"TAPSEGNAM"]) {
        return;
    }
    
    if(self.doAnimation){
        [UIView beginAnimations:@"test" context:nil];
        //[UIView setAnimationDidStopSelector:@selector(finishAnimateOutReportForm)];
        [UIView setAnimationDuration:1.0];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        //[UIView setAnimationPosition:actualScreenPoint];
        [UIView setAnimationTransition:103 forView:self.view cache:YES];
        [UIView commitAnimations];
    }
    else{
        self.doAnimation = YES;
    }
    
    
    NSString *name = [self.feature attributeAsStringForKey:@"TAPSEGNAM"];
    NSLog(@"Tapstry segment name=%@", name);
    
    if(name) {
        name = [name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if(![name isEqualToString:@""]){
            int index=-1;
            for (int i=0; i<[self.tapstrySegNames count]; i++) {
                NSString *name2 = [self.tapstrySegNames objectAtIndex:i];
                if ([name2 caseInsensitiveCompare:name] == NSOrderedSame) {
                    index = i;
                    break;
                }
            }
            if (index<0) {
                return;
            }
            
            NSString *url = [NSString stringWithFormat:@"http://www.esri.com/data/esri_data/pdfs/tapestry/segment%d.pdf", index+1];
            NSLog(@"url=%@", url);
            
            NSURL *targetURL = [NSURL URLWithString:url];
            NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
            [self.pdfWebView loadRequest:request];
            
            self.pdfWebView.hidden = NO;
            self.chartViewContainer.hidden = YES;
            self.tableViewContainer.hidden = YES;
            
            self.showAttributesButton.enabled = YES;
            self.showChartButton.enabled = YES;
        }
    }
}


@end
