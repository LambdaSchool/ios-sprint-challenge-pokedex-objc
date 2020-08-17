//
//  LSIPokemonResults.h
//  Pokemon-Objc
//
//  Created by Chad Parker on 8/14/20.
//  Copyright © 2020 Chad Parker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSIPokemon.h"

NS_ASSUME_NONNULL_BEGIN

@interface LSIPokemonResults : NSObject

@property (nonatomic) NSNumber *count;
@property (nonatomic, copy) NSString *next;
@property (nonatomic, copy) NSArray<LSIPokemon *> *pokemonArray;

- (instancetype)initWithPokemonArray:(NSArray<LSIPokemon *> *)pokemonArray count:(NSNumber *)count next:(NSString *)next;
- (nullable instancetype)initFromData:(NSData *)data;

@end

NS_ASSUME_NONNULL_END
