//
//  ORDetailViewController.m
//  EasyNote
//
//  Created by RomanOsadchuk on 10.11.15.
//  Copyright (c) 2015 Osadchuk. All rights reserved.
//

#import "ORDetailViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ORDatabaseModel.h"

@interface ORDetailViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation ORDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"New Note"];
    [self setBordersToTextView];
    [self setCurrentMangagedObject];
}

#pragma mark - 
#pragma  mark actions

- (IBAction)save:(id)sender {
    
    
    NSString *name = self.textView.text;
    
    if (name && name.length) {
        // Create Entity
        NSEntityDescription *entity = [NSEntityDescription entityForName:OREntityNoteKey inManagedObjectContext:self.managedObjectContext];
        
        NSManagedObject *note;
        
        // Initialize Record if nil
        if(!self.managedObject){
         note= [[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:self.managedObjectContext];
        }else{
            note=self.managedObject;
        }
        
        // Populate Record
        [note setValue:name forKey:ORTextDescriptionKey];
        [note setValue:[NSDate date] forKey:ORDateStampKey];
        
        // Save Record
        NSError *error = nil;
        
        if ([self.managedObjectContext save:&error]) {
            // Dismiss View Controller
            [self dismissViewControllerAnimated:YES completion:nil];
            [[self navigationController]popViewControllerAnimated:YES];
            
        } else {
            if (error) {
                NSLog(@"Unable to save record.");
                NSLog(@"%@, %@", error, error.localizedDescription);
            }
            
            // Show Alert View
            [[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Your note could not be saved." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }
        
    } else {
        // Show Alert View
        [[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Your note needs some text." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
}


- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    [[self navigationController]popViewControllerAnimated:YES];
}

#pragma mark-
#pragma  mark taked out from viewDidLoad methods
-(void)setBordersToTextView{
    self.textView.layer.borderColor = [[UIColor grayColor] CGColor];
    self.textView.layer.borderWidth = 0.5;
    self.textView.layer.cornerRadius = 8;
    self.automaticallyAdjustsScrollViewInsets=NO;
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

-(void)setTitle:(NSString *)title{
    [super setTitle:title];
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0],NSForegroundColorAttributeName,
      [UIFont fontWithName:@"Arial" size:15.0],NSFontAttributeName,
      nil]];
}

-(void)setCurrentMangagedObject{
    
    self.dateLabel.text=[self dateToString:[NSDate date]];
    if (self.managedObject) {
        self.textView.text=[self.managedObject valueForKey:ORTextDescriptionKey];
    }
}

@end
