//
//  CYCustomSearchBar.h
//  CYCustomSearchBar
//
//  Created by Cyrill on 2017/11/10.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CYCustomSearchBarIconAlignment) {
    CYCustomSearchBarIconAlignmentLeft,
    CYCustomSearchBarIconAlignmentCenter
};

NS_ASSUME_NONNULL_BEGIN

@protocol CYCustomSearchBarDelegate;

@interface CYCustomSearchBar : UIView <UITextInputTraits>


@property (nullable, nonatomic, weak) id<CYCustomSearchBarDelegate> delegate;              // weak reference. default is nil
@property (nullable, nonatomic, copy)   NSString               *text;                  // current/starting search text
@property (nullable, nonatomic, strong)  UIColor               *textColor;

@property (nullable, nonatomic, strong)  UIFont               *textFont;

@property (nullable, nonatomic, copy)   NSString               *prompt;                // default is nil
@property(nullable, nonatomic, copy)   NSString               *placeholder;           // default is nil

@property (nonatomic) CYCustomSearchBarIconAlignment iconAlignment;

@property (nullable, nonatomic, strong) UIColor *placeholderColor;

@property (nullable, nonatomic, strong) UIColor *textFieldColor;

/* Allow placement of an input accessory view to the keyboard for the search bar
 */
@property (nullable, nonatomic, readwrite, strong) UIView *inputAccessoryView;
@property (nonatomic, strong) UIView *inputView;

@property (nullable, nonatomic, strong) UIImage *iconImage;
@property (nullable, nonatomic, strong) UIImage *backgroundImage NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;

@property (nullable, nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, getter=isHiddenCancelButton) BOOL hiddenCancelButton;

@property (nonatomic) UITextBorderStyle textBorderStyle;
@property (nonatomic) UIKeyboardType keyboardType;

- (BOOL)isFirstResponder;
- (BOOL)resignFirstResponder;
- (BOOL)becomeFirstResponder;

- (void)setAutoCapitalizationMode:(UITextAutocapitalizationType)type;

@end

@protocol CYCustomSearchBarDelegate <UIBarPositioningDelegate>

@optional

- (BOOL)searchBarShouldBeginEditing:(CYCustomSearchBar *)searchBar;                      // return NO to not become first responder
- (void)searchBarTextDidBeginEditing:(CYCustomSearchBar *)searchBar;                     // called when text starts editing
- (BOOL)searchBarShouldEndEditing:(CYCustomSearchBar *)searchBar;                        // return NO to not resign first responder
- (void)searchBarTextDidEndEditing:(CYCustomSearchBar *)searchBar;                       // called when text ends editing
- (void)searchBar:(CYCustomSearchBar *)searchBar textDidChange:(NSString *)searchText;   // called when text changes (including clear)
- (BOOL)searchBar:(CYCustomSearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text NS_AVAILABLE_IOS(3_0); // called before text changes
- (void)searchBarSearchButtonClicked:(CYCustomSearchBar *)searchBar;                     // called when keyboard search button pressed
- (void)searchBarCancelButtonClicked:(CYCustomSearchBar *)searchBar __TVOS_PROHIBITED;   // called when cancel button pressed

@end

NS_ASSUME_NONNULL_END
