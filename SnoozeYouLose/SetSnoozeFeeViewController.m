//
//  SetSnoozeFeeViewController.m
//  SnoozeYouLose
//
//  Created by Jonathan Cobian on 1/17/15.
//  Copyright (c) 2015 Maribeth, Jonathan, Halli, Rita. All rights reserved.
//

#import "SetSnoozeFeeViewController.h"

@interface SetSnoozeFeeViewController ()

@end

@implementation SetSnoozeFeeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Set Snooze Fee";
    
    self.pickerData = @[@"$1",@"$2",@"$3",@"$4",@"$5"];
    self.feePickerView.delegate = self;
    self.feePickerView.dataSource = self;
    
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveButton setBackgroundImage:[UIImage imageNamed:@"save.png"] forState:UIControlStateNormal];
    saveButton.frame = CGRectMake(0,0,15,15);
    [saveButton addTarget:self action:@selector(savePressed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *saveBarButton = [[UIBarButtonItem alloc] initWithCustomView:saveButton];
    [self.navigationItem setRightBarButtonItem:saveBarButton];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"cancel.png"] forState:UIControlStateNormal];
    cancelButton.frame = CGRectMake(0,0,15,15);
    [cancelButton addTarget:self action:@selector(cancelPressed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *cancelBarButton = [[UIBarButtonItem alloc] initWithCustomView:cancelButton];
    [self.navigationItem setLeftBarButtonItem:cancelBarButton];
}

-(void)savePressed {
    NSInteger chosenFeeIdx = [self.feePickerView selectedRowInComponent:0];
    NSMutableString *chosenFee = [self.pickerData[chosenFeeIdx] mutableCopy];
    [chosenFee deleteCharactersInRange:NSMakeRange(0, 1)];
    self.alarm.snoozeCost = [NSNumber numberWithInteger:[chosenFee integerValue]];
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)cancelPressed {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.pickerData count];
}

// The data to return for the row and component (column) that's being passed in
- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title = self.pickerData[row];
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    return attString;
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
