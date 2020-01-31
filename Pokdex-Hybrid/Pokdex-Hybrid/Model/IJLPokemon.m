//
//  IJLPokemon.m
//  Pokdex-Hybrid
//
//  Created by Isaac Lyons on 12/20/19.
//  Copyright © 2019 Isaac Lyons. All rights reserved.
//

#import "IJLPokemon.h"

@interface IJLPokemon()

@property (nonatomic, nullable, readwrite) NSURL *spriteURL;
@property (nonatomic, nullable, readwrite) NSURL *shinySpriteURL;
@property (nonatomic, nullable, readwrite) NSArray<NSString *> *abilities;

@end

@implementation IJLPokemon

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        _name = name;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    NSString *name = dictionary[@"name"];
    
    if (!name) {
        return nil;
    }
    
    return [self initWithName:name];
}

- (void)updateFromDictionary:(NSDictionary *)dictionary {
    NSArray *abilitiesArray = dictionary[@"abilities"];
    
    NSNumber *identifier = dictionary[@"id"];
    
    NSString *spriteString = dictionary[@"sprites"][@"front_default"];
    NSURL *spriteURL = [NSURL URLWithString:spriteString];
    
    NSString *shinySpriteString = dictionary[@"sprites"][@"front_shiny"];
    NSURL *shinySpriteURL = [NSURL URLWithString:shinySpriteString];
    
    if (abilitiesArray) {
        NSMutableArray *abilities = [[NSMutableArray alloc] init];
        for (NSDictionary *dictionary in abilitiesArray) {
            NSString *abilityName = dictionary[@"ability"][@"name"];
            if (abilityName) {
                [abilities addObject:abilityName];
            }
        }
        self.abilities = abilities;
    }
    
    if (identifier) {
        self.identifier = [identifier intValue];
    }
    
    if (spriteURL) {
        self.spriteURL = spriteURL;
    }
    
    if (shinySpriteURL) {
        self.shinySpriteURL = shinySpriteURL;
    }
}

@end
