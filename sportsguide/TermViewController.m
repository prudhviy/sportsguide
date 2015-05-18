//
//  TermViewController.m
//  sportsguide
//
//  Created by prudhvi on 5/15/15.
//  Copyright (c) 2015 gits. All rights reserved.
//

#import "TermViewController.h"
#import "TermStore.h"
#import "Term.h"
#import "TermDetailViewController.h"

@interface TermViewController () <UIScrollViewDelegate, UISearchResultsUpdating, UISearchBarDelegate>

@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) NSMutableArray *searchResults; // Filtered search results

@end

@implementation TermViewController


- (instancetype)init {
    // Call the superclass's designated initializer
    self = [super initWithStyle:UITableViewStylePlain];
    
    if (self) {
        self.title = @"Terms";
        //self.tabBarItem.image
        // loads all terms from plist file to store
        [[TermStore sharedStore] loadAllTerms];
        self.searchResults = [NSMutableArray arrayWithCapacity: [[[TermStore sharedStore] allTerms] count]];
        
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
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.title = @"Terms";
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
    UITableViewController *searchResultsController = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    searchResultsController.tableView.dataSource = self;
    searchResultsController.tableView.delegate = self;
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    self.searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
    self.searchController.dimsBackgroundDuringPresentation = FALSE;
    //self.searchController.disablesAutomaticKeyboardDismissal
    self.tableView.tableHeaderView = self.searchController.searchBar;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //[self.tableView reloadData]; // to reload selected cell
    self.searchController.searchBar.hidden = FALSE;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (self.searchController.active) {
        return [self.searchResults count];
    } else {
        return [[[TermStore sharedStore] allTerms] count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
 
    // Create an instance of UITableViewCell, with default appearance
    //UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
 
    // Set the text on the cell with the description of the item
    // that is at the nth index of items, where n = row this cell
    // will appear in on the tableview
    if (self.searchController.active) {
        Term *term = self.searchResults[indexPath.row];
        cell.textLabel.text = [term name];
    } else {
        NSArray *terms = [[TermStore sharedStore] allTerms];
        Term *term = terms[indexPath.row];
        cell.textLabel.text = [term name];
    }
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
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


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TermDetailViewController *detailViewController = [[TermDetailViewController alloc] init];
 
    NSArray *terms = [[TermStore sharedStore] allTerms];
    Term *selectedTerm = terms[indexPath.row];
 
    // Give detail view controller a pointer to the item object in row
    detailViewController.term = selectedTerm;
    
    //[self.searchController.searchBar resignFirstResponder];
    self.searchController.searchBar.hidden = TRUE;

    //[self.navigationController presentViewController:detailViewController animated:YES completion:nil];
    // Push it onto the top of the navigation controller's stack
    [self.navigationController pushViewController:detailViewController animated:YES];
    
    //<#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    @autoreleasepool {
        NSString *searchString = [self.searchController.searchBar text];
        [self populateSearchResults:searchString];
    }
    self.searchResults = self.searchResults;
    [self.tableView reloadData];
}

- (void)populateSearchResults:(NSString *)searchTerm {
    NSArray *terms = [[TermStore sharedStore] allTerms];
    // Update the filtered array based on the search text and scope.
    if ((searchTerm == nil) || [searchTerm length] == 0) {
        NSMutableArray *searchResults = [[NSMutableArray alloc] init];
        
        for (Term *termObj in terms) {
            [searchResults addObject:termObj];
        }
        
        self.searchResults = searchResults;
        return;
    }
    
    [self.searchResults removeAllObjects]; // First clear the filtered array.

    for (Term *term_obj in terms) {
        NSString *temp = [NSString stringWithFormat: @"%@%@", @"\\b", searchTerm];
        NSError* regexError = nil;
        NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:temp
                                                                options:NSRegularExpressionCaseInsensitive|NSRegularExpressionDotMatchesLineSeparators
                                                                                error:&regexError];
        
        if (regexError){
            NSLog(@"Regex creation failed with error: %@", [regexError description]);
            return;
        }
        
        NSArray *matches = [regex matchesInString:term_obj.name
                                          options:NSMatchingWithoutAnchoringBounds 
                                            range:NSMakeRange(0, term_obj.name.length)];
        
        /*if(matches.count > 0) {

            for (NSUInteger matchIdx = 0; matchIdx < matches.count; matchIdx++) {
                NSTextCheckingResult *match = [matches objectAtIndex:matchIdx];
                NSRange matchRange = [match range];
                NSString *resultR = [term_obj.name substringWithRange:matchRange];
                NSLog(@"%@ for %@", resultR, term_obj.name);
            }
            
        }*/
        
        if(matches.count > 0) {
            // NSLog(@"%@", term_obj.name);
            [self.searchResults addObject:term_obj];
        }
    }
}

@end
