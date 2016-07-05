//
//  T1ViewController.m
//  MosonryDemo
//
//  Created by Meng Fan on 16/7/5.
//  Copyright © 2016年 Meng Fan. All rights reserved.
//

#import "T1ViewController.h"
#import "C1.h"

@interface T1ViewController ()

@property (nonatomic, strong) NSArray *tableData;

//存计算Cell高度的实例变量
@property (nonatomic, strong) UITableViewCell *prototypeCell;

@end

@implementation T1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableData = @[@"1\n2\n3\n4\n5\n6", @"123456789012345678901234567890", @"1\n2", @"1\n2\n3", @"1"];
    
    self.prototypeCell  = [self.tableView dequeueReusableCellWithIdentifier:@"C1"];
    
    //注册单元格
    UINib *cellNib = [UINib nibWithNibName:@"C1" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"C1"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    C1 *cell = [self.tableView dequeueReusableCellWithIdentifier:@"C1"];
    cell.t.text = [self.tableData objectAtIndex:indexPath.row];
    return cell;
}


/* 这里有一个需要特别注意的问题，也是效率问题。UITableView是一次性计算完所有Cell的高度，如果有1W个Cell，那么- (CGFloat)tableView:(UITableView )tableView heightForRowAtIndexPath:(NSIndexPath )indexPath就会触发1W次，然后才显示内容。不过在iOS7以后，提供了一个新方法可以避免这1W次调用，它就是- (CGFloat)tableView:(UITableView )tableView estimatedHeightForRowAtIndexPath:(NSIndexPath )indexPath。要求返回一个Cell的估计值，实现了这个方法，那只有显示的Cell才会触发计算高度的protocol. 由于systemLayoutSizeFittingSize需要cell的一个实例才能计算，所以这儿用一个成员变量存一个Cell的实列，这样就不需要每次计算Cell高度的时候去动态生成一个Cell实例，这样即方便也高效也少用内存，可谓一举三得。 */

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    C1 *cell = (C1 *)self.prototypeCell;
    cell.t.text = [self.tableData objectAtIndex:indexPath.row];
    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    NSLog(@"h=%f", size.height + 1);
    return 1  + size.height;
    
    /* 注意：必须要加1
     
     如果不加1，结果就是错误的，Cell中UILabel将显示不正确。原因就是因为这行代码CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];由于是在cell.contentView上调用这个方法，那么返回的值将是contentView的高度，UITableViewCell的高度要比它的contentView要高1,也就是它的分隔线的高度。 */
}


@end
