//
//  SettingsViewController.h
//  Mobile Reporter
//
//  Created by Danny Hatcher on 9/26/11.
//  Copyright 2011 Esri. All rights reserved.
//

#import <UIKit/UIKit.h>

// Delegate for getting notified when the username or auto-locate values change
@protocol SettingsViewControllerDelegate <NSObject>

-(void)didChangeUserName:(NSString *)username andPassword:(NSString*)password;
-(void)didChangeDriveTimes:(NSString*)times;
-(void)doDriveTime:(BOOL)onOff;

@end


@interface SettingsViewController : UIViewController 

@property (nonatomic, weak) id<SettingsViewControllerDelegate> delegate;
@property (nonatomic, strong) IBOutlet UITextField *userNameTextField;
@property (nonatomic, strong) IBOutlet UITextField *passwordTextField;
@property (nonatomic, strong) IBOutlet UIButton *signInButton;

@property (nonatomic, strong) IBOutlet UITextField *driveTimeTextField;
@property (nonatomic, strong) IBOutlet UISwitch *driveTimeSwitch;

- (IBAction)signInButtonClicked:(id)sender;

- (IBAction)driveTimeChanged:(id)sender;
- (IBAction)driveTimeDidEndOnExit:(id)sender;

- (IBAction)doDriveTimeSwitchChanged:(id)sender;

- (void)runDriveTime;

@end
