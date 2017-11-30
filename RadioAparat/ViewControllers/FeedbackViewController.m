//
//  FeedbackViewController.m
//  RadioAparat
//
//  Created by Dejan Jevtic on 11/30/17.
//  Copyright © 2017 Dejan Jevtic. All rights reserved.
//

#import "FeedbackViewController.h"

@interface FeedbackViewController ()

@end

@implementation FeedbackViewController
@synthesize textView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIFont *systemFont = [UIFont  systemFontOfSize:20.0f];
    NSDictionary * fontAttributes = [[NSDictionary alloc] initWithObjectsAndKeys:systemFont, NSFontAttributeName, nil];
    
    NSURL *URL1 = [NSURL URLWithString: @"http://www.linkedin.com/in/dejan-jevtic-40bb883b"];
    NSURL *URL2 = [NSURL URLWithString: @"https://twitter.com/radioaparat"];
    NSMutableAttributedString * str = [[NSMutableAttributedString alloc] initWithString:@"Hi, I’m Dejan. I run RadioAparat iOS app with no employees. Feedback is welcome:\n\t•    @RadioAparat on Twitter for quick comments.\n\t•    dejanjevtic87@gmail.com for private feedback.\nI try to read every message, but can’t respond to them all.\n\nThanks for understanding." attributes:fontAttributes];

    
    [str addAttribute: NSLinkAttributeName value:URL1 range: [str.string rangeOfString:@"Dejan"]];
    [str addAttribute: NSLinkAttributeName value:URL2 range: [str.string rangeOfString:@"@RadioAparat"]];
    self.textView.attributedText = str;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
