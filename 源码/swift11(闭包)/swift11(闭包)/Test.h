//
//  Test.h
//  swift11(闭包)
//
//  Created by iOS on 2018/10/10.
//  Copyright © 2018年 weiman. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Test : NSObject

extern void (^ _Nullable g_block)(void);
// 指向函数的指针
extern void (* _Nullable g_func)(void);

extern void CTest(void);


@end

NS_ASSUME_NONNULL_END
