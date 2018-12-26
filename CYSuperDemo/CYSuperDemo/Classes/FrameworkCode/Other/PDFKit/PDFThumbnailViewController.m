//
//  PDFThumbnailViewController.m
//  CYSuperDemo
//
//  Created by cyrill on 2018/12/26.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "PDFThumbnailViewController.h"
#import "PDFThumbnailCell.h"
#import <PDFKit/PDFKit.h>
#import <Masonry.h>

@interface PDFThumbnailViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
{
    dispatch_queue_t queue;
    NSCache *thumbnailCache;
}
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation PDFThumbnailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Thumbnail";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismissController)];
    
    queue = dispatch_queue_create("com.thumbnail.pdfview", DISPATCH_QUEUE_CONCURRENT);
    thumbnailCache = [[NSCache alloc] init];
    
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)dismissController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - --- UICollectionView DataSource ---

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.document.pageCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PDFThumbnailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellId" forIndexPath:indexPath];
    
    if (@available(iOS 11.0, *)) {
    
        PDFPage *page = [self.document pageAtIndex:indexPath.item];
        
        cell.label.text = page.label;
        
        NSString *key = [NSString stringWithFormat:@"%ld",(long)indexPath.item];
        
        UIImage *thumbnailImage = [thumbnailCache objectForKey:key];
        
        CGSize imageSize = CGSizeMake(cell.bounds.size.width * 2, cell.bounds.size.height * 2);
        
        
        
        if (thumbnailImage)
        {
            cell.imageView.image = thumbnailImage;
        }
        else
        {
            dispatch_async(queue, ^{
                
                UIImage *thumbnailImage = [page thumbnailOfSize:imageSize forBox:kPDFDisplayBoxMediaBox];
                [self->thumbnailCache setObject:thumbnailImage forKey:key];
                dispatch_async(dispatch_get_main_queue(), ^{
                    cell.imageView.image = thumbnailImage;
                });
            });
        }
        
    } else {
        
    }
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

#pragma mark - --- UICollectionView Delegate ---

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(thumbnailViewController:didSelectAtIndex:)])
    {
        [self.delegate thumbnailViewController:self didSelectAtIndex:indexPath];
    }
}

#pragma mark - --- setter & getter ---

- (UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        CGFloat itemWidth = floor(([UIScreen mainScreen].bounds.size.width - 10 * 4) / 3.0);
        CGFloat itemHeight = itemWidth * 1.5;
        
        UICollectionViewFlowLayout  *flowlayout = [[UICollectionViewFlowLayout alloc] init];
        flowlayout.itemSize = CGSizeMake(itemWidth, itemHeight);
        flowlayout.minimumLineSpacing = 10;
        flowlayout.minimumInteritemSpacing = 10;
        flowlayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowlayout];
        _collectionView.backgroundColor = [UIColor grayColor];
        _collectionView.showsVerticalScrollIndicator = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([PDFThumbnailCell class]) bundle:nil] forCellWithReuseIdentifier:@"CellId"];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    
    return _collectionView;
}


@end
