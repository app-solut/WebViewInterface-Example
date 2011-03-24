//
//  App_Solut_WebViewInterfaceAppDelegate.h
//  App-Solut WebViewInterface
//
//  Created by thorben on 24.03.11.
//  Copyright 2011 XINFO blog.app-solut.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class App_Solut_WebViewInterfaceViewController;

@interface App_Solut_WebViewInterfaceAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet App_Solut_WebViewInterfaceViewController *viewController;

@end
