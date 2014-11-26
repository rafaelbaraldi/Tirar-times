//
//  PlayerStore.h
//  Tirar times
//
//  Created by RAFAEL BARALDI on 27/10/14.
//  Copyright (c) 2014 RAFAEL BARALDI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlayerStore : NSObject


@property NSMutableArray* allPlayers;
@property NSMutableArray* allTeams;
@property NSMutableArray* allSubstitutes;

@property NSMutableArray* jogadoresQueVaoJogar;

@property NSUserDefaults* BDJogadores;

+(PlayerStore*)sharedStore;

-(NSArray*)allPlayersItems;
-(void)addPlayer:(NSString*)nome;

-(NSArray*)allTeamsItems;

-(void)createTeams:(int)times Maximo:(int)maximo;

-(NSArray*)allSubstitutesItems;
-(void)addSubstitutes:(NSString*)nome;

-(void)removePlayer:(NSString*)nome;

-(void)movePlayerAtIndex:(int)from toIndex:(int)to;

-(void)replacePlayer:(NSString*)old for:(NSString*)new;

@end
