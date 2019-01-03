//
//  FelixCollectionView.m
//  CollectionViewReloadIssue
//
//  Created by Felix Lapalme on 2019-01-03.
//  Copyright © 2019 Felix Lapalme. All rights reserved.
//

#import "FelixCollectionView.h"
#import "UITouch+Transit.h"

@implementation FelixCollectionView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.anyObject;
    CGPoint windowLocation = [touch locationInView:self.window];
    CGRect windowRect = [touch.view convertRect:touch.view.bounds toView:self.window];

    if (!CGRectContainsPoint(windowRect, windowLocation)) {
        NSLog(@"Correcting touch began");

        for (UICollectionViewCell *cell in self.visibleCells) {
            CGRect cellWindowRect = [cell convertRect:cell.bounds toView:self.window];
            if (CGRectContainsPoint(cellWindowRect, windowLocation)) {
                touches.anyObject.sp_overrideView = cell;
                break;
            }
        }
    }

    [super touchesBegan:touches withEvent:event];
}

@end
