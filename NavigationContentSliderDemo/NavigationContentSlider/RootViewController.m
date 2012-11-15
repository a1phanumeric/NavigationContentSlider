//
//  RootViewController.m
//  NavigationContentSlider
//
//  Created by Ed Rackham on 15/11/2012.
//  Copyright (c) 2012 edrackham.com. All rights reserved.
//

#import "RootViewController.h"
#import <QuartzCore/QuartzCore.h> // totally not needed, it's just to make the temp views look nicer.

@interface RootViewController ()

@property (strong, nonatomic) NSArray *sectionTitles;

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    _sectionTitles = [[NSArray alloc] initWithObjects:@"Page One", @"Page Two", @"Page Three", @"Page Four", @"Page Five", @"Page Six", @"Page Seven", @"Page Eight", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NavigationContentSliderDataSource
- (NSInteger)numberOfSectionsInNavigationContentSlider:(NavigationContentSlider *)navigationContentSlider{
    return _sectionTitles.count;
}

- (NSInteger)widthOfSectionTitlesInNavigationContentSlider:(NavigationContentSlider *)navigationContentSlider{
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 400 : 120;
}

- (NSString*)navigationContentSlider:(NavigationContentSlider *)navigationContentSlider titleForSectionAtIndex:(NSInteger)index{
    return [_sectionTitles objectAtIndex:index];
}

- (UIView *)navigationContentSlider:(NavigationContentSlider *)navigationContentSlider viewForSectionAtIndex:(NSInteger)index{
    CGSize size = [self maximumUsableFrame].size;
    
    UIView *tmpView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, size.width-20, size.height-20)];
    [tmpView setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.8]];
    [tmpView.layer setCornerRadius:10.0f];
    UILabel *aLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tmpView.frame.size.width, tmpView.frame.size.height)];
    [aLabel setBackgroundColor:[UIColor clearColor]];
    [aLabel setTextColor:[UIColor colorWithWhite:0.95 alpha:1.0]];
    [aLabel setTextAlignment:NSTextAlignmentCenter];
    [aLabel setText:[NSString stringWithFormat:@"UIView %i", index+1]];
    [tmpView addSubview:aLabel];
    
    return tmpView;
}

@end
