//
//  SPTextCollectionViewCell.h
//  CollectionViewShadows
//
//  Created by Felix Lapalme on 2018-03-01.
//  Copyright © 2018 Felix Lapalme. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPTextCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) NSString *text;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, strong) UILabel *label;

@end
