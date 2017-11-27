//
//  ProgramViewController.h
//  RadioAparat
//
//  Created by Dejan Jevtic on 11/10/17.
//  Copyright © 2017 Dejan Jevtic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "BaseViewController.h"

@interface ProgramViewController : BaseViewController
@property (strong, nonatomic) WKWebView *webView;
@property (strong, nonatomic) NSString *productURL;

@end
