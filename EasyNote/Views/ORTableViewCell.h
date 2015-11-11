//
//  ORTableViewCell.h
//  EasyNote
//
//  Created by RomanOsadchuk on 10.11.15.
//  Copyright (c) 2015 Osadchuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ORTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *buttonLoadImage;
@property (weak, nonatomic) IBOutlet UIButton *buttonDeleteNote;
@property (weak, nonatomic) IBOutlet UIButton *buttonEditNote;


@end
