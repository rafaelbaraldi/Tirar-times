//
//  PlayerStore.m
//  Tirar times
//
//  Created by RAFAEL BARALDI on 27/10/14.
//  Copyright (c) 2014 RAFAEL BARALDI. All rights reserved.
//

#import "PlayerStore.h"

@implementation PlayerStore

+(PlayerStore*)sharedStore{
    static PlayerStore* sharedStore = nil;
    if(!sharedStore){
        sharedStore = [[super allocWithZone:nil]init];
    }
    return sharedStore;
}

+(id)allocWithZone:(struct _NSZone *)zone{
    return [self sharedStore];
}

-(id)init{
    self = [super init];
    if(self){
        _allTeams = [[NSMutableArray alloc]init];
        _allSubstitutes = [[NSMutableArray alloc]init];
        _jogadoresQueVaoJogar = [[NSMutableArray alloc] init];
        
        _BDJogadores = [NSUserDefaults standardUserDefaults];
        _allPlayers = [[_BDJogadores objectForKey:@"jogadores"] mutableCopy];
        
        if(_allPlayers == nil){
            _allPlayers = [[NSMutableArray alloc]init];
        }
    }
    return self;
}

-(NSArray*)allPlayersItems{
    return _allPlayers;
}

-(void)addPlayer:(NSString*)nome{
    
    [_allPlayers addObject:nome];


    [_BDJogadores setObject:_allPlayers forKey:@"jogadores"];
    [_BDJogadores synchronize];
}

-(NSArray*)allTeamsItems{
    return _allTeams;
}

-(NSArray*)allSubstitutesItems{
    return _allSubstitutes;
}
-(void)addSubstitutes:(NSString*)nome{
    [_allSubstitutes addObject:nome];
}

-(void)createTeams:(int)times Maximo:(int)maximo{
    
    NSMutableArray* players = [[NSMutableArray alloc]initWithArray:_jogadoresQueVaoJogar copyItems:YES];
    
    [_allTeams removeAllObjects];
    [_allSubstitutes removeAllObjects];
    
    int countPlayres = (int)[players count];
    if(times == 0 && [_jogadoresQueVaoJogar count] > 0 && maximo != 0){
        times = floor(countPlayres / maximo);
    }
    else if (maximo == 0 && [_jogadoresQueVaoJogar count] > 0 && times != 0){
        maximo = floor(countPlayres / times);
    }
    
    for(int i = 0; i < times; i++){
        [_allTeams addObject:[[NSMutableArray alloc]init]];
        
        for(int j = 0; j < maximo; j++){
            if([players count] > 0){
                int randi = arc4random() % [players count];
                [[_allTeams objectAtIndex:i]addObject:[players objectAtIndex:randi]];
                [players removeObjectAtIndex:randi];
            }
        }
    }
    if([players count] > 0){
        _allSubstitutes = [NSMutableArray arrayWithArray:players];
    }
}

-(void)removePlayer:(NSString *)nome{
    [_allPlayers removeObjectIdenticalTo:nome];
}

-(void)movePlayerAtIndex:(int)from toIndex:(int)to{
    if(from == to)
        return;
    
    NSString* p = [_allPlayers objectAtIndex:from];
    [_allPlayers removeObjectAtIndex:from];
    [_allPlayers insertObject:p atIndex:to];
}

-(void)replacePlayer:(NSString *)old for:(NSString *)new{
    NSInteger position = [_allPlayers indexOfObjectIdenticalTo:old];
    [_allPlayers removeObjectIdenticalTo:old];
    [_allPlayers insertObject:new atIndex:position];
}

@end
