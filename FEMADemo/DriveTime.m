//
//  DriveTime.m
//  FEMADemo
//
//  Created by Frank on 3/18/13.
//  Copyright (c) 2013 Esri. All rights reserved.
//

#import "DriveTime.h"
#import <ArcGIS/ArcGIS.h>

@implementation DriveTime

@synthesize delegate;
@synthesize responses;

- (void) startWithRequest:(NSMutableURLRequest *) request
{
	NSLog(@"request is:%@",request);
	if (request)
	{
		[request setTimeoutInterval:90.0];
		NSURLConnection *mConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
		[mConnection start];
	}
    responses = [[NSMutableArray alloc] initWithCapacity:5];
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
    [responses addObject:myResponse];
    
    if ([myResponse hasSuffix:@"}}"]) {
        NSString *finalResponse = @"";
        for (int i=0; i<[self.responses count]; i++) {
            finalResponse = [NSString stringWithFormat:@"%@%@", finalResponse, [responses objectAtIndex:i]];
        }
        [self.delegate didReceiveResponseFromServer:finalResponse];
    }
}

- (void) connectionDidFinishLoading:(NSURLConnection*) connection
{
    
}

@end
