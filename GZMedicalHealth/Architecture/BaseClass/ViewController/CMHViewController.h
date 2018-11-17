//
//  CMHViewController.h
//  MHDevelopExample
//
//  Created by lx on 2018/5/22.
//  Copyright © 2018年 CoderMikeHe. All rights reserved.
//  所有自定义视图控制器的基类

#import <UIKit/UIKit.h>

/// The base map of 'params'
/// The `params` parameter in `-initWithParams:` method.
/// Key-Values's key
/// 传递唯一ID的key：例如：商品id 用户id...
FOUNDATION_EXTERN NSString *const CMHViewControllerIDKey;
/// 传递数据模型的key：例如 商品模型的传递 用户模型的传递...
FOUNDATION_EXTERN NSString *const CMHViewControllerUtilKey;
/// 传递webView Request的key：例如 webView request...
FOUNDATION_EXTERN NSString *const CMHViewControllerRequestKey;

@interface CMHViewController : UIViewController

/**
 Initialization method. This is the preferred way to create a new Controller.

 @param params - The parameters to be passed to Controller.
 @return a new Controller.
 */
- (instancetype)initWithParams:(NSDictionary *)params;

/**
 基础配置 （PS：子类可以重写，但不需要在ViewDidLoad中手动调用，但是子类重写必须调用 [super configure]）
 */
- (void)configure;

/**
 请求远程数据
 sub class can override ， 但不需要在ViewDidLoad中手动调用 ，依赖`shouldRequestRemoteDataOnViewDidLoad = YES` 且不用调用 super， 直接重写覆盖
 */
- (void)requestRemoteData;

/**
 fetch the local data
 sub class can override ，且不用调用 super， 直接重写覆盖
 @return a local data
 */
- (id)fetchLocalData;

/**
 The `params` parameter in `-initWithParams:` method.
 The `params` Key's `CMHViewControllerIDKey`
 */
@property (nonatomic, readonly, copy) NSDictionary *params;

/**
 The callback block. 当Push/Present时，通过block反向传值
 */
@property (nonatomic, readwrite, copy) void (^callback)(id);

/**
 should request data when viewController videwDidLoad . default is YES
 是否需要在控制器viewDidLoad后调用`requestRemoteData` default is YES
 */
@property (nonatomic, readwrite, assign) BOOL shouldRequestRemoteDataOnViewDidLoad;

/**
 FDFullscreenPopGesture
 Whether the interactive pop gesture is disabled when contained in a navigation
 stack. (是否取消掉左滑pop到上一层的功能（栈底控制器无效），默认为NO，不取消)
 */
@property (nonatomic, readwrite, assign) BOOL interactivePopDisabled;

/**
 Indicate this view controller prefers its navigation bar hidden or not,
 checked when view controller based navigation bar's appearance is enabled.
 Default to NO, bars are more likely to show.
 是否隐藏该控制器的导航栏 默认是不隐藏 (NO)
 */
@property (nonatomic, readwrite, assign) BOOL prefersNavigationBarHidden;

/**
 是否隐藏该控制器的导航栏底部的分割线 默认不隐藏 （NO）
 */
@property (nonatomic, readwrite, assign) BOOL prefersNavigationBarBottomLineHidden;

/**
 控制器的导航栏底部的分割线颜色 默认#e9e9e9
 */
@property (nonatomic, readwrite, strong) UIColor *prefersNavigationBarBottomLineColor;

/**
 IQKeyboardManager
 是否让IQKeyboardManager的管理键盘的事件 默认是YES（键盘管理）
 */
@property (nonatomic, readwrite, assign) BOOL keyboardEnable;

/**
 是否键盘弹起的时候，点击其他区域键盘掉下 默认是 YES
 */
@property (nonatomic, readwrite, assign) BOOL shouldResignOnTouchOutside;

/**
 To set keyboard distance from textField. can't be less than zero. Default is 10.0.
 keyboardDistanceFromTextField
 */
@property (nonatomic, readwrite, assign) CGFloat keyboardDistanceFromTextField;

/**
 截图（Push/Pop Present/Dismiss 过度过程中的缩略图）主要用在过渡动画里面
 */
@property (nonatomic, readwrite, strong) UIView *snapshot;

/**
 提示框确定和取消回调用的block

 @param index 取消、确定 索引值
 */
typedef void(^AlertBlock)(NSInteger index);

/**
 提示框
 
 @param message 信息
 */
-(void)ShowAlertWithMessage:(NSString *)message;

/**
 block 回调的 提示框
 
 @param title 标题
 @param message 信息
 @param delegate 代理
 @param block 回调
 */
-(void)ShowAlertTitle:(NSString *)title Message:(NSString *)message Delegate:(id)delegate  cancelButtonTitle:(NSString *)cancel otherButtonTitles:(NSString *)other Block:(AlertBlock)block;

@end
