//
//  AuthenticationServicesViewController.m
//  CYSuperDemo
//
//  Created by cyrill on 2018/12/28.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "AuthenticationServicesViewController.h"
#import <AuthenticationServices/AuthenticationServices.h>

@interface AuthenticationServicesViewController ()

@end

@implementation AuthenticationServicesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UILabel *userLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 100, 200, 20)];
    userLabel.font = [UIFont systemFontOfSize:14.0f];
    userLabel.textColor = [UIColor blackColor];
    userLabel.text = @"账号";
    [self.view addSubview:userLabel];
    // 用户名
    UITextField *userField = [[UITextField alloc] initWithFrame:CGRectMake(30, 130, 200, 30)];
    userField.layer.borderColor= [UIColor grayColor].CGColor;
    userField.layer.borderWidth= 1.0f;
    userField.placeholder = @"";
    userField.font = [UIFont systemFontOfSize:14.0f];
    userField.textColor = [UIColor blackColor];
    userField.keyboardType = UIKeyboardTypeAlphabet;
    userField.returnKeyType = UIReturnKeyDone;
    userField.textContentType = UITextContentTypeUsername;
//    userField.delegate = self;
    //    [userField addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:userField];
    
    UILabel *codeLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 170, 200, 20)];
    codeLabel.font = [UIFont systemFontOfSize:14.0f];
    codeLabel.textColor = [UIColor blackColor];
    codeLabel.text = @"密码";
    [self.view addSubview:codeLabel];
    // 密码
    UITextField *codeField = [[UITextField alloc] initWithFrame:CGRectMake(30, 200, 200, 30)];
    codeField.layer.borderColor= [UIColor grayColor].CGColor;
    codeField.layer.borderWidth= 1.0f;
    codeField.placeholder = @"";
    codeField.font = [UIFont systemFontOfSize:14.0f];
    codeField.textColor = [UIColor blackColor];
    codeField.keyboardType = UIKeyboardTypeAlphabet;
    codeField.returnKeyType = UIReturnKeyDone;
    codeField.textContentType = UITextContentTypePassword;
    codeField.secureTextEntry = YES;
//    codeField.delegate = self;
    //    [userField addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:codeField];
    
    
    UIButton *login = [[UIButton alloc] initWithFrame:CGRectMake(30, 250, 50, 30)];
    [login setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [login.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [login setTitle:@"登录" forState:UIControlStateNormal];
    login.layer.borderColor= [UIColor blueColor].CGColor;
    login.layer.borderWidth= 1.0f;
    [self.view addSubview:login];
    
    
    NSURL *url = [NSURL URLWithString:@"https://cyrill.win"];
    ASWebAuthenticationSession *session = [[ASWebAuthenticationSession alloc] initWithURL:url callbackURLScheme:@"superdemo" completionHandler:^(NSURL * _Nullable callbackURL, NSError * _Nullable error) {
        NSLog(@"dd");
    }];
    
    [session start];
    
    return;
    
    ASCredentialIdentityStore *store = [ASCredentialIdentityStore sharedStore];
    
    [store getCredentialIdentityStoreStateWithCompletion:^(ASCredentialIdentityStoreState * _Nonnull state) {
        
        NSLog(@"aa");
        
    }];
    ASPasswordCredential *credential = [ASPasswordCredential credentialWithUser:@"test" password:@"1234"];
    
    
    
    /*
     @constant ASCredentialServiceIdentifierTypeDomain The service identifier represents a domain name that conforms to RFC 1035.
     @constant ASCredentialServiceIdentifierTypeURL The service identifier represents a URL that conforms to RFC 1738.
     */
    ASCredentialServiceIdentifier *sId1 = [[ASCredentialServiceIdentifier alloc] initWithIdentifier:@"Test_ASCredentialServiceIdentifier" type:ASCredentialServiceIdentifierTypeURL];
    
//    ASPasswordCredentialIdentity *id1 = [[ASPasswordCredentialIdentity alloc] initWithServiceIdentifier:<#(nonnull ASCredentialServiceIdentifier *)#> user:<#(nonnull NSString *)#> recordIdentifier:<#(nullable NSString *)#>]
    
    ASPasswordCredentialIdentity *id2 = [ASPasswordCredentialIdentity identityWithServiceIdentifier:sId1 user:@"" recordIdentifier:@"recordIdentifier"];
    
    NSArray *arr = @[id2];
    
    
    
    [store saveCredentialIdentities:arr completion:^(BOOL success, NSError * _Nullable error) {

    }];
//
//    [store removeCredentialIdentities:<#(nonnull NSArray<ASPasswordCredentialIdentity *> *)#> completion:^(BOOL success, NSError * _Nullable error) {
//
//    }];
//
//    [store removeAllCredentialIdentitiesWithCompletion:^(BOOL success, NSError * _Nullable error) {
//
//    }];
//
//    [store replaceCredentialIdentitiesWithIdentities:<#(nonnull NSArray<ASPasswordCredentialIdentity *> *)#> completion:^(BOOL success, NSError * _Nullable error) {
//
//    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
//    ASCredentialProviderViewController *vc = [[ASCredentialProviderViewController alloc] init];
//
}

@end
