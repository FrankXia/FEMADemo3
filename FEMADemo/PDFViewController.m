//
//  PDFViewController.m
//  FEMADemo
//
//  Created by Frank on 3/21/13.
//  Copyright (c) 2013 Esri. All rights reserved.
//

#import "PDFViewController.h"

@interface PDFViewController ()

@end

@implementation PDFViewController

@synthesize pdfView1;
@synthesize pdfView2;
@synthesize closeButton;

@synthesize pdfURL1;
@synthesize pdfURL2;

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
    
    self.pdfView1.delegate = self;
    self.pdfView2.delegate = self;
    
    [self refresh];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) refresh
{
    if(self.pdfURL1) {
        NSLog(@"url1=%@", self.pdfURL1);
        NSURL *targetURL = [NSURL URLWithString:self.pdfURL1];
        NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
        [self.pdfView1 loadRequest:request];
    }
    if(self.pdfURL2) {
        NSLog(@"url2=%@", self.pdfURL2);
        NSURL *targetURL = [NSURL URLWithString:self.pdfURL2];
        NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
        [self.pdfView2 loadRequest:request];
    }
}

-(IBAction) closeWindow:(id)sender
{
    [self.delegate closePDFView];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"Start loading %@", webView);
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"Error in loading %@", error);
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"Done loading %@", webView);
}

@end
