//
//  CPCubeAlertView.h
//  CPCubeKit
//
//  Created by coinplug on 2018. 5. 9..
//  Copyright © 2018년 coinplug. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JSAlertViewDelegate;

@interface JSAlertView : UIView <UITableViewDelegate, UITableViewDataSource> {
    
}
@property (nonatomic, assign) CGFloat originHeight;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIView *dialogView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *buttons;
@property (nonatomic, strong) NSArray *messages;
@property (copy) void (^onButtonAction)(JSAlertView *alertView, NSInteger index);
@property (nonatomic, assign) id <JSAlertViewDelegate> delegate;

- (instancetype)initTitleWithMessages:(NSString *)title message:(NSArray *)messages buttons:(NSArray *)buttons;

- (void)show;
- (void)close;

@end

@protocol JSAlertViewDelegate <NSObject>
@optional
- (void)didSelectButtonIndex:(JSAlertView *)alert index:(NSInteger)index;

@end
