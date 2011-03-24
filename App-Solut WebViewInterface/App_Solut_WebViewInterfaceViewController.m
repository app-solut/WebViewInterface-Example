//
//  App_Solut_WebViewInterfaceViewController.m
//  App-Solut WebViewInterface
//
//  Created by thorben on 24.03.11.
//  Copyright 2011 XINFO blog.app-solut.com. All rights reserved.
//

#import "App_Solut_WebViewInterfaceViewController.h"

@implementation App_Solut_WebViewInterfaceViewController

@synthesize webView;
@synthesize label;
@synthesize call;

- (void)dealloc
{
    [super dealloc];
}

-(void)viewDidLoad {
    NSLog(@"Loading view");
    // disable bouncing of webView...
    
	UIScrollView* sv = nil;
	for(UIView* v in self.webView.subviews) {
		if([v isKindOfClass:[UIScrollView class]]) {
			sv = (UIScrollView*) v;
			//sv.scrollEnabled = NO;
			sv.bounces = NO;
		}
	}
	NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"]];
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
	[webView loadRequest:requestObj];
}

- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
	NSString *url = [[request URL] absoluteString];
	
	NSLog(@"Requesting: %@",url);
	
	NSArray *urlArray = [url componentsSeparatedByString:@"?"];
	NSString *cmd = @"";
	NSMutableArray *paramsToPass = nil;
	if([urlArray count] > 1){
		NSString *paramsString = [urlArray objectAtIndex:1];
		NSArray *urlParamsArray = [paramsString componentsSeparatedByString:@"&"];
		cmd = [[[urlParamsArray objectAtIndex:0] componentsSeparatedByString:@"="] objectAtIndex:1];
		int numCommands = [urlParamsArray count];
		paramsToPass = [[NSMutableArray alloc] initWithCapacity:numCommands-1];
		for(int i = 1; i < numCommands; i++){
			NSString *aParam = [[[urlParamsArray objectAtIndex:i] componentsSeparatedByString:@"="] objectAtIndex:1];
			
			[paramsToPass addObject:aParam];
		}
	}
	
	if([cmd compare:@"toggleWorking"] == NSOrderedSame){
		NSLog(@"Turning working indicator...");
		if([UIApplication sharedApplication].networkActivityIndicatorVisible == NO) {
			[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
			NSLog(@"...on");
		} else {
			[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
			NSLog(@"...off");
		}
    } else if([cmd compare:@"remove"] == NSOrderedSame) {
		
		[label setText:@"All buttons removed!"]; //[NSString stringWithFormat:@"%d",itemId]];		
	} else if([cmd compare:@"call"] == NSOrderedSame) {
		NSString *message = [[paramsToPass objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
		
		[label setText:[NSString stringWithFormat:@"You just clicked button #%@", message]]; //[NSString stringWithFormat:@"%d",itemId]];		
		
	} else if([cmd compare:@"logMessage"] == NSOrderedSame) {
		NSString *message = [[paramsToPass objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
		NSLog(@"Received JS message: %@",message);
	}
	/*
	 * Only load the page if it is not an appcall
	 */
	NSRange aSubStringRange = [url rangeOfString:@"appcall"];
	if(aSubStringRange.length != 0){
        NSLog(@"App call found: request cancelled");
		return NO;
	} else {
		
		return YES;
	}
}

-(IBAction) btnCall:(id)sender {
	[webView stringByEvaluatingJavaScriptFromString:@"addItem();"];

}



- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
