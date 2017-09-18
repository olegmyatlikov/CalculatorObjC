//
//  SlideMenuViewController.m
//  CalculatorObjC
//
//  Created by Oleg Myatlikov on 9/18/17.
//  Copyright © 2017 Oleg Myatlikov. All rights reserved.
//

#import "SlideMenuViewController.h"
#import <REFrostedViewController.h>
#import <UIViewController+REFrostedViewController.h>
#import "MainNavigationViewController.h"

@interface SlideMenuViewController ()

@end

@implementation SlideMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorColor = [UIColor colorWithRed:150/255.0f green:161/255.0f blue:177/255.0f alpha:1.0f];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.opaque = NO;
    
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 40.0f)];
    [self.tableView setBackgroundColor:[UIColor colorWithRed:37/255.0f green:37/255.0f blue:37/255.0f alpha:1.0f]];
}


#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:19];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sectionIndex {
    if (sectionIndex == 0)
        return nil;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 34)];
    view.backgroundColor = [UIColor colorWithRed:167/255.0f green:167/255.0f blue:167/255.0f alpha:0.6f];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 0, 0)];
    label.text = @"";
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor blackColor];
    label.backgroundColor = [UIColor clearColor];
    [label sizeToFit];
    [view addSubview:label];
    
    return view;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MainNavigationViewController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        UIViewController *simpleCalculator = [self.storyboard instantiateViewControllerWithIdentifier:@"simpleCalculator"];
        navigationController.viewControllers = @[simpleCalculator];
    } else if (indexPath.section == 0 && indexPath.row == 1) {
        UIViewController *numeralSystemCalculator = [self.storyboard instantiateViewControllerWithIdentifier:@"numeralSystemCalculator"];
        navigationController.viewControllers = @[numeralSystemCalculator];
    } else if (indexPath.section == 0 && indexPath.row == 2) {
        UIViewController *engineerCalculator = [self.storyboard instantiateViewControllerWithIdentifier:@"engineerCalculator"];
        navigationController.viewControllers = @[engineerCalculator];
    } else if (indexPath.section == 0 && indexPath.row == 3) {
        UIViewController *allInOneCalculator = [self.storyboard instantiateViewControllerWithIdentifier:@"allInOneCalculator"];
        navigationController.viewControllers = @[allInOneCalculator];
    }
    
    self.frostedViewController.contentViewController = navigationController;
    [self.frostedViewController hideMenuViewController];
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 34;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSArray *titles = @[@"Simple", @"Numeral systems", @"Engineer", @"All in one"];
    cell.textLabel.text = titles[indexPath.row];
    
    return cell;
}

@end

