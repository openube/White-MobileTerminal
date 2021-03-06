// GestureSettingsViewController.m
// MobileTerminal

#import "GestureSettingsViewController.h"
#import "Settings.h"

@implementation GestureSettingsViewController

@synthesize gestureEditViewController;

- (void)awakeFromNib
{
  [super awakeFromNib];
  
  gestureSettings = [[Settings sharedInstance] gestureSettings];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [gestureSettings gestureItemCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{  
  static NSString *CellIdentifier = @"Cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
  }
  int index = (int)[indexPath indexAtPosition:1];
  GestureItem* gestureItem = [gestureSettings gestureItemAtIndex:index];
  cell.textLabel.text = gestureItem.name;
  // This must re-validate the action in case the action label isn't valid.
  id<GestureAction> action = [gestureSettings gestureActionForLabel:gestureItem.actionLabel];
  cell.detailTextLabel.text = [action label];
  cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
  return cell;
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.tableView.backgroundColor = [UIColor whiteColor]; // Background Color
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
  return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  int index = (int)[indexPath indexAtPosition:1];
  [self startEditing:[gestureSettings gestureItemAtIndex:index]];
}

- (void)startEditing:(GestureItem*)gestureItem
{
  gestureEditViewController.editingGestureItem = gestureItem;
  [self.navigationController pushViewController:gestureEditViewController animated:YES];
}

- (void)finishEditing:(id)sender
{
  [self.tableView reloadData];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
        return [NSString stringWithFormat:@"Gestures"];
}

@end

