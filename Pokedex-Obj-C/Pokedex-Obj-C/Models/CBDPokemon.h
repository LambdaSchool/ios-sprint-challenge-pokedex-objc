//
//  CBDPokemon.h
//  Pokedex-Obj-C
//
//  Created by Christopher Devito on 5/22/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
NS_SWIFT_NAME(Pokemon)
@interface CBDPokemon : NSObject

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSNumber *identifier;
@property (nonatomic, readonly) NSString *spritURL;
@property (nonatomic, readonly) NSArray<NSString *> *abilities;

- (instancetype)initWithName:(NSString *)name
                  identifier:(NSNumber *)identifier
                   spriteURL:(NSString *)spriteURL
                   abilities:(NSArray<NSString *> *)abilities;

@end

NS_ASSUME_NONNULL_END
