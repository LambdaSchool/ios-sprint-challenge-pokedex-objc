//
//  PokedexTableViewController.m
//  Pokedex-objc
//
//  Created by Matthew Martindale on 8/16/20.
//  Copyright © 2020 Matthew Martindale. All rights reserved.
//

#import "PokedexTableViewController.h"
#import "Pokedex_objc-Swift.h"
#import "MKMPokemon.h"

@interface PokedexTableViewController ()

@end

@implementation PokedexTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [MKMPokemonAPI.sharedController fetchAllPokemon:^(NSArray<MKMPokemon *> *pokemons, NSError *error) {
        for (MKMPokemon *pokemon in pokemons) {
            NSLog(@"Pokemon Names: %@, url: %@", pokemon.name, pokemon.url);
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokemons.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

@end
