//
//  productViewController.m
//  locationSaver
//
//  Created by Tolga Beser on 10/22/16.
//  Copyright © 2016 Tolga Beser. All rights reserved.
//

#import "productViewController.h"
#import "KLCPopup.h"

@interface productViewController ()

@property NSArray *nameArray;
@property NSArray *priceArray;
@property NSArray *imageArray;
@property NSArray *pointArray;
@property NSArray *sizeArray;
@property NSString *barcodeKey;

@end


@implementation productViewController {
    //Initialize variables here
    
    __weak IBOutlet UIImageView *productImage;
    __weak IBOutlet UILabel *productName;
    __weak IBOutlet UILabel *productSize;
    __weak IBOutlet UILabel *productPrice;
    __weak IBOutlet UILabel *productPoints;
    __weak IBOutlet UIImageView *barcodeImage;
}

-(void)viewDidLoad {
    self.nameArray = [[NSArray alloc] initWithObjects:@"Simply Beverages Calcium & Vitamin D Pulp Free Orange Juice", @"Tabasco ® Brand Original Flavor Hot Sauce", @"Hershey Chocolate Syrup", @"La Croix Lime Sparkling Water",@"King's Hawaiian Sweet Rolls", nil];
    self.priceArray = [[NSArray alloc] initWithObjects:@"$5.99",@"$1.89", @"$4.59", @"$3.99", @"$4.49", nil];
    self.pointArray = [[NSArray alloc] initWithObjects:@"1.5 times points", @"2 times points", @"1.2 times points", @"1.4 times points", @"3 times points", nil];
    self.sizeArray = [[NSArray alloc] initWithObjects:@"89 fl oz", @"2 fl oz", @"48 fl oz", @"8 x 12 fl oz", @"2 x 16 oz", nil];
    self.imageArray = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"orangejuice"],[UIImage imageNamed:@"tabasco"],[UIImage imageNamed:@"hershey"],[UIImage imageNamed:@"lacroix"],[UIImage imageNamed:@"king"], nil];

    
//    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
//                                   initWithTitle:@"Back"
//                                   style:UIBarButtonItemStyleBordered
//                                   target:self
//                                   action:@selector(backBtnClicked:)];
//    item.leftBarButtonItem = backButton;
    
    
    [self setUpInfo];
}

-(void)setUpInfo {
    NSNumber *productNum = [[NSUserDefaults standardUserDefaults] objectForKey:@"productNumber"];
    int reformatedNum = [productNum intValue];
    productImage.image = self.imageArray[reformatedNum];
    productName.text = self.nameArray[reformatedNum];
    productPoints.text = self.pointArray[reformatedNum];
    productPrice.text = self.priceArray[reformatedNum];
    productSize.text = self.sizeArray[reformatedNum];
    barcodeImage.image = [self getImageFromUrl:@"http://www.scandit.com/wp-content/themes/bridge-child/wbq_barcode_gen.php?symbology=qr&value=H3JKQG7LBL98&size=100&ec=L"];
    
}
-(void)backBtnClicked:(id)sender {
    //Go back to the offers window
    NSLog(@"back button pressed");
    [self performSegueWithIdentifier:@"toOfferFromProduct" sender:@"self"];

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
