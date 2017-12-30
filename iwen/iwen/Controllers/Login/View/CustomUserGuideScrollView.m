//
//  CustomUserGuideScrollView.m
//  HWSDK
//
//  Created by Carl on 14-1-12.
//  Copyright (c) 2014年 Carl. All rights reserved.
//

#import "CustomUserGuideScrollView.h"

@implementation CustomUserGuideScrollView
#pragma mark - Life Cycle
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)dealloc
{
    _scrollView.delegate = nil;
    _scrollView = nil;
    _pageControl = nil;
}

#pragma mark - Instance Methods
- (id)initWithFrame:(CGRect)frame imageNames:(NSArray *)imageNames isShowPage:(BOOL)isShow
{
    self = [super initWithFrame:frame];
    if(self)
    {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.bounces = YES;
        for(int i = 0; i < [imageNames count]; i++)
        {
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * frame.size.width, 0, frame.size.width, frame.size.height)];
            UIImage * image = [UIImage imageNamed:[imageNames objectAtIndex:i]];
            imageView.image = image;
            [_scrollView addSubview:imageView];
            image = nil;
            imageView = nil;
            
        }
        _scrollView.contentSize = CGSizeMake([imageNames count] * frame.size.width, frame.size.height);
        [self addSubview:_scrollView];
        
        if(isShow)
        {
            CGFloat pageControlHeight = 30.0f;
            _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, frame.size.height - pageControlHeight - 10.0f, frame.size.width,pageControlHeight)];
            _pageControl.numberOfPages = [imageNames count];
            _pageControl.currentPage = 0;
            _pageControl.backgroundColor = [UIColor clearColor];
//            [_pageControl addTarget:self action:@selector(pageChange:) forControlEvents:UIControlEventValueChanged];
            [self addSubview:_pageControl];
        }
    }
    return self;
}

- (void)finish:(BOOL)animted
{
    [UIView animateWithDuration:.3f animations:^{
        if(animted)
        {
            [self setFrame:CGRectMake(-self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
            self.alpha = 0.0f;
        }
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)pageChange:(UIPageControl *)pageControl
{
    [_scrollView scrollRectToVisible:CGRectMake(pageControl.currentPage * _scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height) animated:YES];
}

- (void)finishAction:(id)sender
{
    [self finish:YES];
}

#pragma mark - UIScrollViewDelegate Methods
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    if (self.fin) return;
    
    int offsetX = _scrollView.contentOffset.x -_scrollView.contentSize.width + _scrollView.frame.size.width;
    
    if(offsetX < 70.0f)
        return;
    _scrollView.contentOffset = scrollView.contentOffset;
    [self finish:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView

{
    
   
    int pageIndex = _scrollView.contentOffset.x / _scrollView.frame.size.width;
    if(_pageControl)
    {
        _pageControl.currentPage = pageIndex;
    }
    if (self.fin) return;
    int totalPages = _scrollView.contentSize.width / _scrollView.frame.size.width;
    
    if(pageIndex == totalPages - 1)
    {
        [[_scrollView viewWithTag:5] removeFromSuperview];
        CGFloat offsetHeight = 120.0f;
        if([OSHelper iPad] || [OSHelper iPhone4])
        {
            offsetHeight = 80.0f;
        }
        else if([OSHelper iPhone5])
        {
            offsetHeight = 110.0f;
        }
        else if([OSHelper iPhone6])
        {
            offsetHeight = 120.0f;
        }
        else if([OSHelper iPhone6s])
        {
            offsetHeight = 120.0f;
        }
        CGRect rect = CGRectMake(_scrollView.frame.size.width * pageIndex + (_scrollView.frame.size.width - 230) * .5f, _scrollView.frame.size.height - offsetHeight, 230, 50);
        UIButton * finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        finishBtn.frame = rect;
        finishBtn.tag = 5;
        [finishBtn setBackgroundColor:[UIColor clearColor]];
        finishBtn.showsTouchWhenHighlighted = YES;
        [finishBtn addTarget:self action:@selector(finishAction:) forControlEvents:UIControlEventTouchUpInside];
        finishBtn.backgroundColor = [UIColor clearColor];
        [_scrollView addSubview:finishBtn];
        finishBtn = nil;
    }
    
    
}

@end
