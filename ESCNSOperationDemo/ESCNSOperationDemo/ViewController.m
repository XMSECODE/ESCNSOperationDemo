//
//  ViewController.m
//  ESCNSOperationDemo
//
//  Created by xiatian on 2024/1/9.
//

#import "ViewController.h"
#import "ESCOperation.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
//    [self NSInvocationOperationFunction];
    
    
//    [self NSBlockOperationFunction];
    
        
//    [self MyOperationFunction];
    
//    [self NSOperationQueueTest1];
    
//    [self NSOperationQueueTest2];
    
//    [self NSOperationQueueTest3];
    
//    [self NSOperationQueueTest4];
    
//    [self NSOperationQueueTest5];
    
    [self NSOperationQueueTest6];
    
    NSLog(@"End");
    
}

//依赖
- (void)NSOperationQueueTest6 {
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
        //子线程执行
        NSLog(@"operation1 %@",[NSThread currentThread]);
    }];
    
    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
        //子线程执行
        NSLog(@"operation2 %@",[NSThread currentThread]);
    }];
    //operation1依赖operation2的执行，operation1必须在operation2执行完毕后再执行
    [operation1 addDependency:operation2];
   
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation1];
    [queue addOperation:operation2];
}
//回调方法
- (void)NSOperationQueueTest5 {
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        //子线程执行
        NSLog(@"%@",[NSThread currentThread]);
    }];
    [operation setCompletionBlock:^{
        //任务完成调用的方法
        NSLog(@"completion %@",[NSThread currentThread]);
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
}
//主线程
- (void)NSOperationQueueTest4 {
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        //主线程执行
        NSLog(@"%@",[NSThread currentThread]);
    }];
    [operation setCompletionBlock:^{
        //子线程执行
        NSLog(@"completion %@",[NSThread currentThread]);
    }];
    NSOperationQueue *queue = [NSOperationQueue mainQueue];
    [queue addOperation:operation];
}
//栅栏方法
- (void)NSOperationQueueTest3 {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperationWithBlock:^{
        NSLog(@"任务1 %@",[NSThread currentThread]);
        sleep(2);
    }];
    [queue addOperationWithBlock:^{
        NSLog(@"任务2 %@",[NSThread currentThread]);
    }];
    [queue addOperationWithBlock:^{
        NSLog(@"任务3 %@",[NSThread currentThread]);
    }];
    [queue addBarrierBlock:^{
        NSLog(@"任务4 %@",[NSThread currentThread]);
        sleep(1);
    }];
    [queue addOperationWithBlock:^{
        NSLog(@"任务5 %@",[NSThread currentThread]);
    }];
    [queue addOperationWithBlock:^{
        NSLog(@"任务6 %@",[NSThread currentThread]);
    }];
    [queue addOperationWithBlock:^{
        NSLog(@"任务7 %@",[NSThread currentThread]);
    }];
}
//block
- (void)NSOperationQueueTest2 {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperationWithBlock:^{
        NSLog(@"1 %@",[NSThread currentThread]);
    }];
}
//添加operation
- (void)NSOperationQueueTest1 {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:[NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"%@",[NSThread currentThread]);
    }]];
}
//自定义operation子类
- (void)MyOperationFunction {
    ESCOperation *operation = [[ESCOperation alloc] init];
    [operation start];
}
//NSBlockOperation
- (void)NSBlockOperationFunction {
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        sleep(2);
        //阻塞当前线程，在当前线程执行
        NSLog(@"%@",[NSThread currentThread]);
    }];
    [operation addExecutionBlock:^{
        //不阻塞当前线程，在子线程执行
        NSLog(@"block 2 %@",[NSThread currentThread]);
    }];
    [operation start];
}
//NSInvocationOperation
- (void)NSInvocationOperationFunction {
    NSInvocationOperation *operaton = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(run) object:nil];
    [operaton start];
    
}

- (void)run {
    sleep(3);
    //阻塞当前线程，在当前线程执行
    NSLog(@"%@",[NSThread currentThread]);
}


@end
