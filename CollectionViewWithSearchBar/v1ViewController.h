//
//  v1ViewController.h
//  CollectionViewExample
//
//  Created by Bean Bob on 5/29/15.
//  Copyright (c) 2015 makemegeek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface v1ViewController : UIViewController <UICollectionViewDelegate, UISearchBarDelegate>
{
    NSArray *collectionImages;
}

@property(nonatomic,retain) IBOutlet UICollectionView *myCollectionVw;

//SEARCH BAR
@property (strong, nonatomic) NSMutableArray* filteredTableData;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar2;
@property (nonatomic, assign) bool isFiltered;

@end
