
//
//  DLJDetailViewController.m
//  ObjcPokemon
//
//  Created by Diante Lewis-Jolley on 7/26/19.
//  Copyright © 2019 Diante Lewis-Jolley. All rights reserved.
//

#import "DLJDetailViewController.h"
#import "ObjcPokemon-Swift.h"
#import "DLJPokemon.h"

@interface DLJDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *abilityLabel;


@end

@implementation DLJDetailViewController

void *KVOContext = &KVOContext;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    if (self.pokemon) {

        [self.pokemon addObserver:self forKeyPath:@"abilities" options:NSKeyValueObservingOptionInitial context:KVOContext];
    }
    [PokemonController.shared fillInDetailsFor:self.pokemon];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self updateViews];
}

-(void)updateViews {

    if (self.pokemon) {
        self.nameLabel.text = self.pokemon.name;
        self.idLabel.text = [NSString stringWithFormat:@"%@", self.pokemon.pokemonID];
        self.abilityLabel.text = [self.pokemon.abilities componentsJoinedByString:@","];
        self.title = [self.pokemon.name capitalizedString];
        NSURL *spriteURL = [NSURL URLWithString:self.pokemon.sprite];
        NSData *spriteData = [NSData dataWithContentsOfURL:spriteURL];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = [UIImage imageWithData:spriteData];
        });
    }
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {

    if (context == KVOContext) {
        if ([keyPath isEqualToString:@"abilities"]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self updateViews];
            });
        } else {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }

}

-(void)dealloc {
    [self.pokemon removeObserver:self forKeyPath:@"abilities"];
}



@end
