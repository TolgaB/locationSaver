//
//  ProfileViewController.m
//  locationSaver
//
//  Created by Kevin Fang on 10/23/16.
//  Copyright © 2016 Tolga Beser. All rights reserved.
//

#import "ProfileViewController.h"
#import <KLCPopup.h>

@interface ProfileViewController (){
    
    __weak IBOutlet UILabel *creditLabel;
}

@end

@implementation ProfileViewController {
    UIButton *applyButton;
    UILabel *firstNameLabel;
    UILabel *secondNameLabel;
    UILabel *creditAmountLabel;
    UITextField *firstNameField;
    UITextField *lastNameField;
    UITextField *creditField;
    UIButton *submitBUtton;
    UIView *contentView;
    UILabel *requestingLabel;
    int requestedAmount;
    __weak IBOutlet UILabel *creditAmount;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    requestedAmount = 0;
    applyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [applyButton addTarget:self
               action:@selector(applyButtonPressed)
     forControlEvents:UIControlEventTouchUpInside];
    applyButton.frame = CGRectMake(self.view.bounds.size.width/2 - 60, 150.0, 160.0, 40.0);
    [applyButton setTitle:@"Apply For Credit" forState:UIControlStateNormal];
    [applyButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:applyButton];
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

- (BOOL) getCredit {
    NSString *path = @"https://syf2020.syfwebservices.com/syf/applyForCredit";
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:path]];
    [request setHTTPMethod:@"POST"];
    
    [request addValue:@"giveitatry" forHTTPHeaderField:@"username"];
    [request addValue:@"Sh0wT!me" forHTTPHeaderField:@"Password"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSString *firstName = @"same";
    NSString *lastName = @"APPROVAL";
    NSString *whateverthelastthingwas = @"10";
    
    NSString *str = [NSString stringWithFormat:@"{\"apply\" : {\"applyRequest\" : {\"authCosApplicantData\" : {\"lastNameapp\" : \"\",\"firstNameapp\" : \"\",\"middleInitialapp\" : \"\",\"suffixapp\" : \"\",\"ssn1\" : \"\",\"birthDateapp\" : \"\",\"driverLicenseNumberapp\" : \"\",\"driverLicenseStateapp\" : \"\",\"signatureIndicatorapp\" : \"\", \"titleapp\" : \"\", \"occupationCodeapp\" : \"\",\"incomeAnnualapp\" : \"\",\"address\" : {\"address2app\" : \"\", \"stateapp\" : \"\",\"address1app\" : \"\",\"cityapp\" : \"\",\"zipCodeapp\" : \"\"},\"membershipNumberapp\" : \"\",\"ssnOverrideapp\" : \"\",\"driverLicenseExpiryDateapp\" : \"\"},\"spouseDetails\" : {\"spFirstName\" : \"\",\"spMiddleName\" : \"\",\"spLastName\" : \"\",\"address\" : {\"address2spd\" : \"\",\"statespd\" : \"\",\"address1spd\" : \"\",\"cityspd\" : \"\",\"zipCodespd\" : \"\"}},\"merchantData\" : {\"clientDepartment\" : \"\",\"iovationRequestType\" : \"application\",\"operator\" : \"ECOM\",\"clientData\" : \"\",\"merchantNumber\" : \"0000000000010032\",\"country\" : \"US\",\"deviceType\" : \"T\",\"originalProductCode\" : \"010\",\"rewardsCode\" : \"\",\"membershipNumber\" : \"\",\"primaryGroup\" : \"000\",\"empAccountCode\" : \"Y\",\"salesPerson\" : \"213006748\",\"clientDataShare\" : \"\",\"sendEmail\" : \"\",\"referalCode\" : \"\",\"register\" : \"REGISTER\",\"clientId\" : \"TJX\",\"referCode\" : \"\",\"comment\" : \"\",\"secondaryGroup\" : \"000\"},\"primaryApplicant\" : {\"tempPassDays\" : \"\",\"longitude\" : \"\",\"cardIndSEDS\" : \"\",\"promoTrack\" : \"\",\"employerState\" : \"\",\"spCode\" : \"\",\"bankCardNumber\" : \"\",\"signatureIndicator\" : \"\",\"customerLoanTerm\" : \"\",\"passportIssuingCountry\" : \"\",\"swipeEdit\" : \"\",\"address\" : {\"address2\" : \"\",\"state\" : \"IL\",\"address1\" : \"21 KING ARTHUR CT\",\"city\" : \"FANTASY ISLAND\",\"zipCode\" : \"60750\"},\"plateCode\" : \"\",\"ssn\" : \"666010080\",\"permanentResidentCard\" : \"\",\"passportNumber\" : \"\",\"cardIndVISA\" : \"\",\"cardIndAMEX\" : \"\",\"mobileStoreDistance\" : \"\",\"bankCardType\" : \"\",\"employerName\" : \"\",\"redemptionAmount\" : \"\",\"timeAtHome\" : \"\",\"latitude\" : \"\",\"applicationCountry\" : \"\",\"homePhone\" : \"1234567891\",\"requestedlineOfCredit\" : %@,\"relativeInfo\" : \"\",\"memberNumber\" : \"\",\"employerPhone\" : \"\",\"imageDocID\" : \"\",\"secLastName\" : \"\",\"optOutFlag\" : \"\",\"eBillEnrollment\" : \"\",\"cardIndMC\" : \"\",\"birthDate\" : \"19700605\",\"promoCode\" : \"\",\"incomeAnnual\" : \"12000000\",\"companyPhone\" : \"\",\"maidenName\" : \"\",\"authCosCode\" : \"\",\"insuranceCode\" : \"\",\"onlineLetter\" : \"\",\"billingLastName\" : \"\",\"caCivicNumber\" : \"\",\"previousAddress\" : {\"address2prvad\" : \"\",\"stateprvad\" : \"\",\"address1prvad\" : \"\",\"cityprvad\" : \"\",\"zipCodeprvad\" : \"\"},\"mobileDeviceType\" : \"\",\"lastName\" : \"APPROVAL\",\"billinngCycle\" : \"\",\"firstName\" : \"JOE\",\"ipAddress\" : \"\",\"purchaseAmount\" : \"\",\"extensionPhoneNumber\" : \"\",\"driverLicenseState\" : \"\",\"sourceCode\" : \"\",\"mothersBirthDate\" : \"\",\"driverLicenseExpiryDate\" : \"\",\"dlSsoId\" : \"\",\"memberSinceDate\" : \"\",\"email\" : \"t@t.com\",\"reissueDate\" : \"\",\"modelIndicator\" : \"\",\"billingFirstName\" : \"\",\"residenceCode\" : \"\",\"timeAtJob\" : \"\",\"vehicleOwn\" : \"\",\"relativePhone\" : \"\",\"creditLineRqd\" : \"\",\"contractNumber\" : \"\",\"passportBirthCity\" : \"\",\"employerZip\" : \"\",\"cardDeptStrInd\" : \"\",\"blackBoxId\" : \"\",\"title\" : \"\",\"bankAccountCode\" : \"\",\"regionalBusinessCode\" : \"\",\"occupationCode\" : \"\",\"employerAddress\" : \"\",\"driverLicenseNumber\" : \"\",\"applicationType\" : \"\",\"accoutInfo\" : \"\",\"mortgageOrRentPay\" : \"\",\"extensionOverride\" : \"\",\"employerCity\" : \"\",\"middleName\" : \"\",\"suffix\" : \"\",\"ssnOverride\" : \"\",\"currentEmployer\" : \"\",\"relativeCode\" : \"\",\"routingNumber\" : \"\",\"cellPhone\" : \"\",\"frnLangIndicator\" : \"E\",\"checkingAccountNumber\" : \"\",\"memberType\" : \"\"}}}}", whateverthelastthingwas];

    NSData *data = [str dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];

    [request setHTTPBody:data];

    NSURLResponse *response = nil;
    NSError *error = nil;

    NSData *connectionData = [self sendSynchronousRequest:request returningResponse:&response error:&error];

    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:connectionData options:kNilOptions error:&error];
    
    NSDictionary *items = [json valueForKeyPath:@"applyResponse"];
    NSDictionary *same = [items valueForKeyPath:@"applyResponse"];
    NSString *same2 = [same valueForKey:@"responseText"];
    if([same2 isEqualToString: @"0010 APPROVED"]){
        UILabel *approveLabel = [[UILabel alloc] initWithFrame:CGRectMake((contentView.bounds.size.width/2)-50, 80, 250, 100)];
        [approveLabel setFont:[UIFont fontWithName:@"San Francisco" size:100]];
        [approveLabel setText:@"APPROVED"];
        [contentView addSubview:approveLabel];
        [requestingLabel removeFromSuperview];
        int added = 80 + requestedAmount;
        creditAmount.text = [NSString stringWithFormat:@"$%i", added];
        
        return true;
    }
    else{
        return false;
    }
    
////    NSInteger *credit = 0;
//    
////    for(int i = 0; i< items.count; i++){
////                NSDictionary *sketch = [items objectAtIndex:i];
////                NSLog(@"credits is %d", (int)credit);
////                NSLog(@"certificate dollar is %d", (NSInteger)[[sketch objectForKey:@"certificate_dollar_amount"] integerValue]);
////                credit += (NSInteger)[[sketch objectForKey:@"certificate_dollar_amount"] integerValue];
////                NSLog(@"final credit is %d", credit);
////    }
//
//    
//    NSString *myString = [[NSString alloc] initWithData:connectionData encoding:NSUTF8StringEncoding];
//
//    NSLog(@"%@",myString);
//
//    return true;
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

-(void)applyButtonPressed {
    NSLog(@"applied button pressed");
   contentView = [[UIView alloc] init];
    contentView.layer.cornerRadius = 5;
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.frame = CGRectMake(0.0, 0.0, 300.0, 350.0);
    
    firstNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(contentView.frame.size.width - 250, 30, 200, 30.0)];
    firstNameLabel.text = @"First Name:";
    
    secondNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(contentView.frame.size.width-250, 110, 200, 30)];
    secondNameLabel.text = @"Last Name:";
    
    creditAmountLabel = [[UILabel alloc] initWithFrame:CGRectMake(contentView.frame.size.width-250, 190, 200, 30)];
    creditAmountLabel.text = @"Credit Amount:";
    
    firstNameField = [[UITextField alloc] initWithFrame:CGRectMake(contentView.frame.size.width-150, 30, 100, 30)];
    [firstNameField setBackgroundColor:[UIColor grayColor]];
    
    lastNameField = [[UITextField alloc] initWithFrame:CGRectMake(contentView.frame.size.width-150, 110, 100, 30)];
    [lastNameField setBackgroundColor:[UIColor grayColor]];
    
    creditField = [[UITextField alloc] initWithFrame:CGRectMake(contentView.frame.size.width-125, 190, 75, 30)];
    [creditField setKeyboardType:UIKeyboardTypePhonePad];
    [creditField setBackgroundColor:[UIColor grayColor]];
    
    submitBUtton = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitBUtton addTarget:self
                    action:@selector(requestButtonPressed)
          forControlEvents:UIControlEventTouchUpInside];
    submitBUtton.frame = CGRectMake(self.view.bounds.size.width/4-30, 260.0, 160.0, 40.0);
    [submitBUtton setTitle:@"Submit Request" forState:UIControlStateNormal];
    [submitBUtton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    

    [contentView addSubview:submitBUtton];
    [contentView addSubview:creditAmountLabel];
    [contentView addSubview:creditField];
    [contentView addSubview:lastNameField];
    [contentView addSubview:firstNameField];
    [contentView addSubview:firstNameLabel];
    [contentView addSubview:secondNameLabel];
    
    KLCPopup* popup = [KLCPopup popupWithContentView:contentView];
    [popup show];

    //[self getCredit];
}

-(void)requestButtonPressed {
   
        contentView.frame = CGRectMake(0.0, 0.0, 300.0, 250.0);
        requestingLabel = [[UILabel alloc] initWithFrame:CGRectMake((contentView.bounds.size.width/2)-50, 80, 250, 100)];
        [requestingLabel setText:@"Requesting"];
        [requestingLabel setTextColor:[UIColor blackColor]];
        [submitBUtton removeFromSuperview];
        [firstNameLabel removeFromSuperview];
        [secondNameLabel removeFromSuperview];
        [creditAmountLabel removeFromSuperview];
        [firstNameField removeFromSuperview];
        [lastNameField removeFromSuperview];
        requestedAmount = [creditField.text intValue];
        [creditField removeFromSuperview];
        [contentView addSubview:requestingLabel];
         [self getCredit];
    
    
   
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
