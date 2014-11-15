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
        allTeams = [[NSMutableArray alloc]init];
        allSubstitutes = [[NSMutableArray alloc]init];
        _jogadoresQueVaoJogar = [[NSMutableArray alloc] init];
        
        _BDJogadores = [NSUserDefaults standardUserDefaults];
        allPlayers = [NSMutableArray arrayWithArray:[_BDJogadores objectForKey:@"jogadores"]];
        
        if(allPlayers == nil){
            allPlayers = [[NSMutableArray alloc]init];
        }
    }
    return self;
}

-(NSArray*)allPlayersItems{
    return allPlayers;
}

-(void)addPlayer:(NSString*)nome{
    [allPlayers addObject:nome];

    [_BDJogadores setObject:allPlayers forKey:@"jogadores"];
    [_BDJogadores synchronize];
}

-(NSArray*)allTeamsItems{
    return allTeams;
}

-(NSArray*)allSubstitutesItems{
    return allSubstitutes;
}
-(void)addSubstitutes:(NSString*)nome{
    [allSubstitutes addObject:nome];
}

-(void)createTeams:(int)times Maximo:(int)maximo{
    
    NSMutableArray* players = [[NSMutableArray alloc]initWithArray:_jogadoresQueVaoJogar copyItems:YES];
    
    [allTeams removeAllObjects];
    [allSubstitutes removeAllObjects];
    
    int countPlayres = (int)[players count];
    if(times == 0 && [_jogadoresQueVaoJogar count] > 0 && maximo != 0){
        times = floor(countPlayres / maximo);
    }
    else if (maximo == 0 && [_jogadoresQueVaoJogar count] > 0 && times != 0){
        maximo = floor(countPlayres / times);
    }
    
    for(int i = 0; i < times; i++){
        [allTeams addObject:[[NSMutableArray alloc]init]];
        
        for(int j = 0; j < maximo; j++){
            if([players count] > 0){
                int randi = arc4random() % [players count];
                [[allTeams objectAtIndex:i]addObject:[players objectAtIndex:randi]];
                [players removeObjectAtIndex:randi];
            }
        }
    }
    if([players count] > 0){
        allSubstitutes = [NSMutableArray arrayWithArray:players];
    }
}

-(void)removePlayer:(NSString *)nome{
    [allPlayers removeObjectIdenticalTo:nome];
}

-(void)movePlayerAtIndex:(int)from toIndex:(int)to{
    if(from == to)
        return;
    
    NSString* p = [allPlayers objectAtIndex:from];
    [allPlayers removeObjectAtIndex:from];
    [allPlayers insertObject:p atIndex:to];
}

-(void)replacePlayer:(NSString *)old for:(NSString *)new{
    NSInteger position = [allPlayers indexOfObjectIdenticalTo:old];
    [allPlayers removeObjectIdenticalTo:old];
    [allPlayers insertObject:new atIndex:position];
}

@end
