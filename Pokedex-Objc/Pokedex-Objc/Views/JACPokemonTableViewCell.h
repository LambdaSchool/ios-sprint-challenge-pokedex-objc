//
//  JACPokemonTableViewCell.h
//  Pokedex-Objc
//
//  Created by Jordan Christensen on 3/28/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JACPokemon;
@class PokemonController;
NS_ASSUME_NONNULL_BEGIN

@interface JACPokemonTableViewCell : UITableViewCell
@property PokemonController *controller;

- (void)setUpCellWithPokemon:(JACPokemon *)pokemon;
@end

NS_ASSUME_NONNULL_END
