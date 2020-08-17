//
//  LSIPokemonResults.m
//  Pokemon-Objc
//
//  Created by Chad Parker on 8/14/20.
//  Copyright © 2020 Chad Parker. All rights reserved.
//

#import "LSIPokemonResults.h"
#import "LSIPokemon.h"

@implementation LSIPokemonResults

- (instancetype)initWithPokemonArray:(NSArray<LSIPokemon *> *)pokemonArray count:(NSNumber *)count next:(NSString *)next
{
    if (self = [super init]) {
        _pokemonArray = pokemonArray;
        _count = count;
        _next = next;
    }
    return self;
}

- (instancetype)initFromData:(NSData *)data
{
    NSError *jsonError;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];

    if (!dictionary) {
        NSLog(@"Error decoding JSON: %@", jsonError);
    }

    NSNumber *count = dictionary[@"count"];
    if (![count isKindOfClass:NSNumber.class]) return nil;

    NSString *next = dictionary[@"next"];
    if (![next isKindOfClass:NSString.class]) return nil;

    NSArray *results = dictionary[@"results"];
    if (![results isKindOfClass:NSArray.class]) return nil;

    NSMutableArray *pokemonArray = [[NSMutableArray alloc] initWithCapacity:results.count];

    for (NSDictionary *pokemonDictionary in results) {
        if (![pokemonDictionary isKindOfClass:NSDictionary.class]) continue;

        LSIPokemon *pokemon = [[LSIPokemon alloc] initFromDictionary:pokemonDictionary];
        if (pokemon) {
            [pokemonArray addObject:pokemon];
        } else {
            NSLog(@"Unable to parse pokemon dictionary: %@", pokemonDictionary);
        }
    }

    return [self initWithPokemonArray:pokemonArray count:count next:next];
}

@end
