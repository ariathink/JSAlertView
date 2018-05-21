//
//  ViewController.m
//  Sample
//
//  Created by han jinsik on 2018. 5. 21..
//  Copyright © 2018년 coinplug. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)okButtonAction:(id)sender {
    JSAlertView *alert = [[JSAlertView alloc] initTitleWithMessages:@"" message:@[@"Test", @"JSAlertView"] buttons:@[@"확인"]];
    
    [alert setOnButtonAction:^(JSAlertView *alertView, NSInteger index) {
        if (index == 0) {
            
        }
        else if (index == 1) {
            
        }
    }];
    
    [alert show];
}

@end
