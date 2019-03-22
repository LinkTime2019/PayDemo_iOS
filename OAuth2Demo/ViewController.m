//
//  ViewController.m
//  OAuth2Demo
//
//  Created by ethereum on 2019/2/21.
//  Copyright © 2019年 ethereum. All rights reserved.
//

#import "ViewController.h"
#import "PDAuth2VC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)shanDuiAction:(id)sender {
    [self pushToController:@"PDShanDuiVC"];
}

- (IBAction)auth2Action:(id)sender {
    [self pushToController:@"PDAuth2VC"];
}

- (void)pushToController:(NSString *)vcName {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:vcName];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
