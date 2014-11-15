//
//  TimesViewController.m
//  Tirar times
//
//  Created by RAFAEL BARALDI on 27/10/14.
//  Copyright (c) 2014 RAFAEL BARALDI. All rights reserved.
//

#import "TimesViewController.h"

#import "PlayerStore.h"

@interface TimesViewController ()

@end

@implementation TimesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    _tbTimes.backgroundColor = [UIColor clearColor];
    _tbTimes.separatorColor = [UIColor whiteColor];
    _tbTimes.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toque)];
    [_tbTimes addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if([[[PlayerStore sharedStore]allSubstitutesItems]count] > 0){
        return [[[PlayerStore sharedStore]allTeamsItems]count] + 1;
    }
    else{
        return [[[PlayerStore sharedStore]allTeamsItems]count];
    }
}

-(void)toque{
    
    [_txtNumeroTimes resignFirstResponder];
    [_txtNumeroJogadores resignFirstResponder];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self toque];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if([[[PlayerStore sharedStore]allSubstitutesItems]count] > 0 && section == [[[PlayerStore sharedStore]allTeamsItems]count]){
        return [[[PlayerStore sharedStore]allSubstitutesItems]count];
    }
    else{
        return [[[[PlayerStore sharedStore]allTeamsItems]objectAtIndex:section]count];
    }
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 44)];
    headerView.backgroundColor = [UIColor colorWithRed:0.122 green:0.278 blue:0.533 alpha:1];
    
    UILabel *text = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 22)];
    if([[[PlayerStore sharedStore]allSubstitutesItems]count] > 0 && section == [[[PlayerStore sharedStore]allTeamsItems]count]){
         text.text = @"Jogadores de proximo";
    }
    else{
        text.text = [NSString stringWithFormat:@"Time %d", section + 1];
    }
    
    text.textColor = [UIColor whiteColor];
    
    [headerView addSubview:text];
    
    return headerView;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
        cell.backgroundColor = [UIColor clearColor];
    }

    NSString* p = @"";
    if([[[PlayerStore sharedStore]allSubstitutesItems]count] > 0 && [indexPath section] == [[[PlayerStore sharedStore]allTeamsItems]count]){
        p = [[[PlayerStore sharedStore]allSubstitutesItems]objectAtIndex:[indexPath row]];
    }
    else{
        p = [[[[PlayerStore sharedStore]allTeamsItems]objectAtIndex:[indexPath section]]objectAtIndex:[indexPath row]];
    }
    
    cell.textLabel.textColor = [UIColor colorWithRed:0.122 green:0.278 blue:0.533 alpha:1];
    [[cell textLabel]setText:p];
    
    return cell;
}

- (IBAction)btnSortearClick:(id)sender {
    
    if(_txtNumeroJogadores.text.length != 0 || _txtNumeroTimes.text.length != 0){
    
        [[PlayerStore sharedStore]createTeams:[self.txtNumeroTimes.text intValue] Maximo:[self.txtNumeroJogadores.text intValue]];
        
        [_tbTimes reloadData];
    }
}

- (IBAction)fecharNumeroTimes:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)fecharNumeroJogadores:(id)sender {
    [sender resignFirstResponder];
}
@end
