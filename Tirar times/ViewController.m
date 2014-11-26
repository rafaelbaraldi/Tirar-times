//
//  ViewController.m
//  Tirar times
//
//  Created by RAFAEL BARALDI on 27/10/14.
//  Copyright (c) 2014 RAFAEL BARALDI. All rights reserved.
//

#import "ViewController.h"
#import "PlayerStore.h"
#import "MeuBotao.h"
#import "MeuTextField.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    _tbJogadores.backgroundColor = [UIColor clearColor];
    _tbJogadores.separatorColor = [UIColor whiteColor];
    _tbJogadores.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
//    _tbJogadores.editing = YES;
    
    _buttonItemOpcoes = [[UIBarButtonItem alloc] initWithTitle:@"Editar" style:UIBarButtonItemStylePlain target:self action:@selector(editarJogadores)];
    _buttonItemOpcoes.tintColor = [UIColor whiteColor];
    [[self navigationItem] setRightBarButtonItem:_buttonItemOpcoes animated:YES];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

-(void)editarJogadores{
    
    if(_tbJogadores.editing){
        _tbJogadores.editing = NO;
        _buttonItemOpcoes.title = @"Editar";
        
//        for (int i = 0; i < [[[PlayerStore sharedStore] jogadoresQueVaoJogar] count]; i++) {
//            UITableViewCell* cell = [_tbJogadores cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:1]];
//            MeuTextField* text = (MeuTextField*)[cell viewWithTag:1];
//            text.enabled = YES;
//        }
    }
    else{
        _tbJogadores.editing = YES;
        _buttonItemOpcoes.title = @"Pronto";
//        for (int i = 0; i < [[[PlayerStore sharedStore] jogadoresQueVaoJogar] count]; i++) {
//            UITableViewCell* cell = [_tbJogadores cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:1]];
//            MeuTextField* text = (MeuTextField*)[cell viewWithTag:1];
//            text.enabled = NO;
//        }
    }
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    
    int i = (int)destinationIndexPath.row;
    int j = (int)sourceIndexPath.row;
    
    [[PlayerStore sharedStore]movePlayerAtIndex:j toIndex:i];
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    MeuTextField* labelNome;
    UIImageView* imagemSelecionado;
    MeuBotao* btnEditar;
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
        cell.backgroundColor = [UIColor clearColor];
        
        //Nome do Jogador
        labelNome = [[MeuTextField alloc] initWithFrame:CGRectMake(40, 11, 200, 20)];
        labelNome.tag = 1;
        labelNome.textColor = [UIColor colorWithRed:0.122 green:0.278 blue:0.533 alpha:1];
        labelNome.enabled = NO;
        labelNome.delegate = self;
        labelNome.index = indexPath;
        [labelNome addTarget:self action:@selector(fecharTextField:) forControlEvents:UIControlEventEditingDidEndOnExit];
        [cell addSubview:labelNome];
        
        //Imagem Selecionar
        imagemSelecionado = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 15, 15)];
        imagemSelecionado.tag = 2;
        [cell addSubview:imagemSelecionado];
        
        //Botao editar
        btnEditar = [[MeuBotao alloc] initWithFrame:CGRectMake(245, 11, 60, 20)];
        [btnEditar setTitle:@"Editar" forState:UIControlStateNormal];
        btnEditar.tag = 3;
        btnEditar.index = indexPath;
        [btnEditar addTarget:self action:@selector(editarNome:) forControlEvents:UIControlEventTouchUpInside];
//        [cell addSubview:btnEditar];
    }
    else{
        labelNome = (MeuTextField*)[cell viewWithTag:1];
        imagemSelecionado = (UIImageView*)[cell viewWithTag:2];
        btnEditar = (MeuBotao*)[cell viewWithTag:3];
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

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    [self fecharTextField:(MeuTextField*)textField];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    _textoInicial = textField.text;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    [_textoDaLinha setEnabled:YES];
    [_textoDaLinha becomeFirstResponder];
}

-(void)fecharTextField:(MeuTextField*)sender{
    
    if([[[PlayerStore sharedStore] allPlayersItems] containsObject:sender.text]){
        if (![_textoInicial isEqualToString:sender.text]) {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"ERRO" message:@"Esse jogador já existe" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }
    else{
        if ([[[PlayerStore sharedStore] jogadoresQueVaoJogar] containsObject:[[[PlayerStore sharedStore] allPlayersItems] objectAtIndex:sender.index.row]]) {
            NSUInteger index = [[[PlayerStore sharedStore] jogadoresQueVaoJogar] indexOfObject:[[[PlayerStore sharedStore] allPlayersItems] objectAtIndex:sender.index.row]];
            [[[PlayerStore sharedStore] jogadoresQueVaoJogar] replaceObjectAtIndex:index withObject:sender.text];
        }
    
        [[PlayerStore sharedStore] replacePlayer:[[[PlayerStore sharedStore] allPlayersItems] objectAtIndex:sender.index.row] for:sender.text];
    
        [sender resignFirstResponder];
    }
    
    
//    sender.enabled = NO;
}

-(void)editarNome:(MeuBotao*)sender{
    NSIndexPath* index = sender.index;
    
    UITableViewCell* cell = [_tbJogadores cellForRowAtIndexPath:index];
    
    MeuTextField* text = (MeuTextField*)[cell viewWithTag:1];
//    text.enabled = YES;
    
    _textoDaLinha = text;
    
    [text becomeFirstResponder];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([[[PlayerStore sharedStore] jogadoresQueVaoJogar] containsObject:[[[PlayerStore sharedStore] allPlayersItems] objectAtIndex:indexPath.row]]) {
        [[[PlayerStore sharedStore] jogadoresQueVaoJogar] removeObject:[[[PlayerStore sharedStore] allPlayersItems] objectAtIndex:indexPath.row]];
    }
    else{
        [[[PlayerStore sharedStore] jogadoresQueVaoJogar] addObject:[[[PlayerStore sharedStore] allPlayersItems] objectAtIndex:indexPath.row]];
    }

    [tableView reloadData];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        PlayerStore* ps = [PlayerStore sharedStore];
        NSArray* items = [ps allPlayersItems];
        NSString* p = [items objectAtIndex:[indexPath row]];
        [ps removePlayer:p];
        
        [[[PlayerStore sharedStore] BDJogadores] removeObjectForKey:p];
        [[[PlayerStore sharedStore] BDJogadores] synchronize];
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[[PlayerStore sharedStore] allPlayersItems] count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (IBAction)btnTirarTimesClick:(id)sender {
}

- (IBAction)txtAdicionar:(id)sender {
    
    [sender resignFirstResponder];
    
    UITextField* text = (UITextField*)sender;

    if ([text.text length] > 0 ) {
        
        if([[[PlayerStore sharedStore] allPlayersItems] containsObject:text.text]){
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"ERRO" message:@"Esse jogador já existe" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        else{
            
            NSString* jogador = text.text;
            
            [[PlayerStore sharedStore] addPlayer:jogador];
            [_tbJogadores reloadData];
        }
    }
    
    text.text = @"";
}
@end
