//
//  PageViewController.m
//  AirHealth
//
//  Created by Guilherme Bayma on 3/25/15.
//  Copyright (c) 2015 Guilherme Bayma. All rights reserved.
//

#import "PageViewController.h"

@implementation PageViewController {
    BOOL primeiroUso;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Create the data model
    _imagensPrimeiro = @[@"cloudLogo.png", @"cloud1.png",@"cloud2.png",@"cloud3.png",@"cloud4.png",@"cloud5.png",@""];
    _imagens = @[@"cloudLogo.png", @"cloud1.png",@"cloud2.png",@"cloud3.png",@"cloud4.png",@"cloud5.png"];
    _titulos = @[@"",@"Um único App",@"Suas informações criptografadas",@"Conforto e praticidade",@"Agilidade e versatilidade",@"Atualize suas informações"];
    _textos = @[@"",@"O AirHealth guarda seus dados médicos e pessoais para você.",@"Ao toque de um botão seus dados são enviados para um servidor de forma segura.",@"Ao sincronizar seus dados você recebe uma senha única.",@"Utilize sua senha para ser atendido em instituições de saúde cadastradas.",@"Insira seus dados para agilizar seu atendimento no aplicativo ou no aplicativo Saúde."];
    
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
    primeiroUso = [defaults boolForKey:@"primeiroUso"];
    if (primeiroUso) {
        UIButton *fecha = [UIButton buttonWithType:UIButtonTypeCustom];
        [fecha addTarget:self action:@selector(fechar) forControlEvents:UIControlEventTouchUpInside];
        fecha.frame = CGRectMake(self.view.bounds.size.width -80, 35, 44, 44);
        [fecha setImage:[UIImage imageNamed:@"close-100.png"] forState:UIControlStateNormal];
        [self.view addSubview:fecha];
    }
    
    UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.pageIndicatorTintColor = [UIColor colorWithRed:4.0/255.0 green:134.0/255.0 blue:149.0/255.0 alpha:1];
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    pageControl.backgroundColor = [UIColor colorWithRed:73.0/255.0 green:199.0/255.0 blue:167.0/255.0 alpha:1];
    
    [self.view setBackgroundColor:[UIColor colorWithRed:73.0/255.0 green:199.0/255.0 blue:167.0/255.0 alpha:1]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (PageContentViewController *)viewControllerAtIndex:(NSUInteger)index {
    if (index == 6) {
        PageContentViewController *pcvc = [[PageContentViewController alloc] init];
        pcvc.imageFile = @"";
        pcvc.tituloTexto = @"";
        pcvc.textoTexto = @"";
        pcvc.pageIndex = index;
        return pcvc;
    }
    if (([self.imagens count] == 0) || (index >= [self.imagens count])) {
        return nil;
    }
    PageContentViewController *pageContentViewController = [[PageContentViewController alloc] init];
    pageContentViewController.imageFile = self.imagens[index];
    pageContentViewController.tituloTexto = self.titulos[index];
    pageContentViewController.textoTexto = self.textos[index];
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
    if (index == [self.imagensPrimeiro count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    if (primeiroUso) {
        return [self.imagens count];
    }
    return [self.imagensPrimeiro count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return 0;
}

-(void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers {
    PageContentViewController *viewController = [pendingViewControllers objectAtIndex:0];
    if ([viewController pageIndex] == 6) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        BOOL usoInicial = YES;
        [defaults setBool:usoInicial forKey:@"primeiroUso"];
        [defaults synchronize];
        
        //tbc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PedirPermissaoHealthKit" object:nil];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

-(void) fechar {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end