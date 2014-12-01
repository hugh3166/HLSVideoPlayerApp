//
//  SubViewController.m
//  VideoApp
//
//  Created by Young on 9/13/14.
//  Copyright (c) 2014 Young. All rights reserved.
//

#import "SubViewController.h"
#import "DetailViewController.h"
#import "../TableCells/CatalogTableViewCell.h"
#import "../TableCells/ItemTableViewCell.h"

#import "Constants.h"

@interface SubViewController () {
    id _subItems;
}
@end

@implementation SubViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    //self.clearsSelectionOnViewWillAppear = NO;
    // Uncomment the following line to display an Edit button and an Add button in the navigation bar for this view controller.
    //UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    //NSArray *buttons = [NSArray arrayWithObjects: self.editButtonItem, addButton, nil];
    //self.navigationItem.rightBarButtonItems = buttons;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 * set the data of sub catalog for presenting
 * @author Young
 */
- (void)setTableData:(id)items
{
    _subItems = items;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_subItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id cell = nil;
    NSDictionary *subject = _subItems[indexPath.row];
    NSString *name = [subject objectForKey:XML_KEY_NAME];
    if (name != nil) {
        // sub catalog
        static NSString *reuseCatalogIdentifier = @"CatalogCell";
        cell = [tableView dequeueReusableCellWithIdentifier:reuseCatalogIdentifier forIndexPath:indexPath];
        [((CatalogTableViewCell *)cell) initInformation:subject];
    } else {
        // detail items
        static NSString *reuseDetailIdentifier = @"ItemCell";
        cell = [tableView dequeueReusableCellWithIdentifier:reuseDetailIdentifier forIndexPath:indexPath];
        [((ItemTableViewCell *)cell) initInformation:subject];
    }
    

    return cell;
    
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    UIStoryboard *storyboard = self.navigationController.storyboard;
    id data = [[_subItems objectAtIndex:indexPath.row] objectForKey:XML_ITEM];
    if (data != nil) {
        // have items
        SubViewController *subController = [storyboard instantiateViewControllerWithIdentifier:@"SubViewController"];
        [subController setTableData:data];
        [[self navigationController] pushViewController:subController animated:YES];
    } else {
        // show details of items
        id item = [_subItems objectAtIndex:indexPath.row];
        
        DetailViewController *detailController = [storyboard instantiateViewControllerWithIdentifier:@"DetaiViewController"];
        [self.navigationController pushViewController:detailController animated:YES];
        [detailController setDetailItem:item];
    }
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    // TODO: pass data to Detail View for showing
}

@end
