//
//  DRMPokedexTableViewController.m
//  PokedexObjc
//
//  Created by Dillon McElhinney on 3/8/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

#import "DRMPokedexTableViewController.h"
#import "DRMPokemon.h"
#import "PokedexObjc-Swift.h"
#import "DRMPokemonDetailViewController.h"

@interface DRMPokedexTableViewController ()

@property NSArray<DRMPokemon *> *pokemons;

@end

@implementation DRMPokedexTableViewController

#pragma mark - Lifecycle Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    self.pokemons = [NSArray array];
    
    [PokemonAPI.shared fetchAllPokemonWithCompletion:^(NSArray<DRMPokemon *> * _Nullable pokemons, NSError * _Nullable error) {
        self.pokemons = pokemons;
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

#pragma mark - Table View Data Source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokemons.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    DRMPokemon *pokemon = self.pokemons[indexPath.row];
    
    [cell.textLabel setText:[pokemon.name capitalizedString]];
    
    return cell;
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DRMPokemonDetailViewController *destinationVC = segue.destinationViewController;
    NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
    DRMPokemon *pokemon = self.pokemons[indexPath.row];
    [PokemonAPI.shared fillInDetailsFor: pokemon];
    destinationVC.pokemon = pokemon;
}

@end
