//
//  FEMADemoViewController.m
//  FEMADemo
//
//  Created by Frank on 3/15/13.
//  Copyright (c) 2013 Esri. All rights reserved.
//

#import "FEMADemoViewController.h"

#import "TOCViewController.h"
#import "DriveTime.h"

@interface FEMADemoViewController ()

@property (nonatomic, strong) TOCViewController *tocViewController;


@end


#define kOperationalLayerURL0 @"http://server.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer"

#define kOperationalLayerURL1 @"http://server.arcgisonline.com/ArcGIS/rest/services/World_Topo_Map/MapServer"
#define kOperationalLayerURL1a @"http://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer"

//#define kOperationalLayerURL2 @"http://wdcb4.esri.com/arcgis/rest/services/201211_HurricaneSandy/SandyInundation/MapServer"
//#define kOperationalLayerURL2 @"https://cigtdc.esri.com/secrest/services/FEMA_DEMO/SandyAdvisory/MapServer"
#define kOperationalLayerURL2 @"http://107.20.167.42/ArcGIS/rest/services/Sandy/SandyAdvisory/MapServer"

#define kOperationalLayerURL3 @"http://server.arcgisonline.com/ArcGIS/rest/services/Demographics/USA_Population_Density/MapServer"
#define kOperationalLayerURL4 @"http://gis.fema.gov/REST/services/FEMA/EvacRoutes/MapServer"

//#define kOperationalLayerURL5 @"http://wdcb4.esri.com/arcgis/rest/services/201205_AGSFW/ACFloodInundation/MapServer"

//#define kOperationalLayerURL6 @"http://wdcb4.esri.com/arcgis/rest/services/201211_HurricaneSandy/SandyDemographic/MapServer"
//#define kOperationalLayerURL6a @"http://wdcb4.esri.com/arcgis/rest/services/201211_HurricaneSandy/SandyDemographic/FeatureServer/0"

//#define kOperationalLayerURL6 @"https://cigtdc.esri.com/secrest/services/FEMA_DEMO/USNGGrids/MapServer"
//#define kOperationalLayerURL6a @"https://cigtdc.esri.com/secrest/services/FEMA_DEMO/USNGGrids/MapServer/1"
#define kOperationalLayerURL6 @"http://107.20.167.42/ArcGIS/rest/services/Sandy/USNGGrids/MapServer"
#define kOperationalLayerURL6a @"http://107.20.167.42/ArcGIS/rest/services/Sandy/USNGGrids/MapServer/1"
#define kNameTitle6 @"USNG Population at Risk"

//#define kOperationalLayerURL7 @"http://wdcb4.esri.com/arcgis/rest/services/201211_HurricaneSandy/HurricaneSandy/MapServer"
//#define kOperationalLayerURL7 @"https://cigtdc.esri.com/secrest/services/FEMA_DEMO/EvacCone/MapServer"
#define kOperationalLayerURL7 @"http://107.20.167.42/ArcGIS/rest/services/Sandy/EvacCone/MapServer"

//#define kOperationalLayerURL8 @"http://wdcb4.esri.com/arcgis/rest/services/201211_HurricaneSandy/Schools/MapServer"
//#define kOperationalLayerURL8a @"http://wdcb4.esri.com/arcgis/rest/services/201211_HurricaneSandy/Schools/MapServer/0"

//#define kOperationalLayerURL8 @"https://cigtdc.esri.com/secrest/services/FEMA_DEMO/Shelters/MapServer"
#define kOperationalLayerURL8 @"http://107.20.167.42/ArcGIS/rest/services/Sandy/Shelters/MapServer"
#define kNameTitle8 @"Shelters"


@implementation FEMADemoViewController

@synthesize mapView;
@synthesize tocButton;
@synthesize tocViewController;
@synthesize popOverController;

@synthesize myLayerDelegate;
@synthesize tocViewVisible;
@synthesize travelZoneGraphicsLayer;
@synthesize startPointGraphicsLayer;

@synthesize settingsButton;
@synthesize settingsPopoverController;
@synthesize settingsViewController;

@synthesize userName;
@synthesize password;
@synthesize driveTimeInMinutes;

@synthesize statusLabel;
@synthesize statusView;
@synthesize activityIndicator;

@synthesize query;
@synthesize queryTask;
@synthesize customCalloutViewController;
@synthesize fieldNames;
@synthesize fieldAlias;

@synthesize runDriveTime;
@synthesize pdfViewController;

@synthesize schoolCalloutViewController;
@synthesize schoolQuery;
@synthesize schoolQueryTask;
@synthesize schoolFieldAlias;
@synthesize schoolFieldNames;

@synthesize identifyParameters;
@synthesize identifyTask;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.userName = @"FrankXia2013";
    self.password = @"forFEMAdemo";
    self.driveTimeInMinutes = @"30";
    self.mapView.touchDelegate = self;
    self.runDriveTime = NO;
    
    //create the toc view controller
    self.tocViewController = [[TOCViewController alloc] initWithMapView:self.mapView];
    self.tocViewController.demoViewController = self;
	
    //add the base map.
	NSURL *mapUrl = [NSURL URLWithString:kOperationalLayerURL0];
	AGSTiledMapServiceLayer *tiledLyr = [AGSTiledMapServiceLayer tiledMapServiceLayerWithURL:mapUrl];
    tiledLyr.opacity = 0.9999;
	[self.mapView addMapLayer:tiledLyr withName:@"World Street Map"];
    
	NSURL *mapUrl1 = [NSURL URLWithString:kOperationalLayerURL1];
	AGSTiledMapServiceLayer *tiledLyr1 = [AGSTiledMapServiceLayer tiledMapServiceLayerWithURL:mapUrl1];
	[self.mapView addMapLayer:tiledLyr1 withName:@"World Topo Map"];
    tiledLyr1.opacity = 0.9999;
    tiledLyr1.visible = NO;
    
	NSURL *mapUrl1a = [NSURL URLWithString:kOperationalLayerURL1a];
	AGSTiledMapServiceLayer *tiledLyr1a = [AGSTiledMapServiceLayer tiledMapServiceLayerWithURL:mapUrl1a];
	[self.mapView addMapLayer:tiledLyr1a withName:@"World Imagery"];
    tiledLyr1a.opacity = 0.9999;
    tiledLyr1a.visible = NO;
    
    
    NSURL *mapUrl7 = [NSURL URLWithString:kOperationalLayerURL7];
	AGSDynamicMapServiceLayer *dynamicLyr7 = [AGSDynamicMapServiceLayer dynamicMapServiceLayerWithURL:mapUrl7];
	[self.mapView addMapLayer:dynamicLyr7 withName:@"Hurricane_Sandy"];
    //dynamicLyr7.visible = NO;
    
    NSURL *mapUrl2 = [NSURL URLWithString:kOperationalLayerURL2];
	AGSDynamicMapServiceLayer *tiledLyr2 = [AGSDynamicMapServiceLayer dynamicMapServiceLayerWithURL:mapUrl2];
	//AGSTiledMapServiceLayer *tiledLyr2 = [AGSTiledMapServiceLayer tiledMapServiceLayerWithURL:mapUrl2];
	[self.mapView addMapLayer:tiledLyr2 withName:@"Hurricane Sandy Inundation"];
    tiledLyr2.visible = NO;
    tiledLyr2.opacity = 0.75;
    
    
    NSURL *mapUrl3 = [NSURL URLWithString:kOperationalLayerURL3];
	AGSDynamicMapServiceLayer *dynamicLyr3 = [AGSDynamicMapServiceLayer dynamicMapServiceLayerWithURL:mapUrl3];
	[self.mapView addMapLayer:dynamicLyr3 withName:@"US Population Density"];
    dynamicLyr3.visible = NO;
    dynamicLyr3.opacity = 0.5;
    
    myLayerDelegate = [[MyLayerDelegate alloc] init];
    dynamicLyr3.delegate = myLayerDelegate;
    
    
//    NSURL *mapUrl5 = [NSURL URLWithString:kOperationalLayerURL5];
//	AGSDynamicMapServiceLayer *dynamicLyr5 = [AGSDynamicMapServiceLayer dynamicMapServiceLayerWithURL:mapUrl5];
//	[self.mapView addMapLayer:dynamicLyr5 withName:@"Inundation Grids"];
//    dynamicLyr5.visible = NO;
//    dynamicLyr5.opacity = 0.5;
    
    NSURL *mapUrl6 = [NSURL URLWithString:kOperationalLayerURL6];
	AGSDynamicMapServiceLayer *dynamicLyr6 = [AGSDynamicMapServiceLayer dynamicMapServiceLayerWithURL:mapUrl6];
	[self.mapView addMapLayer:dynamicLyr6 withName:kNameTitle6];
    dynamicLyr6.visible = NO;
    dynamicLyr6.opacity = 0.5;
    
    
    NSURL *mapUrl4 = [NSURL URLWithString:kOperationalLayerURL4];
	AGSDynamicMapServiceLayer *dynamicLyr4 = [AGSDynamicMapServiceLayer dynamicMapServiceLayerWithURL:mapUrl4];
	[self.mapView addMapLayer:dynamicLyr4 withName:@"FEMA Evacuation Routes"];
    dynamicLyr4.visible = NO;
    
    
//    //add a tiled layer
//    NSURL *mapUrl5 = [NSURL URLWithString:kOperationalLayerURL5];
//	AGSTiledMapServiceLayer *tiledLyr5 = [AGSTiledMapServiceLayer tiledMapServiceLayerWithURL:mapUrl5];
//	[self.mapView addMapLayer:tiledLyr5 withName:@"Soil Survey"];
    
//    //add a feature layer.
//    AGSFeatureLayer *featureLayer = [AGSFeatureLayer featureServiceLayerWithURL:[NSURL URLWithString:kOperationalLayerURL6a] mode:AGSFeatureLayerModeOnDemand];
//    [self.mapView addMapLayer:featureLayer withName:@"USNG Demographics"];
    
    
    NSURL *mapUrl8 = [NSURL URLWithString:kOperationalLayerURL8];
	AGSDynamicMapServiceLayer *dynamicLyr8 = [AGSDynamicMapServiceLayer dynamicMapServiceLayerWithURL:mapUrl8];
	[self.mapView addMapLayer:dynamicLyr8 withName:kNameTitle8];
    dynamicLyr8.visible = NO;

    
    self.travelZoneGraphicsLayer = [AGSGraphicsLayer graphicsLayer];
    [self.mapView addMapLayer:self.travelZoneGraphicsLayer withName:@"Driving Time"];
    self.travelZoneGraphicsLayer.visible = YES;
    
    //add  graphics layer
    self.startPointGraphicsLayer = [AGSGraphicsLayer graphicsLayer];
    [self.mapView addMapLayer:self.startPointGraphicsLayer withName:@"Start Point"];
    self.startPointGraphicsLayer.visible = YES;
    
    
    //Zooming to an initial envelope with the specified spatial reference of the map.
	AGSSpatialReference *sr = [AGSSpatialReference webMercatorSpatialReference];
	AGSEnvelope *env = [AGSEnvelope envelopeWithXmin:-9173149.507945796
                                                ymin:4477524.169702369
                                                xmax:-7049111.567912629
                                                ymax:6031138.965246198
									spatialReference:sr];
	[self.mapView zoomToEnvelope:env animated:YES];
    self.tocViewVisible = NO;
    
    self.settingsViewController = [[SettingsViewController alloc] init];
    self.settingsPopoverController = [[UIPopoverController alloc] initWithContentViewController:self.settingsViewController];
    self.settingsPopoverController.popoverContentSize = CGSizeMake(250, 338);
    self.settingsViewController.delegate = self;
    
    //
	// make our status view look good
	self.statusView.layer.cornerRadius = 6;
	self.statusView.layer.borderColor = [UIColor whiteColor].CGColor;
	self.statusView.layer.borderWidth = 1;
	self.statusView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5];
    
    //set up query task against layer, specify the delegate
	self.queryTask = [AGSQueryTask queryTaskWithURL:[NSURL URLWithString:kOperationalLayerURL6a]];
	self.queryTask.delegate = self;
	
	//return all fields in query
	self.query = [AGSQuery query];
    self.query.returnGeometry = YES;
	self.query.outFields = [NSArray arrayWithObjects:@"*", nil];
    
    self.fieldNames = [[NSArray alloc] initWithObjects:@"TOTPOP_CY",@"NIGHTPOP",@"DAYPOP", @"POP_0TO9", @"POP_65",@"MEDHINC_CY", @"ACSOVEH0", @"TAPSEGNAM", @"COUNTY_NAME",@"STATE_NAME", nil];
    self.fieldAlias = [[NSArray alloc] initWithObjects:@"2011 Total Population", @"Night Population",@"Day Population",@"Chidren",@"Seniors",@"Median House Hold Income", @"Households With No Vehicle",  @"Tapstry Segment", @"County Name",@"State Name", nil];

    self.customCalloutViewController = [[CustomCalloutViewController alloc] initWithNibName:@"CustomCalloutViewController" bundle:nil];
    self.customCalloutViewController.fieldNames = self.fieldNames;
    self.customCalloutViewController.fieldAlias = self.fieldAlias;
    self.customCalloutViewController.delegate = self;
    
//    //set up query task against layer, specify the delegate
//	self.schoolQueryTask = [AGSQueryTask queryTaskWithURL:[NSURL URLWithString:kOperationalLayerURL8a]];
//	self.schoolQueryTask.delegate = self;
//	
//	//return all fields in query
//	self.schoolQuery = [AGSQuery query];
//	self.schoolQuery.outFields = [NSArray arrayWithObjects:@"*", nil];
    
//    self.fieldNames = [[NSArray alloc] initWithObjects:@"CONAME",@"ADDR",@"CITY16", @"STATE_NAME", nil];
//    self.fieldAlias = [[NSArray alloc] initWithObjects:@"Name", @"Address",@"City",@"State", nil];
    self.schoolFieldNames = [[NSArray alloc] initWithObjects:@"Business Name",@"Address",@"City", @"State Name", nil];
    self.schoolFieldAlias = [[NSArray alloc] initWithObjects:@"Name", @"Address",@"City",@"State", nil];

    
    self.schoolCalloutViewController = [[SchoolCalloutViewController alloc] initWithNibName:@"SchoolCalloutViewController" bundle:nil];
    self.schoolCalloutViewController.fieldNames = self.schoolFieldNames;
    self.schoolCalloutViewController.fieldAlias = self.schoolFieldAlias;
    self.schoolCalloutViewController.delegate = self;
    
    
    //create identify task
	self.identifyTask = [AGSIdentifyTask identifyTaskWithURL:[NSURL URLWithString:kOperationalLayerURL8]];
	self.identifyTask.delegate = self;
	
	//create identify parameters
	self.identifyParameters = [[AGSIdentifyParameters alloc] init];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateStatus:(NSString*)status showActivity:(BOOL)activity{
	
	if (status.length > 0){
		self.statusView.hidden = NO;
		
		// animate in...
		if (!CGAffineTransformEqualToTransform(self.statusView.transform, CGAffineTransformIdentity)){
            [UIView beginAnimations:@"statusIn" context:nil];
            [UIView setAnimationDuration:0.25];
            self.statusView.transform = CGAffineTransformIdentity;
            [UIView commitAnimations];
        }
	}
	
	self.statusLabel.text = status;
	if (activity){
		[self.activityIndicator startAnimating];
	}
	else {
		[self.activityIndicator stopAnimating];
	}
    
}

-(void)updateStatusToEmpty{
	[self updateStatus:@"" showActivity:NO];
	//self.statusView.hidden = YES;
	
	// animate out
	[UIView beginAnimations:@"statusOut" context:nil];
	[UIView setAnimationDuration:0.25];
	self.statusView.transform = CGAffineTransformMakeTranslation(self.statusView.frame.size.width + 200, 0);
	[UIView commitAnimations];
}

- (IBAction)presentSettings:(id)sender {
    // open the popup view for the settings
    if (self.settingsPopoverController.isPopoverVisible) {
        [self.settingsPopoverController dismissPopoverAnimated:YES];
    } else {
        CGRect rect = self.settingsButton.frame;
        [self.settingsPopoverController presentPopoverFromRect:rect inView:self.mapView permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
}

- (IBAction)presentTableOfContents:(id)sender
{
    //If iPad, show legend in the PopOver, else transition to the separate view controller
	if([[AGSDevice currentDevice] isIPad]) {
        if(!self.popOverController) {
            self.popOverController = [[UIPopoverController alloc] initWithContentViewController:self.tocViewController];
            self.tocViewController.popOverController = self.popOverController;
            self.popOverController.popoverContentSize = CGSizeMake(320, 500);
            self.popOverController.passthroughViews = [NSArray arrayWithObject:self.view];
        }
        if(self.tocViewVisible) {
            [self.popOverController dismissPopoverAnimated:YES];
            self.tocViewVisible = NO;
        }else {
            self.tocViewVisible = YES;
            [self.popOverController presentPopoverFromRect:self.tocButton.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES ];
        }
	}
    else {
		[self presentModalViewController:self.tocViewController animated:YES];
	}
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)viewDidUnload {
    
    [super viewDidUnload];
	self.mapView = nil;
	self.tocButton = nil;
    self.tocViewController = nil;
    if([[AGSDevice currentDevice] isIPad])
        self.popOverController = nil;
}

#pragma mark AGSMapViewTouchDelegate

- (void)mapView:(AGSMapView *)mapView didClickAtPoint:(CGPoint)screen mapPoint:(AGSPoint *)mappoint graphics:(NSDictionary *)graphics {
    NSLog(@"Querying BAO Server");
    
    if (self.tocViewVisible) {
        [self.popOverController dismissPopoverAnimated:YES];
        self.tocViewVisible = NO;
        return;
    }
    
    [self.startPointGraphicsLayer removeAllGraphics];
    AGSSimpleMarkerSymbol *markerSymbol = [AGSSimpleMarkerSymbol simpleMarkerSymbolWithColor:[UIColor blueColor]];
    markerSymbol.size = CGSizeMake(15, 15);
    AGSGraphic  *graphic = [AGSGraphic graphicWithGeometry:mappoint symbol:markerSymbol attributes:nil infoTemplateDelegate:nil];
    [self.startPointGraphicsLayer addGraphic:graphic];
    
    
    if (self.runDriveTime) {
        NSString *FORMAT_STRING = @"json";
        
        // query BAO Server with the given point for a half-hour driving area
        //NSString *getTokenURLString = @"https://baoapi.esri.com/rest/authentication";
        NSString *getTokenURLString = [[NSString alloc] initWithFormat:@"https://baoapi.esri.com:443/rest/authentication?request=%@&username=%@&password=%@&f=%@", @"getToken", userName, password, FORMAT_STRING];
        
        NSString *getTokenURLEncodedString = [getTokenURLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *getTokenUrl = [[NSURL alloc] initWithString:getTokenURLEncodedString];
        NSMutableURLRequest *req = [[NSMutableURLRequest alloc] initWithURL:getTokenUrl];
        NSURLConnection		*mConnection = [[NSURLConnection alloc] initWithRequest:req delegate:self];
        [mConnection start];
        
    }else {
        AGSLayer *schoolLayer = [self.mapView mapLayerForName:kNameTitle8];
        AGSLayer *gridLayer = [self.mapView mapLayerForName:kNameTitle6];
        
        if(schoolLayer.visible) {
            // do a query against Schools layer
            //the layer we want is layer ‘0’ (from the map service doc)
            self.identifyParameters.layerIds = [NSArray arrayWithObjects:[NSNumber numberWithInt:0], nil];
            self.identifyParameters.tolerance = 7;
            self.identifyParameters.geometry = mappoint;
            self.identifyParameters.size = self.mapView.bounds.size;
            self.identifyParameters.mapEnvelope = self.mapView.visibleArea.envelope;
            self.identifyParameters.returnGeometry = YES;
            self.identifyParameters.layerOption = AGSIdentifyParametersLayerOptionAll;
            self.identifyParameters.spatialReference = self.mapView.spatialReference;
            
            //execute the task
            [self.identifyTask executeWithParameters:self.identifyParameters];
        }
        else if(gridLayer.visible) {
            // do a query against USNG-Demograpics
            self.query.geometry = mappoint;
            self.query.outSpatialReference = self.mapView.spatialReference;
            [self.queryTask executeWithQuery:self.query];
        }
        else {
            [self.startPointGraphicsLayer removeAllGraphics];
        }
    }
}

#pragma mark -
#pragma mark NSURLConnection Delegates

- (void) connection:(NSURLConnection *) connection didReceiveResponse:(NSURLResponse *) response
{
    NSLog(@"didReceiveResponse is:%@",response);
}

- (void) connection:(NSURLConnection *) connection didReceiveData:(NSData *) data
{
    NSString *myResponse = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    //NSLog(@"didReceiveData myResposne is:%@",myResponse);
    
    //convert to json dictionary
    NSDictionary* jsonDict = [myResponse ags_JSONValue];
    
    NSDictionary* results = [jsonDict objectForKey:@"results"];
    self.token = [results valueForKey:@"token"];
    NSLog(@"token=%@", self.token);
    
    if(self.token) {
        [self calculateDriveTime];
    }
}

- (void) connectionDidFinishLoading:(NSURLConnection*) connection
{
    
}

- (void) calculateDriveTime
{
    if(!self.token || self.runDriveTime==NO)return;
    
    NSString *msg = [NSString stringWithFormat:@"Calculating %@ minutes driving area ...", self.driveTimeInMinutes];
    [self updateStatus:msg showActivity:YES];
    
    NSString *distanceUnits = @"esriDriveTimeUnitsMinutes";
    NSString *FORMAT_STRING = @"json";
    NSString *radii = self.driveTimeInMinutes;  //[NSString stringWithFormat:@"%d", self.driveTimeInMinutes];    //@"30"; //@"30;45;60";
    NSString *outputType = @"GetFeatureClass";
    
    //NSString *stores = @"{\"RecordSet\":{\"geometryType\":\"esriGeometryPoint\",\"spatialReference\":{\"wkid\":102100},\"features\":[{\"geometry\":{\"x\":-13044845.175361,\"y\":4034542.005670,\"spatialReference\":{\"wkid\":102100}},\"attributes\":{\"STORE_ID\":\"1\"}}]},\"SpatialReference\":{\"wkid\":102100}}";

    AGSGraphic *g = [self.startPointGraphicsLayer.graphics objectAtIndex:0];
    AGSPoint *location = (AGSPoint*)g.geometry;
    NSString *stores = [NSString stringWithFormat:@"{\"RecordSet\":{\"geometryType\":\"esriGeometryPoint\",\"spatialReference\":{\"wkid\":102100},\"features\":[{\"geometry\":{\"x\":%f,\"y\":%f,\"spatialReference\":{\"wkid\":102100}},\"attributes\":{\"STORE_ID\":\"1\"}}]},\"SpatialReference\":{\"wkid\":102100}}", location.x, location.y];

    
    NSString * urlString = [NSString stringWithFormat:@"http://baoapi.esri.com/rest/report/DriveTime?DistanceUnits=%@&f=%@&Radii=%@&Token=%@&TaskOutputType=%@&Stores=%@", distanceUnits, FORMAT_STRING, radii, self.token, outputType, stores];
    
    NSString *urlEncodedString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *serviceUrl = [[NSURL alloc] initWithString:urlEncodedString];
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] initWithURL:serviceUrl];
    
    if(self.driveTime==nil) {
        self.driveTime = [[DriveTime alloc] init];
        self.driveTime.delegate = self;
    }
    
    [self.driveTime startWithRequest:req];
}

#pragma mark
#pragma DriveTimeResponseDelegate

- (void)didReceiveResponseFromServer:(NSString*)serverResponse {
    //NSLog(@"Final response=>%@", serverResponse);
    
    //convert to json dictionary
    NSDictionary* jsonDict = [serverResponse ags_JSONValue];
    //NSLog(@"jsonDict %@", jsonDict);
    
    AGSSimpleFillSymbol *fillSymbol = [AGSSimpleFillSymbol simpleFillSymbol];
    fillSymbol.color = [[UIColor blackColor] colorWithAlphaComponent:0.25];
    fillSymbol.outline.color = [UIColor darkGrayColor];
    
    AGSSimpleFillSymbol *fillSymbol2 = [AGSSimpleFillSymbol simpleFillSymbol];
    fillSymbol2.color = [[UIColor brownColor] colorWithAlphaComponent:0.25];
    fillSymbol2.outline.color = [UIColor darkGrayColor];
    
    AGSSimpleFillSymbol *fillSymbol3 = [AGSSimpleFillSymbol simpleFillSymbol];
    fillSymbol3.color = [[UIColor yellowColor] colorWithAlphaComponent:0.25];
    fillSymbol3.outline.color = [UIColor darkGrayColor];
    
    AGSFeatureSet *featureSet = [[AGSFeatureSet alloc] initWithJSON:[jsonDict objectForKey:@"RecordSet"]];
    NSLog(@"# of features=%d", [[featureSet features] count]);
    [self.travelZoneGraphicsLayer removeAllGraphics];
    
    for (int i=0; i<[featureSet.features count]; i++) {
        AGSGraphic *graphic = [featureSet.features objectAtIndex:i];
        if(i==0)
            graphic.symbol = fillSymbol;
        else if(i==1)
            graphic.symbol = fillSymbol2;
        else
            graphic.symbol = fillSymbol3;
            
        [self.travelZoneGraphicsLayer addGraphic:graphic];
    }
    
    self.travelZoneGraphicsLayer.visible = YES;
    
    [self updateStatusToEmpty];
}
- (void)didReceiveErrorFromServer:(NSString*)serverResponse {
    
}

-(void)doDriveTime:(BOOL)onOff
{
    self.runDriveTime = onOff;
    if(self.runDriveTime==NO) {
        [self.travelZoneGraphicsLayer removeAllGraphics];
    }
}

#pragma mark
#pragma SettingsViewControllerDelegate

-(void)didChangeUserName:(NSString *)user_name andPassword:(NSString*)pass_word {
    if(user_name && pass_word) {
        self.userName = user_name;
        self.password = pass_word;
    }
}
-(void)didChangeDriveTimes:(NSString*)times
{
    
    if(![times isEqualToString:self.driveTimeInMinutes]) {
        self.driveTimeInMinutes = times;
        [self calculateDriveTime];
    }
}

#pragma mark AGSQueryTaskDelegate

//results are returned
- (void)queryTask:(AGSQueryTask *)querytask operation:(NSOperation *)op didExecuteWithFeatureSetResult:(AGSFeatureSet *)featureSet {
	NSLog(@"# of features=%d", [featureSet.features count]);

    if (featureSet && [featureSet.features count] >0) {
        AGSGraphic *feature = [featureSet.features objectAtIndex:0];
        
        if (querytask == self.schoolQueryTask) {
            self.schoolCalloutViewController.feature = feature;
            //assign the hybrid map view to the callout view of the main map view
            self.mapView.callout.customView = self.schoolCalloutViewController.view;
            
            AGSSimpleMarkerSymbol *markerSymbol = [AGSSimpleMarkerSymbol simpleMarkerSymbolWithColor:[UIColor blueColor]];
            feature.symbol = markerSymbol;
            [self.startPointGraphicsLayer removeAllGraphics];
            [self.startPointGraphicsLayer addGraphic:feature];
            
            CGPoint offset = CGPointMake(1, -8);
            AGSPoint *g = (AGSPoint*)(feature);
            
            [self.mapView.callout showCalloutAt:g pixelOffset:offset animated:YES];
        }
        else if (querytask == self.queryTask) {
             self.customCalloutViewController.feature = feature;
            //assign the hybrid map view to the callout view of the main map view
            self.mapView.callout.customView = self.customCalloutViewController.view;
            
            AGSSimpleLineSymbol *outline = [AGSSimpleLineSymbol simpleLineSymbol];
            outline.color = [UIColor blueColor];
            
            AGSSimpleFillSymbol *fillSymbol = [AGSSimpleFillSymbol simpleFillSymbol];
            fillSymbol.color = [[UIColor blackColor] colorWithAlphaComponent:0.25];
            fillSymbol.outline.color = [UIColor darkGrayColor];
            fillSymbol.outline = outline;
            feature.symbol = fillSymbol;
            [self.startPointGraphicsLayer removeAllGraphics];
            [self.startPointGraphicsLayer addGraphic:feature];
            
//            NSLog(@"feature=%@, # of graphics=%d", feature, [self.startPointGraphicsLayer.graphics count]);
            
            CGPoint offset = CGPointMake(1, -8);
            AGSPoint *g = (AGSPoint*)(((AGSPolygon*)feature.geometry).envelope.center);
            
            self.customCalloutViewController.doAnimation = NO;
            [self.mapView.callout showCalloutAt:g pixelOffset:offset animated:YES];
            [self.customCalloutViewController showAttributesButtonClicked:nil];
            [self.customCalloutViewController refresh];
        }
    }
}

//if there's an error with the query display it to the user
- (void)queryTask:(AGSQueryTask *)queryTask operation:(NSOperation *)op didFailWithError:(NSError *)error {
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
														message:[error localizedDescription]
													   delegate:nil
											  cancelButtonTitle:@"OK"
											  otherButtonTitles:nil];
	[alertView show];
}

#pragma mark - AGSIdentifyTaskDelegate methods
//results are returned
- (void)identifyTask:(AGSIdentifyTask *)identifyTask operation:(NSOperation *)op didExecuteWithIdentifyResults:(NSArray *)results {
    
    //clear previous results
    [self.startPointGraphicsLayer removeAllGraphics];
    
    if ([results count] > 0) {
        
        //add new results
        AGSSymbol* symbol = [AGSSimpleFillSymbol simpleFillSymbol];
        symbol.color = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.5];
        
        AGSGraphic *feature = nil;
        
        // for each result, set the symbol and add it to the graphics layer
        for (AGSIdentifyResult* result in results) {
            result.feature.symbol = symbol;
            [self.startPointGraphicsLayer addGraphic:result.feature];
            feature = result.feature;
        }
        
        self.schoolCalloutViewController.feature = feature;
        //assign the hybrid map view to the callout view of the main map view
        self.mapView.callout.customView = self.schoolCalloutViewController.view;
        
        AGSSimpleMarkerSymbol *markerSymbol = [AGSSimpleMarkerSymbol simpleMarkerSymbolWithColor:[UIColor blueColor]];
        feature.symbol = markerSymbol;
        [self.startPointGraphicsLayer removeAllGraphics];
        [self.startPointGraphicsLayer addGraphic:feature];
        
        CGPoint offset = CGPointMake(1, -8);
        AGSPoint *g = (AGSPoint*)(feature.geometry);
        [self.mapView.callout showCalloutAt:g pixelOffset:offset animated:YES];
        
        [self.schoolCalloutViewController refresh];
    }
    
    //call dataChanged on the graphics layer to redraw the graphics
    [self.startPointGraphicsLayer refresh];
}


//if there's an error with the query display it to the user
- (void)identifyTask:(AGSIdentifyTask *)identifyTask operation:(NSOperation *)op didFailWithError:(NSError *)error {
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
													message:[error localizedDescription]
												   delegate:nil
										  cancelButtonTitle:@"OK"
										  otherButtonTitles:nil];
	[alert show];
}

#pragma mark
#pragma CustomCalloutViewControllerDelegate

-(void)closeCallout
{
    [self.mapView.callout dismiss];
    [self.startPointGraphicsLayer removeAllGraphics];
}

-(void)showPDFViewWithUrl:(NSString*)url1 andUrl:(NSString*)url2
{
    if(!self.pdfViewController) {
        self.pdfViewController = [[PDFViewController alloc] initWithNibName:@"PDFViewController" bundle:nil];
        self.pdfViewController.delegate = self;
    }
    self.pdfViewController.pdfURL1 = url1;
    self.pdfViewController.pdfURL2 = url2;
    [self.pdfViewController refresh];
    
    [self presentViewController:self.pdfViewController animated:YES completion:nil];
}

#pragma mark
#pragma  PDFViewControllerDelegate

-(void)closePDFView {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark
#pragma SchoolCalloutViewControllerDelegate
-(void)closeSchoolCallout
{
    [self.mapView.callout dismiss];
}

@end
