//
//  DriveTime.h
//  FEMADemo
//
//  Created by Frank on 3/18/13.
//  Copyright (c) 2013 Esri. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DriveTimeResponseDelegate;

@interface DriveTime : NSObject

@property (nonatomic, weak) id <DriveTimeResponseDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *responses;

- (void) startWithRequest:(NSMutableURLRequest *) request;

@end


@protocol DriveTimeResponseDelegate <NSObject>
- (void)didReceiveResponseFromServer:(NSString*)serverResponse;
- (void)didReceiveErrorFromServer:(NSString*)serverResponse;
@end
