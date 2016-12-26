//
//  SessionViewController.m
//  Daudio
//
//  Created by Claudius Mbemba on 12/24/16.
//  Copyright © 2016 Claudius Mbemba. All rights reserved.
//

#import "SessionViewController.h"
#import "PlayerViewController.h"
#import "SessionDataService.h"
#import "UIViewController+Storyboard.h"
#import <Objection/Objection.h>

static NSString *dataService = @"dataService";

@interface SessionViewController () <UITableViewDelegate,PlayerViewControllerDelegate>

@end

@implementation SessionViewController {
    PlayerViewController *playerVC;
}

objection_requires(dataService)

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self.dataService;
    playerVC = [PlayerViewController controllerWithStoryboard];
    playerVC.delegate = self;
    self.dataService = [[SessionDataService alloc]initWithDefaults:NSUserDefaults.standardUserDefaults];
    [self.dataService loadData];
    [self setupRefreshControl];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)setupRefreshControl {
    self.tableView.refreshControl = [UIRefreshControl new];
    self.tableView.refreshControl.tintColor = [UIColor grayColor];
    self.tableView.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    [self.tableView.refreshControl addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventValueChanged];
}

- (void)refreshData {
    [self.tableView reloadData];
    [self.tableView.refreshControl endRefreshing];
}

#pragma mark TableView Delegates

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    playerVC.player.session = [self.dataService.savedSessions objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:playerVC animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.dataService.savedSessions removeObjectAtIndex:indexPath.row];
        [self.dataService saveData];
        [tableView reloadData];
    }
}


#pragma mark Player Delegates

- (void)didSetNewSession:(Session *)session {
    [self.dataService.savedSessions addObject:session];
}

#pragma mark Actions

- (IBAction)createNewSession:(id)sender {
    [self.navigationController pushViewController:playerVC animated:YES];
}

- (IBAction)saveAllSessions:(id)sender {
    [self.dataService saveData];
}

@end
