//
//  ORDatabaseModel.h
//  EasyNote
//
//  Created by RomanOsadchuk on 10.11.15.
//  Copyright (c) 2015 Osadchuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

extern NSString* const ORTextDescriptionKey;
extern NSString* const ORDateStampKey;

extern NSString* const ORPhotoDataKey;
extern NSString* const ORPhotoNumberKey;
extern NSString* const ORPhotoNameKey;

extern NSString* const OREntityPhotoKey;
extern NSString* const OREntityNoteKey;

@interface ORDatabaseModel : NSObject

-(void)saveContext;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end
