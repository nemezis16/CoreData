//
//  ORTableViewController.m
//  EasyNote
//
//  Created by RomanOsadchuk on 10.11.15.
//  Copyright (c) 2015 Osadchuk. All rights reserved.
//

#import "ORTableViewController.h"
#import "ORDetailViewController.h"
#import "ORTableViewCell.h"
#import "ORDatabaseModel.h"

@interface ORTableViewController ()<NSFetchedResultsControllerDelegate>

@property (nonatomic,strong) NSFetchedResultsController* fetchedResultController;
@property(nonatomic,strong) UIView* border;

@end

@implementation ORTableViewController

#pragma mark -
#pragma  mark ViewController methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"Easy Note"];
    [self performFetch];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"addNoteViewController"]) {
        
        UINavigationController *navigatonController = (UINavigationController *)[segue destinationViewController];
        ORDetailViewController *detailViewController = (ORDetailViewController *)[navigatonController topViewController];
        [detailViewController setManagedObjectContext:self.managedObjectContext];
    }
    else if ([segue.identifier isEqualToString:@"editDetailViewController"]) {
        ORDetailViewController *detailViewController = (ORDetailViewController *)[segue destinationViewController];
        detailViewController.managedObjectContext=self.managedObjectContext;
        
        NSIndexPath* indexPath=[self  indexPathWhenClicked:sender];
        
        NSManagedObject *currentData = [self.fetchedResultController objectAtIndexPath:indexPath];
            if (currentData) {
                detailViewController.managedObject=currentData;
            }
        
    }
}

#pragma mark -
#pragma mark FetchedResultControllerDelegate methods

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    switch (type) {
        case NSFetchedResultsChangeInsert: {
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
        case NSFetchedResultsChangeDelete: {
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
        case NSFetchedResultsChangeUpdate: {
            [self configureCell:(ORTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
        }
        case NSFetchedResultsChangeMove: {
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
    }
}

#pragma mark -
#pragma mark TableViewDelegate methods


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *sections = [self.fetchedResultController sections];
    id<NSFetchedResultsSectionInfo> sectionInfo = [sections objectAtIndex:section];
    
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ORTableViewCell *cell = (ORTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure Table View Cell
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (IBAction)deleteCellWithButton:(id)sender {
    NSIndexPath* indexPath=[self indexPathWhenClicked:sender];
    NSManagedObject *record = [self.fetchedResultController objectAtIndexPath:indexPath];
    if (record) {
        [self.fetchedResultController.managedObjectContext deleteObject:record];
    }
}

#pragma mark -
#pragma mark supporting methods

- (void)configureCell:(ORTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    NSManagedObject *record = [self.fetchedResultController objectAtIndexPath:indexPath];
    [cell.dateLabel setText:[self dateToString:[record valueForKey:ORDateStampKey]]];
    [cell.descriptionLabel setText:[record valueForKey:ORTextDescriptionKey]];
    
}

-(NSString*)dateToString:(NSDate*)date{
    NSString * deviceLanguage = [[NSLocale preferredLanguages] objectAtIndex:0];
    NSDateFormatter * dateFormatter = [NSDateFormatter new];
    NSLocale * locale = [[NSLocale alloc] initWithLocaleIdentifier:deviceLanguage];
    
    [dateFormatter setDateFormat:@"dd MMMM YYYY hh:mm a"];
    [dateFormatter setLocale:locale];
    
    NSString * dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

#pragma  mark taked out from viewDidLoad methods

-(void)performFetch{
    
    NSFetchRequest* fetchedRequest=[[NSFetchRequest alloc]initWithEntityName:OREntityNoteKey];
    [fetchedRequest setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:ORDateStampKey ascending:NO]]];
    
    self.fetchedResultController =[[NSFetchedResultsController alloc]initWithFetchRequest:fetchedRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    [self.fetchedResultController setDelegate:self];
    
    NSError *error = nil;
    [self.fetchedResultController performFetch:&error];
    
    if (error) {
        NSLog(@"Unable to perform fetch.");
        NSLog(@"%@, %@", error, error.localizedDescription);
    }
}

-(void)setTitle:(NSString *)title{
    [super setTitle:title];
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0],NSForegroundColorAttributeName,
      nil,NSShadowAttributeName,
      [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:21.0],NSFontAttributeName,
      nil]];
}

-(NSIndexPath*)indexPathWhenClicked:(id)sender{
    ORTableViewCell* currentCell=(ORTableViewCell*)[[[sender superview]superview]superview];
    NSIndexPath* indexPath=[self.tableView indexPathForCell:currentCell];
    return indexPath;
}




@end
