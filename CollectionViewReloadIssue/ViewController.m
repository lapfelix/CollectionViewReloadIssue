//
//  ViewController.m
//  CollectionViewReloadIssue
//
//  Created by Felix Lapalme on 2019-01-03.
//  Copyright © 2019 Felix Lapalme. All rights reserved.
//

#import "ViewController.h"
#import "SPTextCollectionViewCell.h"
#import "FelixCollectionView.h"

@interface ViewController () <UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray<NSString *> *texts;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.flowLayout = [UICollectionViewFlowLayout new];
    self.flowLayout.itemSize = CGSizeMake(200, 60);

    Class collectionViewClass = UICollectionView.class;

    // Set to YES to enable a dirty workaround
    BOOL enableWorkaround = NO;
    if (enableWorkaround) {
        collectionViewClass = FelixCollectionView.class;
    }

    self.collectionView = [(UICollectionView *)[collectionViewClass alloc] initWithFrame:CGRectZero
                                             collectionViewLayout:self.flowLayout];
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;

    [self.view addSubview:self.collectionView];
    self.view.backgroundColor = UIColor.whiteColor;
    self.collectionView.backgroundColor = UIColor.clearColor;

    [NSLayoutConstraint activateConstraints:@[
                                              [self.collectionView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor],
                                              [self.collectionView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor],
                                              [self.collectionView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
                                              [self.collectionView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
                                              ]];

    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;

    self.texts = @[@"layoutMargins returns a set of insets from the edge of the view's bounds that denote a default spaciom the edge of the view's bounds that denote a default spaciom the edge of the view's bounds that denote a default spaciom the edge of the view's bounds that denote a default spaciom the edge of the view's bounds that denote a default spacing for laying out content.",
                   @"If preservesSuperviewLayoutMargins iins iins iins iins is YES, margins cascade down the view tree, adjusting for geometry offsets, so that settin",
                   @"the left value of layoutMargins on a superi superi superi superins iins iins iins iview will affect the left value of layoutMargins for subviews positioned close to the",
                   @"left edge of their superviewheir superviewheir superviewheir superviewheir superview's bounds",
                   @"If your view subclass uses layoutMargins in its layout or drawing, override -layoutMains in its layout or drawing, override -layoutMains in its layout or drawing, override -layoutMarginsDidChange in order to refresh your",
                   @"view if the margins change.",
                   @"On iOS 11.0 and later, please supphe layoutMargins property will depend on the user interface layout diirections by setting the directionalLayoutMargins property",
                   @"instead of the layoutMargins property. After setting the directionalLayoutMargins property, the values in the left and right",
                   @"fields of the layoutMargins property will depend on the user interface layout dihe layoutMargins property will depend on the user interface layout dihe layoutMargins property will depend on the user interface layout direction.",
                   @"If your view subclass uses layoutMargins in its layout or drawing, override -layouass uses layoutMargins in its layout or drawing, override -layouass uses layoutMargins in its layout or drawing, override -layoutMarginsDidChange in order to refresh your",
                   @"view if the marass uses layoutMargins in its layout or drawing, override -layougins change.",
                   @"On iOS 11.0 and ass uses layoutMargins in its layout or drawing, override -layoulater, please support both user interface layout directions by setting the directionalLayoutMargins property",
                   @"instead of the laass uses layoutMargins in its layout or drawing, override -layouyoutMargins property. After setting the directionalLayoutMargins property, the values in the left and right",
                   @"fields of the lass uses layoutMargins in its layout or drawing, override -layouayoutMargins property will depend on the user interface layout direction."];

    [self.collectionView registerClass:SPTextCollectionViewCell.class forCellWithReuseIdentifier:NSStringFromClass(SPTextCollectionViewCell.class)];

    [NSTimer scheduledTimerWithTimeInterval:0.1
                                     target:self.collectionView
                                   selector:@selector(reloadData)
                                   userInfo:nil
                                    repeats:YES];
}


- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    SPTextCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(SPTextCollectionViewCell.class)
                                                                               forIndexPath:indexPath];
    cell.text = self.texts[indexPath.row];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section { 
    return self.texts.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.view.backgroundColor = [UIColor colorWithHue:(arc4random() % 255) / 255.f
                                           saturation:0.4
                                           brightness:0.8
                                                alpha:1];
}

@end
