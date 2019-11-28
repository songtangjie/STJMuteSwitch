//
//  ViewController.m
//  STJMuteSwitch
//
//  Created by william on 2019/11/26.
//  Copyright © 2019 william. All rights reserved.
//

#import "ViewController.h"
#import "STJMuteSwitch.h"

@interface ViewController ()<STJMuteSwitchDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[STJMuteSwitch sharedInstance] setDelegate:self];
    [[STJMuteSwitch sharedInstance] detectMuteSwitch];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [[STJMuteSwitch sharedInstance] detectMuteSwitch];
}

- (void)isMuted:(BOOL)muted
{
    // The detection results will be inaccurate If the method called too fast and fast.
    if (muted) {
        NSLog(@"-----Muted");
    }
    else {
        NSLog(@"-----Not Muted");
    }
}


@end
