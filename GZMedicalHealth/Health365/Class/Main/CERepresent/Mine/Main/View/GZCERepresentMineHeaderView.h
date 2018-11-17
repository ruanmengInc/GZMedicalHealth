//
//  GZCERepresentMineHeaderView.h
//  GZMedicalHealth
//
//  Created by Apple on 2018/9/1.
//  Copyright © 2018年 ruanmeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GZCERepresentMineHeaderView : UIView

@property (nonatomic, copy) void (^btnEventsBlock)(NSInteger tag);

@property (nonatomic, strong) GZCERepresentBaseModel *model;

+ (instancetype)createCERepresentMineHeaderView;

- (void)encodeWithCoder:(nonnull NSCoder *)aCoder;

+ (nonnull instancetype)appearance;

+ (nonnull instancetype)appearanceForTraitCollection:(nonnull UITraitCollection *)trait;

+ (nonnull instancetype)appearanceForTraitCollection:(nonnull UITraitCollection *)trait whenContainedIn:(nullable Class<UIAppearanceContainer>)ContainerClass, ...;

+ (nonnull instancetype)appearanceForTraitCollection:(nonnull UITraitCollection *)trait whenContainedInInstancesOfClasses:(nonnull NSArray<Class<UIAppearanceContainer>> *)containerTypes;

+ (nonnull instancetype)appearanceWhenContainedIn:(nullable Class<UIAppearanceContainer>)ContainerClass, ...;

+ (nonnull instancetype)appearanceWhenContainedInInstancesOfClasses:(nonnull NSArray<Class<UIAppearanceContainer>> *)containerTypes;

- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection;

- (CGPoint)convertPoint:(CGPoint)point fromCoordinateSpace:(nonnull id<UICoordinateSpace>)coordinateSpace;

- (CGPoint)convertPoint:(CGPoint)point toCoordinateSpace:(nonnull id<UICoordinateSpace>)coordinateSpace;

- (CGRect)convertRect:(CGRect)rect fromCoordinateSpace:(nonnull id<UICoordinateSpace>)coordinateSpace;

- (CGRect)convertRect:(CGRect)rect toCoordinateSpace:(nonnull id<UICoordinateSpace>)coordinateSpace;

- (void)didUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context withAnimationCoordinator:(nonnull UIFocusAnimationCoordinator *)coordinator;

- (void)setNeedsFocusUpdate;

- (BOOL)shouldUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context;

- (void)updateFocusIfNeeded;

- (nonnull NSArray<id<UIFocusItem>> *)focusItemsInRect:(CGRect)rect;

@end

