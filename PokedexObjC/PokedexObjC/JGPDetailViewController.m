//
//  JGPDetailViewController.m
//  PokedexObjC
//
//  Created by John Pitts on 7/26/19.
//  Copyright © 2019 johnpitts. All rights reserved.
//

#import "JGPDetailViewController.h"
#import "PokedexObjC-Swift.h"          // gives us access to swift file PokemonAPIController, i THINK!
#import "JGPPokemon.h"

@interface JGPDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UITextView *abilitiesTextView;

// don't forget to convert url or string to UIImage
@property (weak, nonatomic) IBOutlet UIImageView *spriteImageView;


@end

@implementation JGPDetailViewController

- (void)setPokemon:(JGPPokemon *)artist {               //i had a mispelling SetAarrsk or something, run again
    if (pokemon != _pokemon) {
        _pokemon = pokemon;
        
        [self updateViews];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // [pokemonAPIController.fillInDetails pokemonName ... completion
    
//    [[JGPPokemonAPIController sharedController] fillInDetailsFor:pokemon.name {    NO COMPLETION MEANS MUST USE OBSERVER!
//        
//        // OBSERVE when pokemon info is fetched inside th network call, and implement...
//                                                          
//                                                          
//        NSLog(@"Results: %@", pokemon.name);
//        
//        self.pokemon = pokemon;
//    }];
    
    
    [self updateViews]; //to load the data into DetailVC
    
    
}

- (void)updateViews {
    
    //self.nameLabel.text = self.pokemon.name;
    //self.idLabel.text = [NSString stringWithFormat:@"%@", [NSString stringWithFormat:@"%d", self.pokemon.identifier]];
    // abilities here... save for last
    
}



@end
