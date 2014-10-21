//
//  MainViewController.m
//  SanguoFoold
//
//  Created by shawnsong on 14-4-5.
//  Copyright (c) 2014年 shawnsong. All rights reserved.
//

#import "MainViewController.h"
#import "SGSession.h"

@interface MainViewController ()

@end

@implementation MainViewController
@synthesize tableview;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    __group = [[NSMutableArray alloc] init];
    NSMutableDictionary *dict = NULL;
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"Tianya115", @"name", @"315815", @"PWD", nil];
    [__group addObject:dict];
    
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"Tianya415", @"name", @"315815", @"PWD", nil];
    [__group addObject:dict];
    
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"Tianya515", @"name", @"315815", @"PWD", nil];
    [__group addObject:dict];
    
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"Tianya615", @"name", @"315815", @"PWD", nil];
    [__group addObject:dict];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(doupdata) userInfo:nil repeats:YES];
}
- (void)doupdata
{
    [tableview reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Flipside View Controller

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.flipsidePopoverController dismissPopoverAnimated:YES];
    }
}

- (void)dealloc
{
    [_flipsidePopoverController release];
    [super dealloc];
}

- (IBAction)showInfo:(id)sender
{
    for (NSMutableDictionary * dict in __group)
    {
        if([dict objectForKey:@"session"] == NULL)
        {
            SGSession * session = [[SGSession alloc] init:[dict objectForKey:@"name"] PWD:[dict objectForKey:@"PWD"]];
            [session setDelegate:self];
            [session startAutoForceTask];
            [dict setObject:session forKey:@"session"];
        }
    }
    
    
    /*
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        FlipsideViewController *controller = [[[FlipsideViewController alloc] initWithNibName:@"FlipsideViewController" bundle:nil] autorelease];
        controller.delegate = self;
        controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:controller animated:YES completion:nil];
    } else {
        if (!self.flipsidePopoverController) {
            FlipsideViewController *controller = [[[FlipsideViewController alloc] initWithNibName:@"FlipsideViewController" bundle:nil] autorelease];
            controller.delegate = self;
            
            self.flipsidePopoverController = [[[UIPopoverController alloc] initWithContentViewController:controller] autorelease];
        }
        if ([self.flipsidePopoverController isPopoverVisible]) {
            [self.flipsidePopoverController dismissPopoverAnimated:YES];
        } else {
            [self.flipsidePopoverController presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        }
    }
     */
}

-(void) setForce_Runtimeinfo:(NSString *) info
{
    
}

-(void) setForcename:(NSString *) info
{
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [__group count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * showUserInfoCellIdentifier = @"ShowUserInfoCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:showUserInfoCellIdentifier];
    if (cell == nil)
    {
        // Create a cell to display an ingredient.
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                       reuseIdentifier:showUserInfoCellIdentifier]
                autorelease];
    }
    
    
    int index = indexPath.row;
    
    NSDictionary * dict = [__group objectAtIndex:index];
    {
        cell.textLabel.text= [dict objectForKey:@"name"];
        if([dict objectForKey:@"session"] == NULL)
        {
            cell.detailTextLabel.text = @"未启动";
        }
        else
        {
            SGSession * session = [dict objectForKey:@"session"];
            cell.detailTextLabel.text = [session getSumInfo];
        }
        
        return cell;
    }
    return NULL;

}


@end
