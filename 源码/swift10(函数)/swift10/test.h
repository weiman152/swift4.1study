//
//  test.h
//  swift10
//
//  Created by iOS on 2018/10/10.
//  Copyright © 2018年 weiman. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface test : NSObject

//g_block将是我们在是swift源文件中操作的Block对象
extern void (^ _Nullable g_block)(void);
//CTest函数用于查看回调效果。
extern void CTest(void);

@end

NS_ASSUME_NONNULL_END
