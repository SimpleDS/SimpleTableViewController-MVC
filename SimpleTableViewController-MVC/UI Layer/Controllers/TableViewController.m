//
//  TableViewController.m
//  SimpleTableViewController-MVC
//
//  Created by Dylan Sewell on 8/12/19.
//  Copyright © 2019 dylansewell. All rights reserved.
//

#import "TableViewController.h"
#import "Destination.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.destinations = [NSMutableArray new];
  
    // Add observer and listen to notifications for data source updates
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleDataChangedNotification:)
                                                 name:@"DataChanged"
                                               object:nil];
}

#pragma MARK - Data Source Methods
-(void)addDestination:(NSString *)d {
    Destination *destination = [[Destination alloc] initWithName:d];
    [self.destinations addObject:destination];
    // Post notification that model updated
    [self postDataChangedNotification];
}

-(void)removeDestinationAt:(NSInteger)index {
    [self.destinations removeObjectAtIndex:index];
    // Post notification that model updated
    [self postDataChangedNotification];
}


#pragma MARK - KVO Methods with Model

-(void)handleDataChangedNotification:(NSNotification *) notification {
    if ([notification.name isEqualToString:@"DataChanged"]) {
        NSLog(@"notification received");
        [self.tableView reloadData];
    }
}

-(void)postDataChangedNotification {
    NSLog(@"notification posted");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DataChanged" object:self];
}
#pragma MARK - Actions

- (IBAction)createNewDestination:(id)sender {
    // TODO: Update method to avoid any retain cycles
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"New Destination" message:@"Please enter a destination:" preferredStyle:UIAlertControllerStyleAlert];
    [ac addTextFieldWithConfigurationHandler:^(UITextField *textField) {
      textField.placeholder = @"Destination";
      textField.clearButtonMode = UITextFieldViewModeWhileEditing;
      textField.borderStyle = UITextBorderStyleNone;
        
    }];
  
    [ac addAction:[UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSArray *textFields = ac.textFields;
        NSString *d = [textFields[0] text];
        [self addDestination:d];
        
    }]];
  
    [ac addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
  
    [self presentViewController:ac animated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.destinations.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    Destination *d = self.destinations[indexPath.row];
    cell.textLabel.text = d.name;
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        [self removeDestinationAt:indexPath.row];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


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
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
