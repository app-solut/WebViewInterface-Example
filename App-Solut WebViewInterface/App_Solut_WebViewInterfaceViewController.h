//
//  App_Solut_WebViewInterfaceViewController.h
//  App-Solut WebViewInterface
//
//  Created by thorben on 24.03.11.
//  Copyright 2011 XINFO blog.app-solut.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface App_Solut_WebViewInterfaceViewController : UIViewController {
    IBOutlet UIWebView *webView;
    IBOutlet UILabel *label;
    IBOutlet UIButton *call;
    
}

@property(retain, nonatomic) UIWebView *webView;
@property(retain, nonatomic) UILabel *label;
@property(retain, nonatomic) UIButton *call;

@end
