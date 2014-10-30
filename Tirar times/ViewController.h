//
//  ViewController.h
//  Tirar times
//
//  Created by RAFAEL BARALDI on 27/10/14.
//  Copyright (c) 2014 RAFAEL BARALDI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MeuTextField.h"

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate, UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tbJogadores;
@property (strong, nonatomic) IBOutlet UIButton *btnTirarTimes;

- (IBAction)btnTirarTimesClick:(id)sender;

- (IBAction)txtAdicionar:(id)sender;

@property MeuTextField* textoDaLinha;
@property NSString* textoInicial;

@property UIBarButtonItem *buttonItemOpcoes;

@end
