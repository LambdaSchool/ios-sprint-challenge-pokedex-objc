//
//  PokemonDetailViewController.h
//  Pokedex-objc
//
//  Created by Simon Elhoej Steinmejer on 10/12/18.
//  Copyright © 2018 Simon Elhoej Steinmejer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pokedex_objc-Swift.h"

NS_ASSUME_NONNULL_BEGIN

@class VUKPokemon;
@class PokemonController;

@interface PokemonDetailViewController : UIViewController

@property (nonatomic, nullable) VUKPokemon *pokemon;

@end

NS_ASSUME_NONNULL_END
