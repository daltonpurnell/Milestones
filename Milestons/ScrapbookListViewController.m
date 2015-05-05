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
    
    
    // This sets up the swipe recognition to open the slide out menu
    SWRevealViewController *revealController = [self revealViewController];
    
    self.options.target = revealController;
    self.options.action = @selector(revealToggle:);
    
//    [self.view addGestureRecognizer:revealController.panGestureRecognizer];
    
//    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self.revealViewController                                                                            action:@selector(revealToggle:)];
//    [self.view addGestureRecognizer:panGestureRecognizer];
    
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
