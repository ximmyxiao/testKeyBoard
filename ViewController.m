//
//  ViewController.m
//  testKeyBoard
//
//  Created by Piao Piao on 14/12/8.
//  Copyright (c) 2014年 Piao Piao. All rights reserved.
//

#import "ViewController.h"
#import "TPInputComponent.h"
@interface ViewController ()
@property(nonatomic,strong) IBOutlet TPInputComponent* inputComponent;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.inputComponent.bottomConstraint = self.inputBottomConstrain;
}

- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"bottomLayout frame to %f",[self.bottomLayoutGuide length]);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"bottomLayout frame to %f",[self.bottomLayoutGuide length]);

    [self.view endEditing:NO];
}
@end
