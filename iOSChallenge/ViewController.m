//
//  ViewController.m
//  iOSChallenge
//
//  Created by Alejandro Tami on 4/11/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import "ViewController.h"
#import "CircledButton.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    //Makes everything completely transparent
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    
    UIBarButtonItem *search = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"MON_searchIcon.png" ]
                                                              style:UIBarButtonItemStylePlain
                                                             target:self
                                                             action:@selector(onButtonPressed)];
    
    UIBarButtonItem *compass = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"MON_compassIcon.png" ]
                                                              style:UIBarButtonItemStylePlain
                                                             target:self
                                                             action:@selector(onButtonPressed)];
    UIBarButtonItem *calendar = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"MON_calendarIcon.png" ]
                                                              style:UIBarButtonItemStylePlain
                                                             target:self
                                                             action:@selector(onButtonPressed)];
    UIBarButtonItem *menu = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"MON_menuIcon.png" ]
                                                              style:UIBarButtonItemStylePlain
                                                             target:self
                                                             action:@selector(onButtonPressed)];
    
    
   
    self.navigationItem.leftBarButtonItems = @[search, calendar, compass];
    self.navigationItem.rightBarButtonItems = @[menu];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)onTouch:(id)sender {
    [UIView animateWithDuration:2 animations:^{
        
        [(CircledButton*)sender setAlpha:0.5];

        [(CircledButton*)sender setAlpha:1];
        
        [(CircledButton*)sender updateTitle];
    }];
    
}

- (void) onButtonPressed
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Button tapped!"
                                                    message:@"Did you just tapped on a useless button?"
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
