//
//  FactsViewController.m
//  sportsguide
//
//  Created by prudhvi on 5/26/15.
//  Copyright (c) 2015 gits. All rights reserved.
//

#import "FactsViewController.h"
#import "GAITracker.h"
#import "GAI.h"
#import "GAIDictionaryBuilder.h"

@interface FactsViewController ()

@property (nonatomic, strong) NSMutableDictionary *facts;
@property (nonatomic, strong) NSArray *factSectionTitles;

@end

@implementation FactsViewController

- (instancetype)init {
    // Call the superclass's designated initializer
    self = [super initWithStyle:UITableViewStylePlain];
    
    if (self) {
        self.title = @"Facts";
        self.tabBarItem.image = [UIImage imageNamed:@"facts.png"];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style{
    return [self init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"UITableViewCell"];
    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
    self.navigationItem.title = @"Facts";
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.facts = [[NSMutableDictionary alloc] init];
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *factsPath = [bundle pathForResource:@"facts" ofType:@"plist"];
    NSArray *factsArray = [NSArray arrayWithContentsOfFile:factsPath];
    
    for (int i = 0; i < [factsArray count]; i++) {
        NSString *title = [factsArray[i] objectForKey:@"factTitle"];
        NSArray *descArray = [factsArray[i] objectForKey:@"arraypart"];
        self.facts[title] = descArray;
    }
    
    self.factSectionTitles = [[self.facts allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"ui_action"     // Event category (required)
                                                          action:@"facts_loaded"  // Event action (required)
                                                           label:nil          // Event label
                                                           value:nil] build]];    // Event value
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    // Background color
    view.tintColor = [UIColor colorWithRed:(230/255.0) green:(230/255.0) blue:(250/255.0) alpha:1];
    
    // Text Color
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:[UIColor blackColor]];
    
    // Another way to set the background color
    // Note: does not preserve gradient effect of original header
    // header.contentView.backgroundColor = [UIColor blackColor];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [self.factSectionTitles count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.factSectionTitles objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSString *sectionTitle = [self.factSectionTitles objectAtIndex:section];
    NSArray *sectionFacts = [self.facts objectForKey:sectionTitle];
    return [sectionFacts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    // Configure the cell...
    NSString *sectionTitle = [self.factSectionTitles objectAtIndex:indexPath.section];
    NSArray *sectionFacts = [self.facts objectForKey:sectionTitle];
    NSString *fact = [sectionFacts objectAtIndex:indexPath.row];
    cell.textLabel.text = fact;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
