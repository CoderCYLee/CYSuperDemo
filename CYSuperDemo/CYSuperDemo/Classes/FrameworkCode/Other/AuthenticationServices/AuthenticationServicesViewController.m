//
//  AuthenticationServicesViewController.m
//  CYSuperDemo
//
//  Created by cyrill on 2018/12/28.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "AuthenticationServicesViewController.h"
#import <AuthenticationServices/AuthenticationServices.h>

API_AVAILABLE(ios(12.0))
@interface AuthenticationServicesViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UITextField *newpasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;

@property (nonatomic, strong) ASWebAuthenticationSession *session;

@end

@implementation AuthenticationServicesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _userTextField.layer.borderColor= [UIColor grayColor].CGColor;
    _userTextField.layer.borderWidth= 1.0f;
    _userTextField.placeholder = @"";
    _userTextField.font = [UIFont systemFontOfSize:14.0f];
    _userTextField.textColor = [UIColor blackColor];
    _userTextField.keyboardType = UIKeyboardTypeAlphabet;
    _userTextField.returnKeyType = UIReturnKeyDone;
    if (@available(iOS 11.0, *)) {
        _userTextField.textContentType = UITextContentTypeUsername;
    } else {
        // Fallback on earlier versions
    }
//    _userTextField.delegate = self;
    //    [_userTextField addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
   

    _passwordTextField.layer.borderColor= [UIColor grayColor].CGColor;
    _passwordTextField.layer.borderWidth= 1.0f;
    _passwordTextField.placeholder = @"";
    _passwordTextField.font = [UIFont systemFontOfSize:14.0f];
    _passwordTextField.textColor = [UIColor blackColor];
    _passwordTextField.keyboardType = UIKeyboardTypeAlphabet;
    _passwordTextField.returnKeyType = UIReturnKeyDone;
    if (@available(iOS 11.0, *)) {
        _passwordTextField.textContentType = UITextContentTypePassword;
    } else {
        
    }
    _passwordTextField.secureTextEntry = YES;
//    _codeField.delegate = self;
    //    [userField addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
    
    
    if (@available(iOS 12.0, *)) {
        // 强密码提示
//        _newpasswordTextField.textContentType = UITextContentTypeNewPassword;
    } else {
        
    }
    
    if (@available(iOS 12.0, *)) {
        // 短信验证码
        _codeTextField.textContentType = UITextContentTypeOneTimeCode;
    } else {
        
    }
    
    
//    ASCredentialIdentityStore *store = [ASCredentialIdentityStore sharedStore];
//
//    [store getCredentialIdentityStoreStateWithCompletion:^(ASCredentialIdentityStoreState * _Nonnull state) {
//
//        NSLog(@"aa");
//
//    }];
//
//    ASPasswordCredential *credential = [ASPasswordCredential credentialWithUser:@"test" password:@"1234"];
//
//
//
//    /*
//     @constant ASCredentialServiceIdentifierTypeDomain The service identifier represents a domain name that conforms to RFC 1035.
//     @constant ASCredentialServiceIdentifierTypeURL The service identifier represents a URL that conforms to RFC 1738.
//     */
//    ASCredentialServiceIdentifier *sId1 = [[ASCredentialServiceIdentifier alloc] initWithIdentifier:@"Test_ASCredentialServiceIdentifier" type:ASCredentialServiceIdentifierTypeURL];
//
////    ASPasswordCredentialIdentity *id1 = [[ASPasswordCredentialIdentity alloc] initWithServiceIdentifier:<#(nonnull ASCredentialServiceIdentifier *)#> user:<#(nonnull NSString *)#> recordIdentifier:<#(nullable NSString *)#>]
//
//    ASPasswordCredentialIdentity *id2 = [ASPasswordCredentialIdentity identityWithServiceIdentifier:sId1 user:@"" recordIdentifier:@"recordIdentifier"];
//
//    NSArray *arr = @[id2];
//
//
//
//    [store saveCredentialIdentities:arr completion:^(BOOL success, NSError * _Nullable error) {
//
//    }];
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

- (IBAction)login {
    if (@available(iOS 12.0, *)) {
        NSURL *url = [NSURL URLWithString:@"https://github.com/login/oauth/authorize?client_id=93d44edf898098d26435&scope=user+repo+notifications"];
        // 这里要强引用，不然会消失
        _session = [[ASWebAuthenticationSession alloc] initWithURL:url callbackURLScheme:@"superdemo://" completionHandler:^(NSURL * _Nullable callbackURL, NSError * _Nullable error) {
            if (error) {
                if (error.code == ASWebAuthenticationSessionErrorCodeCanceledLogin) {
                    
                } else {
                    
                }
                
                return;
            }
            
            
            NSURLComponents *components = [NSURLComponents componentsWithURL:callbackURL resolvingAgainstBaseURL:NO];
            NSArray<NSURLQueryItem *> *queryItems = [components queryItems];
            
            for (NSURLQueryItem *item in queryItems) {
                if ([item.name isEqualToString:@"code"]) {
                    NSLog(@"code: %@", item.value);
                }
            }
        }];
        
        [_session start];
    } else {
        // Fallback on earlier versions
        ShowMsg(@"iOS 12.0 以上才能使用");
    }
}

- (IBAction)taobao {
    // taobao://m.tb.cn/h.3rX08Px?sm=d73436
    NSString *url = @"taobao://item.taobao.com/item.htm?id=577359137670";
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:url]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        
    } else {
        NSLog(@"本地没有该软件");
    }
}

@end
