//
//  DRMPokemonDetailViewController.m
//  PokedexObjc
//
//  Created by Dillon McElhinney on 3/8/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

#import "DRMPokemonDetailViewController.h"

@interface DRMPokemonDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *pokemonImageView;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *abilityLabel;

@end

@implementation DRMPokemonDetailViewController

#pragma mark - Lifecycle Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self updateViews];
    
    // Only add an observer if there is something worth observing
    if (self.pokemon.identifier == nil) {
        [self.pokemon addObserver: self forKeyPath: @"abilities" options: 0 context: nil];
    }
}

#pragma mark - Utility Methods
- (void)updateViews {
    if (self.pokemon != nil) {
        self.title = [self.pokemon.name capitalizedString];
        
        self.idLabel.text = [NSString stringWithFormat:@"ID: %@", (self.pokemon.identifier == nil) ? @"" : self.pokemon.identifier];
        self.abilityLabel.text = [NSString stringWithFormat:@"Abilities:\n%@", self.pokemon.abilityString];
        
        if (self.pokemon.spriteURL != nil) {
            NSData *imageData = [NSData dataWithContentsOfURL: self.pokemon.spriteURL];
            UIImage *image = [UIImage imageWithData: imageData];
            self.pokemonImageView.image = image;
        }
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    dispatch_sync(dispatch_get_main_queue(), ^{
        [self updateViews];
    });
    // Remove the observer when it has done its job
    [object removeObserver:self forKeyPath:keyPath];
}

@end
