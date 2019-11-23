//
//  MJSPokemonDetailViewController.m
//  Pokedex
//
//  Created by Michael Stoffer on 11/23/19.
//  Copyright © 2019 Michael Stoffer. All rights reserved.
//

#import "MJSPokemonDetailViewController.h"
#import "MJSPokemon.h"

#import "Pokedex-Swift.h"

void *KVOContext = &KVOContext;

@interface MJSPokemonDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *pokemonImage;
@property (weak, nonatomic) IBOutlet UILabel *pokemonName;
@property (weak, nonatomic) IBOutlet UILabel *pokemonId;
@property (weak, nonatomic) IBOutlet UITextView *pokemonAbilities;

@end

@implementation MJSPokemonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [MJSPokemonController.sharedController fillInPokemonDetailsWithPokemon:self.pokemon];
}

- (void)updateViews
{
    if (!self.isViewLoaded || !self.pokemon) { return; }
    
    self.pokemonName.text = self.pokemon.name;
    self.pokemonId.text = [NSString stringWithFormat:@"%d", self.pokemon.id];
    
    self.pokemonAbilities.text = [self.pokemon.abilities componentsJoinedByString:@", "];
    
    
    
    NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:self.pokemon.sprites]];
    self.pokemonImage.image = [[UIImage alloc] initWithData:imageData];
}

- (void)setPokemon:(MJSPokemon *)pokemon
{
    if (_pokemon != pokemon) {
        [_pokemon removeObserver:self forKeyPath:@"name" context:KVOContext];
        [_pokemon removeObserver:self forKeyPath:@"id" context:KVOContext];
        [_pokemon removeObserver:self forKeyPath:@"abilities" context:KVOContext];
        [_pokemon removeObserver:self forKeyPath:@"sprites" context:KVOContext];
        
        _pokemon = pokemon;
        
        [_pokemon addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionInitial context:KVOContext];
        [_pokemon addObserver:self forKeyPath:@"id" options:NSKeyValueObservingOptionInitial context:KVOContext];
        [_pokemon addObserver:self forKeyPath:@"abilities" options:NSKeyValueObservingOptionInitial context:KVOContext];
        [_pokemon addObserver:self forKeyPath:@"sprites" options:NSKeyValueObservingOptionInitial context:KVOContext];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if (context == KVOContext) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateViews];
        });
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
