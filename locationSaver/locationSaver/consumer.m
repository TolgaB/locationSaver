//
//  consumer.m
//  locationSaver
//
//  Created by Tolga Beser on 10/22/16.
//  Copyright © 2016 Tolga Beser. All rights reserved.
//

#import "consumer.h"

@interface consumer ()

@end

@implementation consumer

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    NSString *myString = [[NSString alloc] initWithData:_connectionData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",myString);
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end