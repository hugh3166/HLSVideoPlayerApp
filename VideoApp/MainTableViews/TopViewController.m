//
//  TopViewController.m
//  MasterDetailTest
//
//  Created by Young on 9/13/14.
//  Copyright (c) 2014 Young. All rights reserved.
//

#import "TopViewController.h"
#import "SubViewController.h"
#import "../TableCells/CatalogTableViewCell.h"
#import "../FunctionViews/LoginViewController.h"

#import "../Utilities/XMLReader.h"
#import "../Constants.h"

@interface TopViewController () {
    NSMutableArray *_mainCatalogs;
    LoginViewController *_loginController;
}
@end

@implementation TopViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    // show Edit Button for items
    //self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    NSError *error = nil;
//    NSURL *url = [NSURL URLWithString:@"http://example.com/sample.xml"];
//    NSString *data = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"sample" ofType:@"xml"];
    NSString *data = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    
    NSDictionary *resultDict = [XMLReader dictionaryForXMLString:data error:&error];
    [self initMainCatalogs:[resultDict objectForKey:XML_TOP]];
    
    // Register Messages to receive
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginEvent:)
                                                 name:LOGIN_EVENT
                                               object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 * initialize the data of main catalogs for presenting
 * @author Young
 */
- (void) initMainCatalogs:(NSDictionary *)data
{
    _mainCatalogs = [data objectForKey:XML_CATALOG];
}

#pragma mark - Table View

/*
 * used for setting the number of sections of the table view
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

/*
 * used for setting the number of rows of a section
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _mainCatalogs.count;
}

/*
 * set title for each section
 */
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    // the header for the section
//    return @"Title";
//}

/*
 * generate cells for index path ?(whats the index path?)
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"CatalogCell";
    CatalogTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[CatalogTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:reuseIdentifier];
    }
    
    NSDictionary *subject = _mainCatalogs[indexPath.row];
    [((CatalogTableViewCell *)cell) initInformation:subject];
    return cell;
}

/*
 * set the editability of each row ?(whats the difference of cell and row?)
 */
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

/*
 * use to modify the rows, (delete or insert)
 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_mainCatalogs removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

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

#pragma mark Page transitions

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    id item = [_mainCatalogs[indexPath.row] objectForKey:XML_SUBJECT];
    SubViewController *subTable = [segue destinationViewController];
    [subTable setTableData:item];
}

- (IBAction)btnLogin:(UIButton *)sender
{
    if (_loginController == nil) {
        UIStoryboard *storyboard = self.navigationController.storyboard;
        LoginViewController *loginView = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        _loginController = loginView;
    }
    
    // TODO: animation
    [self.view.window addSubview:[_loginController view]];
}

#pragma mark Event processiong

- (void) loginEvent:(NSNotification *)notification {
    
    [[_loginController view] removeFromSuperview];
}

@end
