//
//  CBDPokemonShort.h
//  Pokedex-Obj-C
//
//  Created by Christopher Devito on 5/22/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
NS_SWIFT_NAME(PokemonShort)
@interface CBDPokemonShort : NSObject
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *url;

- (instancetype)initWithName:(NSString *)name
                         url:(NSString *)url;
@end

NS_ASSUME_NONNULL_END
