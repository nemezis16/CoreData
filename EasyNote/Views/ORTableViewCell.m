//
//  ORTableViewCell.m
//  EasyNote
//
//  Created by RomanOsadchuk on 10.11.15.
//  Copyright (c) 2015 Osadchuk. All rights reserved.
//

#import "ORTableViewCell.h"

@interface ORTableViewCell ()
@property (nonatomic,strong)UIView* borderView;
@end

@implementation ORTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    if (!self.borderView) {
        self.borderView=[self drawRectToCell];
        [self insertSubview:[self drawRectToCell] atIndex:0];
    }
    UIImage *imageDelete = [UIImage imageNamed:@"cross"];
    UIImage *imagePhoto = [UIImage imageNamed:@"photography"];
    UIImage *imageEdit = [UIImage imageNamed:@"drawing"];
    [self setImage:imageDelete toButton:self.buttonDeleteNote];
    [self setImage:imagePhoto toButton:self.buttonLoadImage];
    [self setImage:imageEdit toButton:self.buttonEditNote];
    
//    self.buttonLoadImage = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.buttonLoadImage.frame = CGRectMake(0.0, 0.0, 30.0, 30.0);
//    UIImage *image = [[UIImage imageNamed:@"cross.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5.0,5.0,5.0,5.0)];
//    [self.buttonLoadImage setBackgroundImage:image forState:UIControlStateNormal];
//    [self addSubview:self.buttonLoadImage];
    
//    UIImage *imageButtonImage = [[UIImage imageNamed:@"cross.png" ] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
//    self.buttonLoadImage.frame = CGRectMake(self.buttonLoadImage.bounds.origin.x, self.buttonLoadImage.bounds.origin.y, 5.0f, 5.0f);
//    //[self.buttonLoadImage setBackgroundImage:imageButtonImage forState:UIControlStateNormal];
//    [self.buttonLoadImage setImage:imageButtonImage forState:UIControlStateNormal];
//    self.buttonLoadImage.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
//    self.buttonLoadImage.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
//   // [self addSubview:self.buttonLoadImage];
    
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
   // [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(UIView*)drawRectToCell{
    CGPoint topPoint=self.descriptionLabel.frame.origin;
    CGFloat labelHeight=self.frame.size.height-self.descriptionLabel.frame.origin.y;
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(topPoint.x-10, topPoint.y, self.descriptionLabel.frame.size.width+20, labelHeight)];
    view.backgroundColor=[UIColor clearColor];
    view.layer.borderColor = [UIColor grayColor].CGColor;
    view.layer.borderWidth = 0.3;
    view.layer.cornerRadius=10.0f;
     view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    return view;
    
}

-(void)setImage:(UIImage*)image toButton:(UIButton*)button{
    
    button.layer.cornerRadius = button.frame.size.width / 2;
    button.clipsToBounds = YES;
    button.layer.borderColor = [UIColor colorWithRed:78.0f/255.0f green:165.0/255.0f blue:252.0f/255.0f alpha:1.0f].CGColor;
    button.layer.borderWidth = 1;
    
    [button setImage:image forState:UIControlStateNormal];
}

@end
