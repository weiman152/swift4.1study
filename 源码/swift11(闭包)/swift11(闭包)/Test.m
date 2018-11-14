//
//  Test.m
//  swift11(闭包)
//
//  Created by iOS on 2018/10/10.
//  Copyright © 2018年 weiman. All rights reserved.
//

#import "Test.h"

@implementation Test

void (^ g_block)(void) = NULL;

void (* g_func)(void) = NULL;

void CTest(void) {
    
    if (g_block != NULL) {
        g_block();
    }
    
    if (g_func != NULL) {
        g_func();
    }
}

@end
