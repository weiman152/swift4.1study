//
//  test.m
//  swift10
//
//  Created by iOS on 2018/10/10.
//  Copyright © 2018年 weiman. All rights reserved.
//

#import "test.h"

@implementation test

void (^ _Nullable g_block)(void) = NULL;

void CTest(void) {
    if (g_block != NULL) {
        g_block();
    }
}

@end
