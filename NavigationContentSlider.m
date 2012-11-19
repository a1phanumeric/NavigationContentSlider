//
//  NavigationSlideViewController.m
//
//  Created by Ed Rackham on 14/11/2012.
//  Copyright (c) 2012 edrackham.com. All rights reserved.
//

#import "NavigationContentSlider.h"

// Mini subclas of UIView allows for UIScrollView events to occur
// outside of it's frame (useful for paging when the width is
// smaller than the required overall width)
@interface TitleBarView : UIView
@property (strong, nonatomic) UIScrollView *scrollView;
@end
@implementation TitleBarView
@synthesize scrollView;
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *child = nil;
    if ((child = [super hitTest:point withEvent:event]) == self) return self.scrollView;
    return child;
}
@end


@interface NavigationContentSlider ()

@property (assign, nonatomic) NSInteger totalSections;
@property (strong, nonatomic) NSMutableArray *sectionViews;
@property (assign, nonatomic) NSInteger sectionTitleWidth;
@property (strong, nonatomic) NSDictionary *sectionTitleTextAttributes;

@property (strong, nonatomic) UIScrollView *titleBarScrollView;
@property (strong, nonatomic) TitleBarView *titleBarView;
@property (strong, nonatomic) UIScrollView *contentScrollView;

@property (assign, nonatomic) CGFloat contentXOffsetScale;

@property (assign, nonatomic) BOOL isInitalised;

- (UILabel *)titleLabelForSectionTitleAtIndex:(NSInteger)index;

@end




@implementation NavigationContentSlider


#pragma mark - Standard Init

- (void)initialise{
    if(self.navigationController == nil)
        [NSException raise:@"NavigationContentSlider" format:@"NavigationSlideViewController can only be used on view controllers that are part of a UINavigationController stack."];
    
    self.dataSource = self;
}

- (id)initWithCoder:(NSCoder *)aCoder{
    self = [super initWithCoder:aCoder];
    if(self){
        [self initialise];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self initialise];
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated{
    if(!_manualInit)    [self initNavigationContentSlider];
    if(_isInitalised)   [self scrollViewDidScroll:_titleBarScrollView];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}



#pragma mark - Private Methods

- (UILabel *)titleLabelForSectionTitleAtIndex:(NSInteger)index{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(_sectionTitleWidth * index, 0, _sectionTitleWidth, 44.0)];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setText:[_dataSource navigationContentSlider:self titleForSectionAtIndex:index]];

    if(_sectionTitleTextAttributes == nil){
        [label setTextColor:[UIColor whiteColor]];
        [label setFont:[UIFont boldSystemFontOfSize:20.0]];
        [label setShadowColor:[UIColor colorWithWhite:0.0 alpha:0.5]];
    }else{
        [label setTextColor:[_sectionTitleTextAttributes objectForKey:UITextAttributeTextColor]];
        [label setFont:[_sectionTitleTextAttributes objectForKey:UITextAttributeFont]];
        [label setShadowColor:[_sectionTitleTextAttributes objectForKey:UITextAttributeTextShadowColor]];
        [label setShadowOffset:[[_sectionTitleTextAttributes objectForKey:UITextAttributeTextShadowOffset] CGSizeValue]];
    }
    
    return label;
}


#pragma mark - Public Methods

- (void)initNavigationContentSlider{
    
    if(_isInitalised){
        [self scrollViewDidScroll:_titleBarScrollView];
    }
    
    if(_isInitalised) return;
    
    // Prepare iVars
    _totalSections              = [_dataSource numberOfSectionsInNavigationContentSlider:self];
    _sectionTitleWidth          = [self.dataSource widthOfSectionTitlesInNavigationContentSlider:self];
    _sectionViews               = [[NSMutableArray alloc] initWithCapacity:_totalSections];
    CGSize viewSize             = [self maximumUsableFrame].size;
    int padding                 = floor((viewSize.width - _sectionTitleWidth) / 2) - 5;
    int navControllerHeight     = self.navigationController.navigationBar.frame.size.height;
    _contentXOffsetScale        = viewSize.width / _sectionTitleWidth;
    
    // Use title text attributes if set (and available)
    // If it's available, try to grab from local titleTextAttributes (for the local nav bar)
    // If that's nil, try the global titleTextAttributes from UIAppearance.
    if(NSProtocolFromString(@"UIAppearance")){
        if(self.navigationController.navigationBar.titleTextAttributes != nil){
            _sectionTitleTextAttributes = self.navigationController.navigationBar.titleTextAttributes;
        }else if([[UINavigationBar appearance] titleTextAttributes] != nil){
            _sectionTitleTextAttributes = [[UINavigationBar appearance] titleTextAttributes];
        }
    }
    
    
    // Validate
    if(_totalSections < 1)
        [NSException raise:@"NavigationContentSlider" format:@"Number of sections must be more than zero"];
    
    
    
    // Construct both the title and content UIScrollViews
    // Title bar scroll view
    _titleBarScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(padding, 0, _sectionTitleWidth, navControllerHeight)];
    [_titleBarScrollView setDelegate:self];
    [_titleBarScrollView setPagingEnabled:YES];
    [_titleBarScrollView setClipsToBounds:NO];
    [_titleBarScrollView setShowsHorizontalScrollIndicator:NO];
    
    // TitleBarView
    _titleBarView = [[TitleBarView alloc] initWithFrame:CGRectMake(0, 0, viewSize.width, navControllerHeight)];
    [_titleBarView setScrollView:_titleBarScrollView];
    [_titleBarView addSubview:_titleBarScrollView];
    
    // Content scroll view
    _contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, viewSize.width, viewSize.height)];
    [_contentScrollView setPagingEnabled:YES];
    [_contentScrollView setShowsHorizontalScrollIndicator:NO];
    [_contentScrollView setScrollEnabled:NO];
    
    int i;
    for(i=0; i<_totalSections; i++){
        // Add title
        [_titleBarScrollView addSubview:[self titleLabelForSectionTitleAtIndex:i]];
        
        // Add view
        UIView *sectionView = [self.dataSource navigationContentSlider:self viewForSectionAtIndex:i];
        CGRect frame = sectionView.frame;
        [sectionView setFrame:CGRectMake((viewSize.width * i) + frame.origin.x, frame.origin.y, frame.size.width, frame.size.height)];
        [_sectionViews addObject:sectionView];
        [_contentScrollView addSubview:sectionView];
        
    }
    
    [_titleBarScrollView    setContentSize:CGSizeMake(i*_sectionTitleWidth, navControllerHeight)];
    [_contentScrollView     setContentSize:CGSizeMake(i*viewSize.width, viewSize.height)];
    [self.navigationItem    setTitleView:_titleBarView];
    [self.view addSubview:_contentScrollView];
    
    _isInitalised = YES;
}



- (CGRect)maximumUsableFrame{
    CGRect maxFrame = [UIScreen mainScreen].applicationFrame;
    
    if(self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft || self.interfaceOrientation == UIInterfaceOrientationLandscapeRight){
        NSInteger width, height;
        width   = maxFrame.size.height;
        height  = maxFrame.size.width;
        maxFrame.size.height = height;
        maxFrame.size.width = width;
    }
    
    if(self.navigationController)
        maxFrame.size.height -= self.navigationController.navigationBar.frame.size.height;
    
    if(self.tabBarController && !self.tabBarController.tabBar.hidden)
        maxFrame.size.height -= self.tabBarController.tabBar.frame.size.height;
    
    return maxFrame;
}



#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int xOffset = scrollView.contentOffset.x;
    [_contentScrollView setContentOffset:CGPointMake(xOffset * _contentXOffsetScale, 0)];
}


#pragma mark - NavigationSlideViewControllerDataSource
// Just setting defaults here, to suppress warnings. The subclass should implement
// these data source methods.
- (NSInteger)numberOfSectionsInNavigationContentSlider:(NavigationContentSlider *)navigationContentSlider{
    return 0;
}
- (NSInteger)widthOfSectionTitlesInNavigationContentSlider:(NavigationContentSlider *)navigationContentSlider{
    return 100;
}
- (NSString *)navigationContentSlider:(NavigationContentSlider *)navigationContentSlider titleForSectionAtIndex:(NSInteger)index{
    return @"";
}
- (UIView *)navigationContentSlider:(NavigationContentSlider *)navigationContentSlider viewForSectionAtIndex:(NSInteger)index{
    return [[UIView alloc] init];
}
@end
