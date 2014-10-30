//
//  TimesViewController.h
//  Tirar times
//
//  Created by RAFAEL BARALDI on 27/10/14.
//  Copyright (c) 2014 RAFAEL BARALDI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField *txtNumeroJogadores;
@property (strong, nonatomic) IBOutlet UITextField *txtNumeroTimes;
@property (strong, nonatomic) IBOutlet UITableView *tbTimes;

- (IBAction)btnSortearClick:(id)sender;
- (IBAction)fecharNumeroTimes:(id)sender;
- (IBAction)fecharNumeroJogadores:(id)sender;

@end
