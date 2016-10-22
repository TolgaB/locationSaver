//
//  ViewController.m
//  locationSaver
//
//  Created by Tolga Beser on 10/22/16.
//  Copyright © 2016 Tolga Beser. All rights reserved.
//

#import "ViewController.h"
#import <SIOSocket/SIOSocket.h>


@interface ViewController ()

@property SIOSocket *socket;

@property BOOL socketIsConnected;

@end

@implementation ViewController {
    
    __weak IBOutlet UIButton *consumerButton;
    __weak IBOutlet UIButton *merchantButton;
    
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [SIOSocket socketWithHost: @"http://10.101.0.230:4200" response: ^(SIOSocket *socket)
     {
         self.socket = socket;
         
         __weak typeof(self) weakSelf = self;
         self.socket.onConnect = ^()
         {
             weakSelf.socketIsConnected = YES;
             
             
         };
         
         [self.socket on:@"join" callback: ^(SIOParameterArray *args)
          {
              NSLog(@"Connected to server");
          }];
         
         
     }];
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)merchantButtonPressed:(id)sender {
    NSLog(@"merchant button pressed");
}

- (IBAction)consumerButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"goToConsumer" sender:@"self"];
    NSLog(@"consumer button pressed");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
