//
//  MBPokemon.h
//  PokedexObjC
//
//  Created by Mitchell Budge on 7/26/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(Pokemon)
@interface MBPokemon : NSObject

@property (nonatomic, copy, readwrite) NSString *name;
@property (nonatomic, copy, readwrite, nullable) NSURL *sprite;
@property (nonatomic, copy, readwrite, nullable) NSNumber *idNumber;
@property (nonatomic, copy, readwrite, nullable) NSArray<NSString *> *abilities;

-(instancetype)initWithName:(NSString *)name sprite:(NSURL *)sprite idNumber:(NSNumber *)idNumber abilities:(NSArray *)abilities;
-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
