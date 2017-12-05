//
//  HeadTableViewCell.m
//  TV_TV
//
//  Created by liyy on 2017/10/31.
//  Copyright © 2017年 ccdc. All rights reserved.
//

#import "HeadTableViewCell.h"

@implementation HeadTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor yellowColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // 根据具体需求，画不同的UI
        
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

@end
