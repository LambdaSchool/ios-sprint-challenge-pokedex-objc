//
//  DRMPokemon.h
//  PokedexObjc
//
//  Created by Dillon McElhinney on 3/8/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DRMPokemon : NSObject

@property (readonly, copy) NSString *name;
@property (readonly, copy) NSURL *url;
@property (readonly, nullable, copy) NSString *identifier;
@property (readonly, nullable, copy) NSURL *spriteURL;
@property (readonly, nullable, copy) NSArray<NSString *> *abilities;
@property (readonly) NSString *abilityString;

- (instancetype _Nullable)initWithDictionary: (NSDictionary<NSString *, NSString *> *)dictionary;

- (void)fillInWithDictionary: (NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
