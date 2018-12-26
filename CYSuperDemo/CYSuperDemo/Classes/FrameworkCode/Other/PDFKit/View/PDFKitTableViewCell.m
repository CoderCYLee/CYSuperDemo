
//
//  PDFKitTableViewCell.m
//  CYSuperDemo
//
//  Created by cyrill on 2018/12/26.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "PDFKitTableViewCell.h"
#import <PDFKit/PDFKit.h>

@interface PDFKitTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *fileNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *producerLabel;
@property (weak, nonatomic) IBOutlet UILabel *modDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *creatorLabel;
@property (weak, nonatomic) IBOutlet UILabel *creationDateLabel;

@end

@implementation PDFKitTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDocument:(PDFDocument *)document  API_AVAILABLE(ios(11.0)){
    _document = document;
    
    /*
     CreationDate = "2015-06-12 01:34:58 +0000";
     Creator = Keynote;
     ModDate = "2015-06-12 01:35:17 +0000";
     Producer = "Mac OS X 10.10.3 Quartz PDFContext";
     Title = "224_WWDC15 App Extension Best Practices_02_Final_D";
     */
    NSDictionary *dic = document.documentAttributes;
    NSString *name = [[NSFileManager defaultManager] displayNameAtPath:document.documentURL.path];
    
    NSDate *CreationDate = dic[@"CreationDate"];
    NSString *CreationDateStr = CreationDate?[CreationDate dateString]:nil;
    NSString *Creator = dic[@"Creator"];
    NSDate *ModDate = dic[@"ModDate"];
    NSString *ModDateStr = ModDate?[ModDate dateString]:nil;
    NSString *Producer = dic[@"Producer"];
    NSString *Title = dic[@"Title"];
    
    /*
     "PDF_FileName" = "文件名";
     "PDF_Title" = "标题";
     "PDF_Creator" = "作者";
     "PDF_Producer" = "所用工具";
     "PDF_CreationDate" = "创建时间";
     "PDF_ModDate" = "最近修改时间";
     
     "PDF_FileName" = "FileName";
     "PDF_Title" = "Title";
     "PDF_Creator" = "Creator";
     "PDF_Producer" = "Producer";
     "PDF_CreationDate" = "CreationDate";
     "PDF_ModDate" = "ModDate";
     */
    
    self.fileNameLabel.text = [NSString stringWithFormat:@"%@: %@", NSLocalizedString(@"PDF_FileName", @"FileName"), name]?:@"";
    self.fileNameLabel.hidden = !name;
    
    self.titleLabel.text = [NSString stringWithFormat:@"%@: %@", NSLocalizedString(@"PDF_Title", @"Title"), Title]?:@"";
    self.titleLabel.hidden = !Title;
    
    self.producerLabel.text = [NSString stringWithFormat:@"%@: %@", NSLocalizedString(@"PDF_Producer", @"Producer"), Producer]?:@"";
    self.producerLabel.hidden = !Producer;
    
    self.modDateLabel.text = [NSString stringWithFormat:@"%@: %@", NSLocalizedString(@"PDF_ModDate", @"ModDate"), ModDateStr]?:@"";
    self.modDateLabel.hidden = !ModDateStr;
    
    self.creatorLabel.text = [NSString stringWithFormat:@"%@: %@", NSLocalizedString(@"PDF_Creator", @"Creator"), Creator]?:@"";
    self.creatorLabel.hidden = !Creator;
    
    self.creationDateLabel.text = [NSString stringWithFormat:@"%@: %@", NSLocalizedString(@"PDF_CreationDate", @"CreationDate"), CreationDateStr]?:@"";
    self.creationDateLabel.hidden = !CreationDateStr;
    
}

@end
