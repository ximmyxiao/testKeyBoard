//
//  ViewController.m
//  testKeyBoard
//
//  Created by Piao Piao on 14/12/8.
//  Copyright (c) 2014年 Piao Piao. All rights reserved.
//

#import "ViewController.h"
#import "TPInputComponent.h"
#import "TPQQFaceBoardView.h"

@interface ViewController ()
@property(nonatomic,strong) IBOutlet TPInputComponent* inputComponent;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.inputComponent.bottomConstraint = self.inputBottomConstrain;
    TPQQFaceBoardView* QQFaceView = [TPQQFaceBoardView new];
    [self.view addSubview:QQFaceView];
    
    UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Expression_1"]];
    imageView.center = CGPointMake(160, 200);
    [self.view addSubview:imageView];
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
