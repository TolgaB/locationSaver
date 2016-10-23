//
//  consumer.m
//  locationSaver
//
//  Created by Tolga Beser on 10/22/16.
//  Copyright © 2016 Tolga Beser. All rights reserved.
//

#import "consumer.h"
#import <QuartzCore/QuartzCore.h>

@interface consumer ()
@property NSArray *names;
@property NSArray *costs;
@property NSArray *size;
@property NSArray *discounts;
@property NSArray *images;
@end

@implementation consumer {
    
    __weak IBOutlet UIImageView *productImageView;
    __weak IBOutlet UILabel *productPrice;
    __weak IBOutlet UILabel *productPoints;
    __weak IBOutlet UILabel *productName;
    __weak IBOutlet UILabel *pointTillLabel;
    __weak IBOutlet UIImageView *imageView;
    int currentProduct;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    
    UISwipeGestureRecognizer *rightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipeHandle:)];
    rightRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [rightRecognizer setNumberOfTouchesRequired:1];
    
    //add the your gestureRecognizer , where to detect the touch..
    [self.view addGestureRecognizer:rightRecognizer];
    
    UISwipeGestureRecognizer *leftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeHandle:)];
    leftRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [leftRecognizer setNumberOfTouchesRequired:1];
    
    [self.view addGestureRecognizer:leftRecognizer];
    
    
    currentProduct = 0;
    
    imageView.layer.cornerRadius = 10;
    imageView.layer.borderWidth = 1;
    imageView.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.names = [[NSArray alloc] initWithObjects:@"Simply Beverages Calcium & Vitamin D Pulp Free Orange Juice", @"Tabasco ® Brand Original Flavor Hot Sauce", @"Hershey Chocolate Syrup", @"La Croix Lime Sparkling Water",@"King's Hawaiian Sweet Rolls", nil];
    self.costs = [[NSArray alloc] initWithObjects:@"$5.99",@"$1.89", @"$4.59", @"$3.99", @"$4.49", nil];
    self.discounts = [[NSArray alloc] initWithObjects:@"1.5 times points", @"2 times points", @"1.2 times points", @"1.4 times points", @"3 times points", nil];
    self.size = [[NSArray alloc] initWithObjects:@"89 fl oz", @"2 fl oz", @"48 fl oz", @"8 x 12 fl oz", @"2 x 16 oz", nil];
    self.images = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"orange.png"],[UIImage imageNamed:@"tabasco.png"],[UIImage imageNamed:@"hershey.png"],[UIImage imageNamed:@"lacroix.jpg"],[UIImage imageNamed:@"king.jpg"], nil];
    [self getProbability];
}


- (NSString *) getProbability {
    NSString *path2 = @"https://syf2020.syfwebservices.com/syf/nextMostLikelyPurchase";
    
    NSMutableURLRequest* _request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:path2]];
    [_request setHTTPMethod:@"POST"];
    
    [_request addValue:@"giveitatry" forHTTPHeaderField:@"username"];
    [_request addValue:@"Sh0wT!me" forHTTPHeaderField:@"Password"];
    [_request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSString *authStr = @"{\"accountNum\": \"100111\"}";
    
    NSData *postData = [authStr dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSLog(@"%@", authStr);
    
    [_request setHTTPBody:postData];
    
    NSURLResponse *response = nil;
    NSError *error = nil;
    
    NSData *_connectionData = [self sendSynchronousRequest:_request returningResponse:&response error:&error];
    NSDictionary *retrievedData = [NSJSONSerialization JSONObjectWithData:_connectionData
                                                                  options:0
                                                                    error:NULL];
    NSString *myString = [[NSString alloc] initWithData:_connectionData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",myString);
    
    NSData *data = [myString dataUsingEncoding:NSUTF8StringEncoding];
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];


    NSLog(@"%@",[self getRewards]);
    
    return myString;
}

- (NSString *) getRewards {
    NSString *path = @"https://syf2020.syfwebservices.com/syf/getRewards";
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:path]];
    [request setHTTPMethod:@"POST"];
    
    [request addValue:@"giveitatry" forHTTPHeaderField:@"username"];
    [request addValue:@"Sh0wT!me" forHTTPHeaderField:@"Password"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSString *str = @"{\"Header\": { \"trans_id\": \"demorewards\" },\"gps_syf_profileid\": \"6ff47aed18048b7708dd84b47152ee75db535e0eaa90b46fc3b7dc20745780dd\"}";
    
    NSData *postData2 = [str dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    [request setHTTPBody:postData2];
    
    NSURLResponse *response2 = nil;
    NSError *error2 = nil;
    
    NSData *connectionData = [self sendSynchronousRequest:request returningResponse:&response2 error:&error2];
    NSDictionary *retrievedData = [NSJSONSerialization JSONObjectWithData:connectionData
                                                                  options:0
                                                                    error:NULL];
    pointTillLabel.text = [NSString stringWithFormat: @"%@ Point To Reward",[retrievedData objectForKeyedSubscript:@"points_to_next_certificate"]];
    NSString *printthing = [[NSString alloc] initWithData:connectionData encoding:NSUTF8StringEncoding];
    NSLog(@"printthing2 %@",printthing);
    
    return printthing;
}


- (NSData *)sendSynchronousRequest:(NSURLRequest *)request returningResponse:(NSURLResponse **)response error:(NSError **)error
{
    
    NSError __block *err = NULL;
    NSData __block *data;
    BOOL __block reqProcessed = false;
    NSURLResponse __block *resp;
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable _data, NSURLResponse * _Nullable _response, NSError * _Nullable _error) {
        resp = _response;
        err = _error;
        data = _data;
        reqProcessed = true;
    }] resume];
    
    while (!reqProcessed) {
        [NSThread sleepForTimeInterval:0];
    }
    
    *response = resp;
    *error = err;
    return data;
}
- (void)rightSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer
    {
    if (currentProduct > 0) {
    currentProduct = currentProduct -1;
    }
    productName.text = self.names[currentProduct];
    productPoints.text = self.size[currentProduct];
    productPrice.text = self.costs[currentProduct];
    productImageView.image = self.images[currentProduct];
}
- (void)leftSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer
{
    if (currentProduct != 4) {
        currentProduct = currentProduct + 1;
    }
    productName.text = self.names[currentProduct];
    productPoints.text = self.size[currentProduct];
    productPrice.text = self.costs[currentProduct];
    productImageView.image = self.images[currentProduct];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end