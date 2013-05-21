//
//  PDFViewController.h
//  FEMADemo
//
//  Created by Frank on 3/21/13.
//  Copyright (c) 2013 Esri. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PDFViewControllerDelegate <NSObject>

-(void)closePDFView;

@end

@interface PDFViewController : UIViewController <UIWebViewDelegate>

@property (nonatomic, weak) id<PDFViewControllerDelegate> delegate;

@property (nonatomic, strong) IBOutlet UIWebView *pdfView1;
@property (nonatomic, strong) IBOutlet UIWebView *pdfView2;
@property (nonatomic, strong) IBOutlet UIButton *closeButton;

@property (nonatomic, strong) NSString *pdfURL1;
@property (nonatomic, strong) NSString *pdfURL2;

-(IBAction) closeWindow:(id)sender;
- (void) refresh;

@end
