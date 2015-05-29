//
//  v1ViewController.m
//  CollectionViewExample
//
//  Created by Bean Bob on 5/29/15.
//  Copyright (c) 2015 makemegeek. All rights reserved.
//

#import "v1ViewController.h"

@interface v1ViewController ()

@end

@implementation v1ViewController

@synthesize myCollectionVw;
//search bar
@synthesize filteredTableData;
@synthesize searchBar2;
@synthesize isFiltered;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    searchBar2.delegate = (id)self;
    
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        // iOS 7
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    } else {
        // iOS 6
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    }
    
    collectionImages = [NSArray arrayWithObjects:@"image1.png",@"image2.png",@"image3.png",@"image4.png",@"image5.png",@"image6.png",@"image7.png",@"image8.png",@"image9.png",@"image10.png",@"image11.png",nil];
    
}

// Add this Method
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.myCollectionVw reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    int rowCount;
    if(self.isFiltered)
        rowCount = filteredTableData.count;
    else
        rowCount = collectionImages.count;
    
    return rowCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    UIImageView *img1 = (UIImageView *)[cell viewWithTag:100];
    UILabel *label1 = (UILabel *)[cell viewWithTag:101];
    NSString *str1;
    
    if(isFiltered)
    {
        str1 = [filteredTableData objectAtIndex:indexPath.row];
        
    }
    else
    {
        //NSLog(@"Not Sorted ...");
        str1 = [collectionImages objectAtIndex:indexPath.row];
    }
    
    
    img1.image = [UIImage imageNamed:str1];
    
    
    NSString *imgNameSr = [NSString stringWithFormat:@"%@",str1];
    label1.text = imgNameSr;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: Select Item
    
    NSString *nameSelected;
    
    if(isFiltered)
    {
        nameSelected = [filteredTableData objectAtIndex:[indexPath row]];
    }
    else
    {
        nameSelected = [collectionImages objectAtIndex:[indexPath row]];
    }
    
    NSLog(@"nameSelected: %@ ...", nameSelected);
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Deselect item
}


//*****************
// SEARCH BAR
//*****************

-(void)searchBar:(UISearchBar*)searchBar textDidChange:(NSString*)text
{
    //NSLog(@"searchBar ... text.length: %d", text.length);
    
    if(text.length == 0)
    {
        isFiltered = FALSE;
        [searchBar resignFirstResponder];
    }
    else
    {
        isFiltered = true;
        filteredTableData = [[NSMutableArray alloc] init];
        
        
        for (NSString* item in collectionImages)
        {
            //case insensative search - way cool
            if ([item rangeOfString:text options:NSCaseInsensitiveSearch].location != NSNotFound)
            {
                [filteredTableData addObject:item];
            }
            
        }
    }//end if-else
    
    [self.myCollectionVw reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    //User hit Search button on Keyboard
    [searchBar resignFirstResponder];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.text=@"";
    
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    
    isFiltered = FALSE;
    [self.myCollectionVw reloadData];
}


@end
