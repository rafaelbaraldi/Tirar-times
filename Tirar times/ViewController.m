//
//  ViewController.m
//  Tirar times
//
//  Created by RAFAEL BARALDI on 27/10/14.
//  Copyright (c) 2014 RAFAEL BARALDI. All rights reserved.
//

#import "ViewController.h"
#import "PlayerStore.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [[PlayerStore sharedStore] addPlayer:@"asfaf"];
    [[PlayerStore sharedStore] addPlayer:@"agasgasdg"];
    [[PlayerStore sharedStore] addPlayer:@"aagdad"];
    [[PlayerStore sharedStore] addPlayer:@"dgjhdgjdgjf"];
    [[PlayerStore sharedStore] addPlayer:@"pmonknl"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
    UILabel* labelNome;
    UIImageView* imagemSelecionado;
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
        cell.backgroundColor = [UIColor greenColor];
        
        labelNome = [[UILabel alloc] initWithFrame:CGRectMake(40, 15, 270, 20)];
        labelNome.tag = 1;
        [cell addSubview:labelNome];
        
        
        imagemSelecionado = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 15, 15)];
        imagemSelecionado.tag = 2;
        [cell addSubview:imagemSelecionado];
    }
    else{
        labelNome = (UILabel*)[cell viewWithTag:1];
        imagemSelecionado = (UIImageView*)[cell viewWithTag:2];
    }
    
    labelNome.text = [[[PlayerStore sharedStore] allPlayersItems] objectAtIndex:indexPath.row];
    
    if ([[[PlayerStore sharedStore] jogadoresQueVaoJogar] containsObject:[[[PlayerStore sharedStore] allPlayersItems] objectAtIndex:indexPath.row]]) {
        imagemSelecionado.image = [UIImage imageNamed:@"selecionado.png"];
    }
    else{
        imagemSelecionado.image = [UIImage imageNamed:@"deselecionado.png"];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([[[PlayerStore sharedStore] jogadoresQueVaoJogar] containsObject:[[[PlayerStore sharedStore] allPlayersItems] objectAtIndex:indexPath.row]]) {
        [[[PlayerStore sharedStore] jogadoresQueVaoJogar] removeObject:[[[PlayerStore sharedStore] allPlayersItems] objectAtIndex:indexPath.row]];
    }
    else{
        [[[PlayerStore sharedStore] jogadoresQueVaoJogar] addObject:[[[PlayerStore sharedStore] allPlayersItems] objectAtIndex:indexPath.row]];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[[PlayerStore sharedStore] allPlayersItems] count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

@end
