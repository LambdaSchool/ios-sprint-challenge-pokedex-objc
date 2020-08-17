//
//  LSIPokemon.h
//  Pokemon-Objc
//
//  Created by Chad Parker on 8/14/20.
//  Copyright © 2020 Chad Parker. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSIPokemon : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *urlString;
@property (nonatomic, nullable) NSNumber *identifier;
@property (nonatomic, nullable) NSString *spriteURLString;
@property (nonatomic) NSMutableArray<NSString *> *abilities;

- (instancetype)initWithName:(NSString *)name url:(NSString *)urlString;
- (nullable instancetype)initFromDictionary:(NSDictionary *)dictionary;

- (BOOL)updateWithDetailsData:(NSData *)data;

@end

NS_ASSUME_NONNULL_END
