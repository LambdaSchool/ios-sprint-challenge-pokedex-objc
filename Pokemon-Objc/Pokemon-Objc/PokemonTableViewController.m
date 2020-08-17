//
//  PokemonTableViewController.m
//  Pokemon-Objc
//
//  Created by Chad Parker on 8/14/20.
//  Copyright © 2020 Chad Parker. All rights reserved.
//

#import "PokemonTableViewController.h"
#import "Pokemon_Objc-Swift.h"
#import "LSIPokemon.h"
#import "PokemonDetailViewController.h"

@interface PokemonTableViewController ()

@property (nonatomic) NSMutableArray<LSIPokemon *> *pokemonArray;

@end

@implementation PokemonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pokemonArray = [[NSMutableArray alloc] init];
    
    [PokemonAPI.sharedController fetchAllPokemonWithCompletion:^(NSArray<LSIPokemon *> *pokemonArray, NSError *error) {
        self.pokemonArray = [pokemonArray mutableCopy];
        [self.tableView reloadData];
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokemonArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    
    LSIPokemon *pokemon = self.pokemonArray[indexPath.row];
    cell.textLabel.text = [pokemon.name capitalizedString];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PokemonDetailSegue"]) {
        PokemonDetailViewController *detailVC = segue.destinationViewController;
        NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
        detailVC.pokemon = self.pokemonArray[selectedIndexPath.row];
    }
}

@end
