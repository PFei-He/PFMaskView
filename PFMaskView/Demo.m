//
//  Demo.m
//  PFMaskView
//
//  Created by PFei_He on 14-7-14.
//  Copyright (c) 2014年 PFei_He. All rights reserved.
//

#import "Demo.h"

@interface Demo ()

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) PFMaskView  *maskView;

@end

@implementation Demo

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, 300, 30)];
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    self.textField.returnKeyType = UIReturnKeySearch;
    self.textField.font = [UIFont systemFontOfSize:15];
    self.textField.placeholder = @"请输入您想搜索的内容";
    self.textField.delegate = self;
    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [[UITextField appearance] setTintColor:[UIColor blueColor]];
    [self.navigationController.navigationBar addSubview:self.textField];

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - self.navigationController.navigationBar.frame.size.height)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];

    //覆盖层
    if (!self.maskView) self.maskView = [[PFMaskView alloc] initWithFrame:self.tableView.frame];
    self.maskView.delegate = self;
/*
    //点击覆盖层
    [self.maskView didTappedUsingBlock:^{
        [self.textField resignFirstResponder];
        [self.maskView hidden];
    }];
 */
}

#pragma mark - UITextFieldDelegate Methods

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.maskView showInView:self.tableView];
    [self.textField becomeFirstResponder];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.maskView.frame = CGRectMake(scrollView.contentOffset.x, scrollView.contentOffset.y, self.maskView.frame.size.width, self.maskView.frame.size.height);
//    self.maskView.center = CGPointMake(scrollView.contentOffset.x + self.maskView.frame.size.width * 0.5, scrollView.contentOffset.y + self.maskView.frame.size.height * 0.5);
}

#pragma mark - UITableViewDataSource Methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";

    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];

    if (cell == nil) {
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}
///*
#pragma mark - PFMaskViewDelegate Methods

//点击覆盖层
- (void)maskViewDidTapped
{
    [self.textField resignFirstResponder];
    [self.maskView removeFromSuperview];
}
//*/
#pragma mark - Memory Management Methods

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
