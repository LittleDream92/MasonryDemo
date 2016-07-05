//
//  ViewController.m
//  MosonryDemo
//
//  Created by Meng Fan on 16/7/5.
//  Copyright © 2016年 Meng Fan. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Mosonry_MF.h"

//#import "T1ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *superView;

//约束属性
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *topConstraint;

//5、此处首先需要设置一个全局变量记录
@property (nonatomic, strong) MASConstraint *contentViewbottomConstraint;

@end

@implementation ViewController

//changeContant
- (IBAction)buttonAction:(UIButton *)sender {
    
    [UIView animateWithDuration:0.5 animations:^{
        if (sender.selected) {
            self.topConstraint.constant = 667 - 150;
        }else {
            self.topConstraint.constant = 64;
        }
    }];

    sender.selected = !sender.selected;
//    
//    T1ViewController *t1VC = [[T1ViewController alloc] init];
//    [self presentViewController:t1VC animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //动态的约束
    /* Auto Layout 的更新、修改约束操作，也不怎么友好和方便。
     
     先来看一下 NSLayoutConstraint 的API，貌似只有constant属性可以修改，其它都是只读的。所以对于现有约束的修改和更新都是围绕NSLayoutConstraint实例的constant属性展开的。 */
    
    
    
    
    //以下是代码masonry的使用
    
    /*
     * 首先提示以下masonry使用时的注意事项：
     1、在使用 mas_makeConstraint 方法给view添加约束的时候，必须要确定该view已经添加到父view上了，即[self.view addSubview:view]；否则将会约束报错。这个和使用NSLayoutConstraint一样。
     
     2、Autolayout不能同时存在两条针对于同一对象的约束，否则会报错。只能进行更新修改。
     
     3、其次对于 equalTo 和 mas_equalTo的区别：mas_equalTo只是对其参数进行了一个BOX操作(装箱) ，所支持的类型除了NSNumber支持的那些数值类型之外就只支持CGPoint、CGSize、UIEdgeInsets，例如：make.size.mas_equalTo(CGSizeMake(300,400));
     
     对于对象或是多个属性的处理，就使用equalTo，例如：make.size.equalTo(weakSelf.view); make.width.equalTo(weakSelf.view); make.height.equalTo(@30);
     
     4、方法with和and,这连个方法其实没有做任何操作，方法只是返回对象本身，这这个方法的左右完全是为了方法写的时候的可读性 。
     
     5、因为iOS中原点在左上角所以使用offset时注意right和bottom用负数。
     
     6、Masonry约束是无法更新 NSLayoutConstraint 约束。因为Masonry在更新约束的时候会去遍历查找view上面的约束集，先判断view上的约束的类是否为 MASLayoutConstraint的类，如果是才会进行更新。所以，如果你是用XIB、StoryBoard拉线添加的约束或者是通过代码方式使用NSLayoutConstraint类添加的约束都无法在代码里用Masonry的 mas_updateConstraints 方法进行约束更新。Masonry更新约束的部分源码：
     */
    
//    //mosonry的简
//    //1、居中显示一个view
//    self.superView = [UIView new];
//    self.superView.backgroundColor = [UIColor blackColor];
//    //在做autoLayout之前一定要先把view添加到父视图上，否则会报错
//    [self.view addSubview:self.superView];
//    
////    [self.superView mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.center.equalTo(self.view);
////        make.size.mas_equalTo(CGSizeMake(300, 300));
////    }];
//    
//    //第五个需要的位置
//    [self.superView mas_makeConstraints:^(MASConstraintMaker *make) {
//        //设定iconView的水平中心与控制器view水平中心重合，底部距离控制器view上部160，宽高都为85
//        make.centerX.equalTo(self.view);
//        make.bottom.equalTo(self.view).offset(-160);
//        make.width.height.equalTo(@85);
//    }];
//    
//    /*
//     * 问题分析一：
//     * 在Masonry中能够添加autolayout约束有三个函数:
//             - (NSArray *)mas_makeConstraints:(void(^)(MASConstraintMaker *make))block;
//             - (NSArray *)mas_updateConstraints:(void(^)(MASConstraintMaker *make))block;
//             - (NSArray *)mas_remakeConstraints:(void(^)(MASConstraintMaker *make))block;
//    
//     mas_makeConstraints 只负责新增约束 Autolayout不能同时存在两条针对于同一对象的约束 否则会报错
//     mas_updateConstraints 针对上面的情况 会更新在block中出现的约束 不会导致出现两个相同约束的情况
//     mas_remakeConstraints 则会清除之前的所有约束 仅保留最新的约束
//     
//     三种函数善加利用 就可以应对各种情况了
//     */
//    
//    /*
//     * 问题分析二：
//     * equalTo 和 mas_equalTo的区别在哪里呢？
//    
//         #define mas_equalTo(...)                 equalTo(MASBoxValue((__VA_ARGS__)))
//         #define mas_greaterThanOrEqualTo(...)    greaterThanOrEqualTo(MASBoxValue((__VA_ARGS__)))
//         #define mas_lessThanOrEqualTo(...)       lessThanOrEqualTo(MASBoxValue((__VA_ARGS__)))
//         
//         #define mas_offset(...)                  valueOffset(MASBoxValue((__VA_ARGS__)))
//
//     可以看到 mas_equalTo只是对其参数进行了一个BOX操作(装箱) MASBoxValue的定义具体可以看看源代码 太长就不贴出来了
//     
//     所支持的类型 除了NSNumber支持的那些数值类型之外 就只支持CGPoint CGSize UIEdgeInsets
//     
//     介绍完这几个问题 我们就继续往下了 PS:刚才定义的sv会成为我们接下来所有sample的superView
//     */
//    
//    //接下来的例子，父视图都是上边的superview
////    [self initFirstView];
//    
////    [self initSecondView];
//    
////    [self initThirdView];
//    
////    [self initFourthView];
//    
//    [self anomationView];
//    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//2、一个view略小于父视图，边距为10.
- (void)initFirstView {
    UIView *firstView = [UIView new];
    firstView.backgroundColor = [UIColor redColor];
    [self.superView addSubview:firstView];
    
    [firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        /*最复杂的写法
        make.top.equalTo(self.superView).with.offset(10);
        make.left.equalTo(self.superView).with.offset(10);
        make.right.equalTo(self.superView).with.offset(-10);
        make.bottom.equalTo(self.superView).with.offset(-10);
        */
        
        //等价于,最简洁的写法
        make.edges.equalTo(self.superView).with.insets(UIEdgeInsetsMake(10, 10, 10, 10));
        
        //也等价于
//        make.top.left.bottom.and.right.equalTo(self.superView).with.insets(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
}


//3、让两个高度为150的view垂直居中且等宽且等间隔排列 间隔为10(自动计算其宽度)
- (void)initSecondView {
    
    //初始化
    UIView *secondView1 = [UIView new];
    secondView1.backgroundColor = [UIColor orangeColor];
    [self.superView addSubview:secondView1];
    
    UIView *secondView2 = [UIView new];
    secondView2.backgroundColor = [UIColor orangeColor];
    [self.superView addSubview:secondView2];
    
    int padding = 10;
    
    //由于会自动提示补全，所以with我错写成width，导致崩溃，一定要注意谁的左边在睡的那一边的多少距离，格式对象要对
    [secondView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.superView.mas_centerY);
        make.left.equalTo(self.superView.mas_left).with.offset(padding);
        make.right.equalTo(secondView2.mas_left).with.offset(-padding);
        make.height.mas_equalTo(@150);
        make.width.equalTo(secondView2);
    }];

    [secondView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.superView.mas_centerY);
        make.left.equalTo(secondView1.mas_right).with.offset(padding);
        make.right.equalTo(self.superView.mas_right).with.offset(-padding);
        make.height.mas_equalTo(@150);
        make.width.equalTo(secondView1);
    }];
}

//4、在scrollView顺序排列一些view，并自动计算contentSize
- (void)initThirdView {
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.backgroundColor = [UIColor whiteColor];
    [self.superView addSubview:scrollView];
    
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.superView).with.insets(UIEdgeInsetsMake(5, 5, 5, 5));
    }];
    
    
    UIView *view1 = [UIView new];
    [scrollView addSubview:view1];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.width.equalTo(scrollView);
    }];
    
    int count = 10;
    UIView *lastView = nil;
    for (int i = 0; i < count; ++i) {
        UIView *subView = [UIView new];
        [view1 addSubview:subView];
        //颜色除了能用RGB来设置以外，还可以用HSB来设置，即色调（hue），饱和的（saturation），亮度（brightness）
        subView.backgroundColor =  [UIColor colorWithHue:( arc4random() % 256 / 256.0 )
                                              saturation:( arc4random() % 128 / 256.0 ) + 0.5
                                              brightness:( arc4random() % 128 / 256.0 ) + 0.5
                                                   alpha:1];
        
        [subView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(view1);
            make.height.mas_equalTo(@(20*i));
            
            //如果上边有视图，则接着它的下边，否则是第一个,在父视图下边
            if (lastView) {
                make.top.mas_equalTo(lastView.mas_bottom);
            }else {
                make.top.mas_equalTo(view1.mas_top);
            }
            
        }];
        
        lastView = subView;
    }
    
    // 当前边设置位置的时候height不确定时，可以分开设置make
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lastView.mas_bottom);
    }];
}


//5、横向或者纵向等间隙的排列一组view,自定义了一个类目
- (void)initFourthView {
    
    UIView *sv11 = [UIView new];
    UIView *sv12 = [UIView new];
    UIView *sv13 = [UIView new];
    UIView *sv21 = [UIView new];
    UIView *sv31 = [UIView new];
    
    sv11.backgroundColor = [UIColor redColor];
    sv12.backgroundColor = [UIColor redColor];
    sv13.backgroundColor = [UIColor redColor];
    sv21.backgroundColor = [UIColor redColor];
    sv31.backgroundColor = [UIColor redColor];
    
    [self.superView addSubview:sv11];
    [self.superView addSubview:sv12];
    [self.superView addSubview:sv13];
    [self.superView addSubview:sv21];
    [self.superView addSubview:sv31];
    
    //给予不同的大小 测试效果
    
    [sv11 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@[sv12,sv13]);
        make.centerX.equalTo(@[sv21,sv31]);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    [sv12 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 20));
    }];
    
    [sv13 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    [sv21 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 20));
    }];
    
    [sv31 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 60));
    }];
    
    [self.superView distributeSpacingHorizontallyWith:@[sv11,sv12,sv13]];
    [self.superView distributeSpacingVerticallyWith:@[sv11,sv21,sv31]];
    
//    [self.superView showPlaceHolderWithAllSubviews];
//    [self.superView hidePlaceHolder];
    
}

//6、以上都是静态的布局，有时候我们需要一些动画
- (void)anomationView {
    
    // 第一个方法中列子已经添加了约束，那么我想做一个iamgeView向上的动画，更新约束 参照不能变 只能改变constant常数值
    [self.superView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-([UIScreen mainScreen].bounds.size.height - 160));
    }];
    //改变了iamgeView的约束再运用一个简单的UIView动画 调用layoutifneed就可以了，
    //但要注意的是AutoLayout动画必须调用  layoutIfNeeded,layoutIfNeeded会根据约束重新设置frame
    [UIView animateWithDuration:5 delay:0.5 usingSpringWithDamping:0.2 initialSpringVelocity:2 options:0 animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        NSLog(@"动画完成");
    }];
    
   /* 
    首先简单解释一下tabelViewcell高度自适应的步骤：iOS8中引入一个UITableView的一项新功能 — selfSizeingCells:
    1.为原型单元格定义AutoLayout约束  contentView必须有底部依赖
    3.设置预估行高,tableView.estimatedRowHeight;
    2.指定tableView.rowHeight = UITableViewAutomaticDimension
    */
    
//    //此处首先需要设置一个全局变量记录
//    //搞一个全局属性接收contentView的底部约束 在需要卸载的地方卸载这个全局属性约束
//    self.contentViewbottomConstraint = make.bottom.equalTo(self.view).offset(-160);
//    make.width.height.equalTo(@85);
////}];
//
//    // 在需要contenView改变其底部参照的时候，首先把刚才接收的全局变量卸载，再为   contenView添加新的底部参照和底部约束，这样contenView可以实现自适应，自定义cell高
//    //  度也就实现了自适应
//    [self.contentViewbottomConstraint uninstall];
//    [self.superView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.button.mas_bottom).offset(100);
//    }];
}

@end
