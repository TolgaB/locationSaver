//
//  barcodeTest.m
//  locationSaver
//
//  Created by Tolga Beser on 10/22/16.
//  Copyright © 2016 Tolga Beser. All rights reserved.
//

#import "barcodeTest.h"

@implementation barcodeTest {
    
}

-(void)viewDidLoad {
   // http://www.scandit.com/wp-content/themes/bridge-child/wbq_barcode_gen.php?symbology=qr&value=H3JKQG7LBL98&size=100&ec=L
    UIImage *image = [self getImageFromUrl:@"http://www.scandit.com/wp-content/themes/bridge-child/wbq_barcode_gen.php?symbology=qr&value=H3JKQG7LBL98&size=100&ec=L"];
    
    
}
-(UIImage *)getImageFromUrl:(NSString *)urlGiven {
    NSURL *url = [NSURL URLWithString:urlGiven];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLResponse* response;
    NSError* error = nil;
    NSData* result = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    UIImage *photo = [UIImage imageWithData:result];
    return photo;
}
@end
