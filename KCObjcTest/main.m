//
//  main.m
//  KCObjcTest
//
//  Created by Cooci on 2020/3/5.
//

#import <Foundation/Foundation.h>
extern void _objc_autoreleasePoolPrint(void);

//struct LGTest {
//    LGTest(){
//        printf("1123 - %s",__func__);
//    }
//    ~LGTest(){
//        printf("5667 - %s",__func__);
//    }
//};

/**

 struct __AtAutoreleasePool {
   __AtAutoreleasePool() {atautoreleasepoolobj = objc_autoreleasePoolPush();}
   ~__AtAutoreleasePool() {objc_autoreleasePoolPop(atautoreleasepoolobj);}
   void * atautoreleasepoolobj;
 };
 
 */
// 1: 切入点
// 2: 对象是怎么进去 - 释放

// 1: @autoreleasepool 与线程关联
// 2: @autoreleasepool 嵌套 - 只会创建一个page - 但是有两个哨兵
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        // 1 + 504 + 505 + 505
        NSObject *objc = [[NSObject alloc] autorelease];
        NSLog(@"objc = %@",objc);
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            @autoreleasepool {
                NSObject *obj = [[NSObject alloc] autorelease];
                NSLog(@"obj = %@",obj);
                _objc_autoreleasePoolPrint();
            }
        });
        _objc_autoreleasePoolPrint();
    }
    
    // 3*16 + 8 = 56
    // 504 
    sleep(2);
    return 0;
}
