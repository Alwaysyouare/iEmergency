//
//  ICIMessageCell.m
//  iEmergency
//
//  Created by ICI on 15-8-21.
//  Copyright (c) 2015年 ICI. All rights reserved.
//

#import "ICIMessageCell.h"
#import "ICIMessageObject.h"

@implementation ICIMessageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setMessage:(ICIMessageObject *)message
{
    _message= message;
    _name.text = message.messageFrom;
    _content.text = message.messageContent;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    _date.text = [formatter stringFromDate:message.messageDate];
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
