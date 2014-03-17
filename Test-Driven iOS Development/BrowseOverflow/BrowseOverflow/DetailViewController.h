//
//  DetailViewController.h
//  BrowseOverflow
//
//  Created by Andrew Melis on 3/16/14.
//  Copyright (c) 2014 Baller Status Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
