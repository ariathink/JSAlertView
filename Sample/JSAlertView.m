//
//  CPCubeAlertView.m
//  CPCubeKit
//
//  Created by coinplug on 2018. 5. 9..
//  Copyright © 2018년 coinplug. All rights reserved.
//

#import "JSAlertView.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation JSAlertView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initTitleWithMessages:(NSString *)title message:(NSArray *)messages buttons:(NSArray *)buttons {
    self = [super init];
    
    if (self) {
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        
        if ([title length] > 0) {
            self.title = title;
        }
        
        if ([messages count] > 0) {
            self.messages = [NSArray arrayWithArray:messages];
        }
        
        if ([buttons count] > 0) {
            self.buttons = [NSArray arrayWithArray:buttons];
        }
        
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        
        [self initView];
    }
    
    return self;
}


- (void)initView {
    self.dialogView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - (SCREEN_WIDTH - 80))/2, (SCREEN_HEIGHT - 260)/2, SCREEN_WIDTH - 80, 260)];
    
    self.dialogView.layer.cornerRadius = 10;
    self.dialogView.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.dialogView.frame.size.width, self.dialogView.frame.size.height) style:UITableViewStylePlain];
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.tableView setBounces:NO];
    [self.tableView setSeparatorColor:[UIColor clearColor]];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"messageCell"];
    
    if ([self.buttons count] > 0) {
        [self.tableView.tableFooterView setAlpha:1.];
        [self.tableView setTableFooterView:[self footerView]];
    }
    
    [self.dialogView addSubview:self.tableView];
    [self.tableView setEstimatedRowHeight:0];
    [self.tableView setEstimatedSectionFooterHeight:0];
    [self.tableView setEstimatedSectionHeaderHeight:0];
    
    [self.tableView reloadData];
}


- (UIView *)footerView {
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.dialogView.frame.size.width, 60)];
    CGFloat originX = 0;
    
    if ([self.buttons count] == 2) {
        for (int i = 0 ; i < [self.buttons count] ; i++) {
            NSString *title = self.buttons[i];
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
            [btn setFrame:CGRectMake(originX, 0, footer.frame.size.width/2, footer.frame.size.height)];
            
            if (i == 0) {
                [btn setBackgroundColor:[UIColor colorWithRed:74/255. green:74/255. blue:74/255. alpha:1.]];
                UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:btn.bounds byRoundingCorners:UIRectCornerBottomLeft cornerRadii:CGSizeMake(10, 10)];
                
                CAShapeLayer *layer = [CAShapeLayer new];
                layer.frame = self.bounds;
                layer.path = path.CGPath;
                btn.layer.mask = layer;
            }
            else {
                [btn setBackgroundColor:[UIColor colorWithRed:48/255. green:198/255. blue:114/255. alpha:1]];
                UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:btn.bounds byRoundingCorners:UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
                
                CAShapeLayer *layer = [CAShapeLayer new];
                layer.frame = self.bounds;
                layer.path = path.CGPath;
                btn.layer.mask = layer;
            }
            btn.tag = i;
            [btn setTitle:title forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont fontWithName:@"AppleSDGothicNeo-Medium" size:16]];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [footer addSubview:btn];
            
            originX += btn.frame.size.width;
        }
    }
    else {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.tag = 0;
        [btn setFrame:CGRectMake(originX, 0, footer.frame.size.width, footer.frame.size.height)];
        [btn setBackgroundColor:[UIColor colorWithRed:48/255. green:198/255. blue:114/255. alpha:1.]];
        [btn.titleLabel setFont:[UIFont fontWithName:@"AppleSDGothicNeo-Medium" size:16]];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitle:self.buttons[0] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 0;
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:btn.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
        CAShapeLayer *layer = [CAShapeLayer new];
        layer.frame = self.bounds;
        layer.path = path.CGPath;
        btn.layer.mask = layer;
        
        [footer addSubview:btn];
    }
    
    return footer;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"messageCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, cell.frame.size.width - 40, cell.frame.size.height - 20)];
    [lbl setHidden:YES];
    lbl.numberOfLines = 0;
    [cell.contentView addSubview:lbl];
    
    cell.backgroundColor = [UIColor clearColor];
    
    if (indexPath.row > 0 && indexPath.row <= [self.messages count]) {
        [lbl setHidden:NO];
        NSString *message = self.messages[indexPath.row - 1];
        [lbl setText:message];
        [lbl setTextAlignment:NSTextAlignmentCenter];
        
        if (indexPath.row == 1) {
            lbl.textColor = [UIColor colorWithRed:74/255 green:74/255 blue:74/255 alpha:1];
            lbl.font = [UIFont fontWithName:@"AppleSDGothicNeo-Bold" size:20];
        }
        else {
            lbl.textColor = [UIColor colorWithRed:74/255 green:74/255 blue:74/255 alpha:1];
            lbl.font = [UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:14];
        }
    }
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row > 0 && indexPath.row <= [self.messages count]) {
        
        CGSize size = [UIScreen mainScreen].bounds.size;
        if (indexPath.row == 1) {
            NSString *str = self.messages[indexPath.row - 1];
            
            UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width - 40, CGFLOAT_MAX)];
            [lbl setNumberOfLines:0];
            [lbl setText:str];
            [lbl setFont:[UIFont fontWithName:@"AppleSDGothicNeo-Bold" size:20]];
            [lbl sizeToFit];
            
            return lbl.frame.size.height + 28;
        }
        
        if ([self.messages count] == indexPath.row) {
            NSString *str = self.messages[indexPath.row - 1];
            
            UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width - 40, CGFLOAT_MAX)];
            [lbl setNumberOfLines:0];
            [lbl setText:str];
            [lbl setFont:[UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:14]];
            [lbl sizeToFit];
            
            return lbl.frame.size.height + 12;
        }
    }
    
    return 32;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.messages count] + 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (void)createDialogView {
    
    CGSize size = CGSizeMake(self.dialogView.frame.size.width, self.tableView.contentSize.height);
    [self.dialogView setFrame:CGRectMake((SCREEN_WIDTH - (SCREEN_WIDTH - 80))/2, (SCREEN_HEIGHT - 260)/2, SCREEN_WIDTH - 80, size.height)];
    [self.tableView setFrame:CGRectMake(0, 0, self.dialogView.frame.size.width, self.dialogView.frame.size.height)];
    [self.dialogView setNeedsDisplay];
}


- (CGSize)getDialogSize {
    return CGSizeMake(self.tableView.frame.size.width, self.tableView.contentSize.height);
}

- (UIWindow *)topmostWindow
{
    UIWindow *topWindow = [[[UIApplication sharedApplication].windows sortedArrayUsingComparator:^NSComparisonResult(UIWindow *win1, UIWindow *win2) {
        return win1.windowLevel - win2.windowLevel;
    }] lastObject];
    return topWindow;
}


- (void)show {
    [self createDialogView];
    
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    [self addSubview:self.dialogView];
    
    CGSize dialogSize = [self getDialogSize];
    CGSize keyboardSize = CGSizeMake(0, 0);
    
    self.dialogView.frame = CGRectMake((SCREEN_WIDTH - (SCREEN_WIDTH - 80))/2, (SCREEN_HEIGHT - keyboardSize.height - dialogSize.height)/2, dialogSize.width, dialogSize.height);
    
    UIWindow *topWindow = [self topmostWindow];
    
    if (topWindow != nil) {
        [topWindow addSubview:self];
    }
    
    self.dialogView.layer.opacity = 0.5f;
    self.dialogView.layer.transform = CATransform3DMakeScale(1.3f, 1.3f, 1.0);
    
    [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f];
                         self.dialogView.layer.opacity = 1.0f;
                         self.dialogView.layer.transform = CATransform3DMakeScale(1, 1, 1);
                     }
                     completion:NULL
     ];
}

- (void)close {
    CATransform3D currentTransform = self.dialogView.layer.transform;
    
    self.dialogView.layer.opacity = 1.0f;
    
    [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         self.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.0f];
                         self.dialogView.layer.transform = CATransform3DConcat(currentTransform, CATransform3DMakeScale(0.6f, 0.6f, 1.0));
                         self.dialogView.layer.opacity = 0.0f;
                     }
                     completion:^(BOOL finished) {
                         for (UIView *v in [self subviews]) {
                             [v removeFromSuperview];
                         }
                         [self removeFromSuperview];
                     }
     ];
}


- (void)dealloc {
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}


// Rotation changed, on iOS8
- (void)changeOrientationForIOS8: (NSNotification *)notification {
    [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         CGSize dialogSize = [self getDialogSize];
                         CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
                         self.dialogView.frame = CGRectMake((SCREEN_WIDTH - dialogSize.width) / 2, (SCREEN_HEIGHT - keyboardSize.height - dialogSize.height) / 2, dialogSize.width, dialogSize.height);
                     }
                     completion:nil
     ];
}


// Handle device orientation changes
- (void)deviceOrientationDidChange: (NSNotification *)notification
{
    // If dialog is attached to the parent view, it probably wants to handle the orientation change itself
    [self changeOrientationForIOS8:notification];
}



// Handle keyboard show/hide changes
- (void)keyboardWillShow:(NSNotification *)notification {
    CGSize dialogSize = [self getDialogSize];
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (UIInterfaceOrientationIsLandscape(interfaceOrientation) && NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1) {
        CGFloat tmp = keyboardSize.height;
        keyboardSize.height = keyboardSize.width;
        keyboardSize.width = tmp;
    }
    
    [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         self.dialogView.frame = CGRectMake((SCREEN_WIDTH- dialogSize.width) / 2, (SCREEN_HEIGHT- (keyboardSize.height/2) - dialogSize.height) / 2, dialogSize.width, dialogSize.height);
                     }
                     completion:nil
     ];
}


- (void)keyboardWillHide:(NSNotification *)notification
{
    CGSize dialogSize = [self getDialogSize];
    
    [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         self.dialogView.frame = CGRectMake((SCREEN_WIDTH - dialogSize.width) / 2, (SCREEN_HEIGHT - dialogSize.height) / 2, dialogSize.width, dialogSize.height);
                     }
                     completion:nil
     ];
}

- (void)buttonAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(didSelectButtonIndex:index:)]) {
        [self.delegate didSelectButtonIndex:self index:sender.tag];
        
        [self close];
    }
    
    if (self.onButtonAction) {
        self.onButtonAction(self, sender.tag);
        
        [self close];
    }
}

@end
