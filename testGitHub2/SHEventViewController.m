//
//  SHEventViewController.m
//  testGitHub2
//
//  Created by sathachie on 2013/05/28.
//  Copyright (c) 2013年 SH. All rights reserved.
//

#import "SHEventViewController.h"
#import "SHEventDataController.h"

@interface SHEventViewController () {
    EKEventStore *eventStore_;
    NSMutableArray *arrayEvent_;
}

@end

@implementation SHEventViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"イベント一覧";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (eventStore_ == nil)
        eventStore_ = [[EKEventStore alloc] init];
    
    dispatch_queue_t sub_queue_ = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(sub_queue_, ^{
        
        arrayEvent_ = [NSMutableArray arrayWithArray:[SHEventDataController allEvent:eventStore_]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrayEvent_.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
    EKEvent *event = arrayEvent_[indexPath.row];
    cell.textLabel.text = event.title;
    cell.detailTextLabel.text = [NSDateFormatter localizedStringFromDate:event.startDate dateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterShortStyle];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
