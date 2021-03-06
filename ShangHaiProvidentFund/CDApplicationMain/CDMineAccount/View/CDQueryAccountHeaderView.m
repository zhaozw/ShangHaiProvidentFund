//
//  CDQueryAccountHeaderView.m
//  ShangHaiProvidentFund
//
//  Created by cdd on 16/7/4.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDQueryAccountHeaderView.h"
#import "CDAccountInfoItem.h"

static const CGFloat leftRightMargin=15;
static const CGFloat imgWidth=60;

@interface CDQueryAccountHeaderView ()

@property (nonatomic, strong) UIImageView *imgPortrait;
@property (nonatomic, strong) UILabel *lbName;
@property (nonatomic, strong) UILabel *lbState;
@property (nonatomic, strong) UILabel *lbBalance;

@end

@implementation CDQueryAccountHeaderView

- (instancetype)init{
    self =[super init];
    if (self) {
        [self addSubview:self.imgPortrait];
        [self addSubview:self.lbName];
        [self addSubview:self.lbState];
        [self addSubview:self.lbBalance];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewTapped)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

#pragma mark - lazy
- (UIImageView *)imgPortrait{
    if (_imgPortrait==nil) {
        _imgPortrait=[[UIImageView alloc]init];
        NSString *imgName=[NSString stringWithFormat:@"defualtportrait%d",arc4random_uniform(6)];
        _imgPortrait.image=[UIImage imageNamed:imgName];
    }
    return _imgPortrait;
}

- (UILabel *)lbName{
    if (_lbName==nil) {
        _lbName=[[UILabel alloc]init];
        _lbName.font=[UIFont systemFontOfSize:15];
        _lbName.textColor=[UIColor whiteColor];
        _lbName.textAlignment=NSTextAlignmentCenter;
    }
    return _lbName;
}

- (UILabel *)lbState{
    if (_lbState==nil) {
        _lbState=[[UILabel alloc]init];
        _lbState.font=[UIFont systemFontOfSize:13];
        _lbState.textColor=[UIColor whiteColor];
        _lbState.textAlignment=NSTextAlignmentCenter;
    }
    return _lbState;
}

- (UILabel *)lbBalance{
    if (_lbBalance==nil) {
        _lbBalance=[[UILabel alloc]init];
        _lbBalance.font=[UIFont systemFontOfSize:13];
        _lbBalance.textColor=[UIColor whiteColor];
        _lbBalance.textAlignment=NSTextAlignmentCenter;
    }
    return _lbBalance;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imgPortrait.frame=CGRectMake(0, 0, imgWidth, imgWidth);
    self.imgPortrait.center=CGPointMake(self.width*0.5, self.height*0.5-20);
    self.lbName.frame=CGRectMake(leftRightMargin, self.imgPortrait.bottom+10, self.width-leftRightMargin*2, 20);
    self.lbState.frame=CGRectMake(self.lbName.left, self.lbName.bottom, self.lbName.width, 15);
    self.lbBalance.frame=CGRectMake(self.lbState.left, self.lbState.bottom, self.lbState.width, 15);
}

#pragma mark - public
- (void)setupViewItem:(CDAccountInfoItem *)item isLogined:(BOOL)islogined{
    if (islogined) {
        self.lbBalance.hidden=self.lbState.hidden=NO;
        self.lbName.text=item.name ? : @"--";
        self.lbBalance.text=[NSString stringWithFormat:@"余额：%@",item.surplus_def];
        self.lbState.text=[NSString stringWithFormat:@"账户状态：%@",item.state];
    }else{
        self.lbName.text=@"待君登录";
        self.lbBalance.hidden=self.lbState.hidden=YES;
    }
}

#pragma mark - private
- (void)viewTapped{
    if (self.viewTappedBlock) {
        self.viewTappedBlock();
    }
}

@end
