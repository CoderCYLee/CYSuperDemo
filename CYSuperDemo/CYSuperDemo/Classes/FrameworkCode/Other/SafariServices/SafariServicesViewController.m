//
//  SafariServicesViewController.m
//  CYSuperDemo
//
//  Created by cyrill on 2018/12/18.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "SafariServicesViewController.h"
#import <SafariServices/SafariServices.h>
#import <Masonry.h>

@interface SafariServicesViewController () <UITableViewDelegate, UITableViewDataSource, SFSafariViewControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titleArr;

@property (nonatomic, strong) SFAuthenticationSession *session;

@end

@implementation SafariServicesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellId"];
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellId" forIndexPath:indexPath];
    
    cell.textLabel.text = self.titleArr[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0: {
            [self safariViewController];
        }
            
            break;
        case 1:
        {
            [self SFAuthenticationSession];
        }
            break;
        case 2:
        {
            [self addToReadingList];
        }
            break;
        default:
            break;
    }
    
}


/*! @abstract Called when the view controller is about to show UIActivityViewController after the user taps the action button.
 @param URL the URL of the web page.
 @param title the title of the web page.
 @result Returns an array of UIActivity instances that will be appended to UIActivityViewController.
 */
//- (NSArray<UIActivity *> *)safariViewController:(SFSafariViewController *)controller activityItemsForURL:(NSURL *)URL title:(nullable NSString *)title {
//
//}

/*! @abstract Allows you to exclude certain UIActivityTypes from the UIActivityViewController presented when the user taps the action button.
 @discussion Called when the view controller is about to show a UIActivityViewController after the user taps the action button.
 @param URL the URL of the current web page.
 @param title the title of the current web page.
 @result Returns an array of any UIActivityType that you want to be excluded from the UIActivityViewController.
 */
//- (NSArray<UIActivityType> *)safariViewController:(SFSafariViewController *)controller excludedActivityTypesForURL:(NSURL *)URL title:(nullable NSString *)title API_AVAILABLE(ios(11.0)) {
//
//}

/*! @abstract Delegate callback called when the user taps the Done button. Upon this call, the view controller is dismissed modally. */
- (void)safariViewControllerDidFinish:(SFSafariViewController *)controller {
    
}

/*! @abstract Invoked when the initial URL load is complete.
 @param didLoadSuccessfully YES if loading completed successfully, NO if loading failed.
 @discussion This method is invoked when SFSafariViewController completes the loading of the URL that you pass
 to its initializer. It is not invoked for any subsequent page loads in the same SFSafariViewController instance.
 */
- (void)safariViewController:(SFSafariViewController *)controller didCompleteInitialLoad:(BOOL)didLoadSuccessfully {
    
}

/*! @abstract Called when the browser is redirected to another URL while loading the initial page.
 @param URL The new URL to which the browser was redirected.
 @discussion This method may be called even after -safariViewController:didCompleteInitialLoad: if
 the web page performs additional redirects without user interaction.
 */
- (void)safariViewController:(SFSafariViewController *)controller initialLoadDidRedirectToURL:(NSURL *)URL API_AVAILABLE(ios(11.0)) {
    
}


- (void)safariViewController {
    if (@available(iOS 9.0, *)) {
        NSURL *url = [NSURL URLWithString:@"http://cyrill.win"];

        SFSafariViewController *vc;
        
        if (@available(iOS 11.0, *)) {
            SFSafariViewControllerConfiguration *configuration = [[SFSafariViewControllerConfiguration alloc] init];
//            configuration.entersReaderIfAvailable = NO;
//            configuration.barCollapsingEnabled = NO;
            vc = [[SFSafariViewController alloc] initWithURL:url configuration:configuration];
        } else {
            vc = [[SFSafariViewController alloc] initWithURL:url entersReaderIfAvailable:YES];
        }
        
        if (@available(iOS 11.0, *)) {
            vc.configuration.entersReaderIfAvailable = NO;
            vc.configuration.barCollapsingEnabled = YES;
            vc.dismissButtonStyle = SFSafariViewControllerDismissButtonStyleDone;
            vc.dismissButtonStyle = SFSafariViewControllerDismissButtonStyleClose;
//            vc.dismissButtonStyle = SFSafariViewControllerDismissButtonStyleCancel;
        }
        if (@available(iOS 10.0, *)) {
            vc.preferredBarTintColor = [UIColor lightGrayColor];
            vc.preferredControlTintColor = [UIColor blackColor];
        }
        
        if (@available(iOS 9.0, *)) {
            
        }
        
        
        vc.delegate = self;
        [self showDetailViewController:vc sender:self];
//        [self presentViewController:vc animated:YES completion:nil];
    } else {
        ShowMsg(@"iOS 9.0 以上才能使用");
    }
}

- (void)SFAuthenticationSession {
    NSURL *url = [NSURL URLWithString:@"https://github.com/login/oauth/authorize?client_id=93d44edf898098d26435&scope=user+repo+notifications"];
    if (@available(iOS 11.0, *)) {
        _session = [[SFAuthenticationSession alloc] initWithURL:url callbackURLScheme:@"superdemo://" completionHandler:^(NSURL * _Nullable callbackURL, NSError * _Nullable error) {
            
        }];
        [_session start];
    } else {
        // Fallback on earlier versions
        ShowMsg(@"iOS 11.0 以上才能使用");
    }
    
}

- (void)addToReadingList {
    NSURL *url = [NSURL URLWithString:@"http://cyrill.win"];
    NSError *err;
    
    SSReadingList *readingList = [SSReadingList defaultReadingList];
    BOOL isSupport = [SSReadingList supportsURL:url];
    if (!isSupport) {
        NSLog(@"不支持");
        return;
    }
    BOOL result = [readingList addReadingListItemWithURL:url title:@"Cyrill blog" previewText:@"My blog." error:&err];
    
    UIAlertView *alert = [[UIAlertView alloc] init];
    [alert addButtonWithTitle:@"OK"];
    
    if (!result) {
        
        alert.title = @"Failed!";
        alert.message = [NSString stringWithFormat:@"Error:%@", err.description];
    }
    else {
        
        alert.title = @"Done!";
        alert.message = @"Added to the Safari Reading List.";
    }
    
    [alert show];
}

- (NSArray *)titleArr
{
    if (!_titleArr) {
        _titleArr = @[@"SafariViewController", @"SFAuthenticationSession", @"AddToReadList"];
    }
    return _titleArr;
}

@end
