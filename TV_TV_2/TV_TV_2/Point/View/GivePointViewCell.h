//
//  GivePointViewCell.h
//  BTG
//
//  Created by liyy on 2017/11/17.
//  Copyright © 2017年 CCDC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GivePointViewCell : UITableViewCell<UITextViewDelegate>

@property (nonatomic, retain) UIButton *randomBtn;
@property (nonatomic, retain) UIButton *averageBtn;
@property (nonatomic, retain) UITextField *pointTF;
@property (nonatomic, retain) UITextField *countTF;

@property (nonatomic, retain) UILabel *tintLabel;
@property (nonatomic, retain) UITextView *textView;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
