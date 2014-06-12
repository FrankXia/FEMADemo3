//
//  SettingsViewController.m
//  Mobile Reporter
//
//  Created by Danny Hatcher on 9/26/11.
//  Copyright 2011 Esri. All rights reserved.
//

#import "SettingsViewController.h"

@implementation SettingsViewController

@synthesize userNameTextField;
@synthesize passwordTextField;
@synthesize driveTimeTextField;
@synthesize driveTimeSwitch;

@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.userNameTextField .text = @"FrankXia2013";
    self.passwordTextField .text = @"forFEMAdemo";
    self.driveTimeTextField.text = @"15";
    
    self.driveTimeTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setUserNameTextField:nil];
    [self setDelegate:nil];
    
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (IBAction)signInButtonClicked:(id)sender {
    [self.delegate didChangeUserName:self.userNameTextField.text  andPassword:self.passwordTextField.text];
}


- (IBAction)driveTimeChanged:(id)sender {
    NSString *s = self.driveTimeTextField.text;
    if ([[s componentsSeparatedByString:@","] count] > 1) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Drive times must be separated by semicolon ';'" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }else {
        [self runDriveTime];
    }
}

- (IBAction)driveTimeDidEndOnExit:(id)sender {
    NSString *s = self.driveTimeTextField.text;
    if ([[s componentsSeparatedByString:@","] count] > 1) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Drive times must be separated by semicolon ';'" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }else {
        [self runDriveTime];
    }
}

- (IBAction)doDriveTimeSwitchChanged:(id)sender
{
    [self.delegate doDriveTime:self.driveTimeSwitch.on];
}

- (void)runDriveTime
{
    [self.delegate didChangeDriveTimes:self.driveTimeTextField.text];
}

@end
