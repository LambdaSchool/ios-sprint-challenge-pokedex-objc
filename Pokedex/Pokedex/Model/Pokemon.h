//
//  Pokemon.h
//  Pokedex
//
//  Created by Cora Jacobson on 12/12/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Pokemon : NSObject

@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, nullable) NSNumber *identifier;
@property (nonatomic, copy, nullable) NSString *abilities;
@property (nonatomic, copy) NSString *spriteURL;

- (instancetype)initWithName:(NSString *)name;

- (void)updateWithIdentifier:(NSNumber *)anID
                   abilities:(NSString *)someAbilities
                   spriteURL:(NSString *)aURL;

@end

NS_ASSUME_NONNULL_END
