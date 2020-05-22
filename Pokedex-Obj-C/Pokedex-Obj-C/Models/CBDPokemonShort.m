//
//  CBDPokemonShort.m
//  Pokedex-Obj-C
//
//  Created by Christopher Devito on 5/22/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

#import "CBDPokemonShort.h"

@implementation CBDPokemonShort

- (instancetype)initWithName:(NSString *)name
                         url:(NSString *)url {
    self = [super init];
    if (!self) { return nil; }
    _name = name;
    _url = url;
    return self;
}

@end
