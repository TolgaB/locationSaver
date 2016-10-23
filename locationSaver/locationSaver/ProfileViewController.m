//
//  ProfileViewController.m
//  locationSaver
//
//  Created by Kevin Fang on 10/23/16.
//  Copyright © 2016 Tolga Beser. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController (){
    
    __weak IBOutlet UILabel *creditLabel;
}

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    creditLabel.text = [NSString stringWithFormat:@"$%d",(int)[self getRewards]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger *) getRewards {
    NSString *path = @"https://syf2020.syfwebservices.com/syf/getRewards";
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:path]];
    [request setHTTPMethod:@"POST"];
    
    [request addValue:@"giveitatry" forHTTPHeaderField:@"username"];
    [request addValue:@"Sh0wT!me" forHTTPHeaderField:@"Password"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSString *str = @"{\"Header\": { \"trans_id\": \"demorewards\" },\"gps_syf_profileid\": \"6ff47aed18048b7708dd84b47152ee75db535e0eaa90b46fc3b7dc20745780dd\"}";
    
    NSData *postData2 = [str dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    [request setHTTPBody:postData2];
    
    NSURLResponse *response = nil;
    NSError *error = nil;
    
    NSData *connectionData = [self sendSynchronousRequest:request returningResponse:&response error:&error];

//    NSDictionary *retrievedData = [NSJSONSerialization JSONObjectWithData:connectionData
//                                                                  options:0
//                                                                    error:NULL];


    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:connectionData options:kNilOptions error:&error];
    
    NSArray *items = [json valueForKeyPath:@"redeemable_certificates"];
    
    NSInteger *credit = 0;
    
    for(int i = 0; i< items.count; i++){
//        NSDictionary *sketch = [items objectAtIndex:i];
//        NSLog(@"credits is %d", (int)credit);
//        NSLog(@"certificate dollar is %d", (NSInteger)[[sketch objectForKey:@"certificate_dollar_amount"] integerValue]);
//        credit += (NSInteger)[[sketch objectForKey:@"certificate_dollar_amount"] integerValue];
//        NSLog(@"final credit is %d", credit);
    }
    credit = items.count * 10;
    return credit;
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
