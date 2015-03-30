//
//  PageViewController.m
//  AirHealth
//
//  Created by Guilherme Bayma on 3/25/15.
//  Copyright (c) 2015 Guilherme Bayma. All rights reserved.
//

#import "PageViewController.h"

@implementation PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Create the data model
    _Titulos = @[@"-----------\nAir Health\n-----------", @"Página 2",@"Pagina 3",@""];
    _Imagens = @[@"background.png", @"background.png",@"background.png",@""];
    _textos = @[@"Texto página 1",@"Outro texto da página 2",@"Mais um\ntexto\nda página 3",@""];
    
    // Create page view controller
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageViewController.dataSource = self;
    self.pageViewController.delegate = self;
    
    PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL primeiroUso = [defaults boolForKey:@"primeiroUso"];
    if (primeiroUso) {
        UIButton *fecha = [UIButton buttonWithType:UIButtonTypeCustom];
        [fecha addTarget:self action:@selector(fechar) forControlEvents:UIControlEventTouchUpInside];
        fecha.frame = CGRectMake(self.view.bounds.size.width -50, 50, 30, 30);
        [fecha setImage:[UIImage imageNamed:@"cancel-25.png"] forState:UIControlStateNormal];
        [self.view addSubview:fecha];
    }
    
    [self.view setBackgroundColor:[UIColor colorWithRed:187.0/255.0 green:164.0/255.0 blue:124.0/255.0 alpha:1]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (PageContentViewController *)viewControllerAtIndex:(NSUInteger)index {
    if (([self.Titulos count] == 0) || (index >= [self.Titulos count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    //comment
    PageContentViewController *pageContentViewController = [[PageContentViewController alloc] init];
    pageContentViewController.imageFile = self.Imagens[index];
    pageContentViewController.titleText = self.Titulos[index];
    pageContentViewController.textoText = self.textos[index];
    pageContentViewController.pageIndex = index;
    
    return pageContentViewController;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.Titulos count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return [self.Titulos count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return 0;
}

-(void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers {
    PageContentViewController *viewController = [pendingViewControllers objectAtIndex:0];
    if ([viewController pageIndex] == 3) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        BOOL usoInicial = YES;
        [defaults setBool:usoInicial forKey:@"primeiroUso"];
        [defaults synchronize];
        
        //tbc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

-(void) fechar {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end