//
//  DRMPokemon.m
//  PokedexObjc
//
//  Created by Dillon McElhinney on 3/8/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

#import "DRMPokemon.h"

@implementation DRMPokemon

#pragma mark - Initializers
- (instancetype)initWithName: (NSString *)name andURL: (NSURL *)url {
    self = [super init];
    if (self != nil && name != nil && url != nil) {
        _name = name;
        _url = url;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary<NSString *,NSString *> *)dictionary {
    NSString *name = dictionary[@"name"];
    NSString *urlString = dictionary[@"url"];
    NSURL *url = [NSURL URLWithString: urlString];
    
    return [self initWithName: name andURL: url];
}

#pragma mark - Utility Methods
/// Fills in a pokemon with the missing details, if they haven't been filled in already
- (void)fillInWithDictionary:(NSDictionary *)dictionary {
    // if there is already an identifier, there is no need to go through all this work again.
    if (self.identifier != nil) { return; }
    
    // Get and set the identifier
    NSString *identifier = dictionary[@"id"];
    _identifier = identifier;
    
    // Get and set the sprite url
    NSString *spriteURLString = dictionary[@"sprites"][@"front_default"];
    NSURL *spriteURL = [NSURL URLWithString: spriteURLString];
    _spriteURL = spriteURL;
    
    
    // Pull out all the ability names
    NSArray *abilityArray = dictionary[@"abilities"];
    NSMutableArray *abilities = [NSMutableArray array];
    
    for (NSDictionary *abilityDictionary in abilityArray) {
        NSString *ability = abilityDictionary[@"ability"][@"name"];
        [abilities addObject: ability];
    }
    
    // Set the abilities array with KVC compliance
    [self willChangeValueForKey:@"abilities"];
    _abilities = abilities;
    [self didChangeValueForKey:@"abilities"];
}

/// Returns a formatted string of the abilites a pokemon has
- (NSString *)abilityString {
    NSString *string = [NSString string];
    for (NSString *ability in self.abilities) {
        string = [string stringByAppendingFormat:@"- %@\n", [ability capitalizedString]];
    }
    return string;
}

@end
