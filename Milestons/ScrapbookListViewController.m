//
//  ScrapbookListViewController.m
//  Milestons
//
//  Created by Dalton on 5/2/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import "ScrapbookListViewController.h"
#import "Appearance.h"
#import "AddScrapbookViewController.h"
#import "ScrapbookController.h"
#import "SWRevealViewController.h"

@import Parse;
@import ParseUI;



@interface ScrapbookListViewController () <UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ScrapbookListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // This sets up the slide out menu
    self.options.target = self.revealViewController;
    self.options.action = @selector(revealToggle:);

    
//    if (self.revealViewController.panGestureRecognizer) {
//      [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
//    }
    
//    UIPanGestureRecognizer *gestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(revealToggle:)];
//    [self.view addGestureRecognizer:gestureRecognizer];
    
//    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    [Appearance initializeAppearanceDefaults];

}

-(void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    AddScrapbookViewController *addScrapbookViewController = [AddScrapbookViewController new];
    [addScrapbookViewController updateWithScrapbook:[ScrapbookController sharedInstance].scrapbooks[indexPath.row]];
    
}





@end
