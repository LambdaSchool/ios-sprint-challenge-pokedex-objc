//
//  ABCPokemonTableViewController.m
//  PokedexObjC
//
//  Created by Austin Cole on 3/8/19.
//  Copyright © 2019 Austin Cole. All rights reserved.
//

#import "ABCPokemonTableViewController.h"
#import "PokedexObjC-Swift.h"
#import "ABCPokemonDetailViewController.h"

@interface ABCPokemonTableViewController ()

@property NSArray *pokemonArray;
@property PokemonController *pokemonController;

@end

@implementation ABCPokemonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _pokemonController = [[PokemonController alloc] init];
    [_pokemonController fetchAllPokemonWithCompletion:^(NSArray<ABCPokemon *> *pokemon, NSError *error) {
        if (error != nil) {
            NSLog(@"Error performing fetch request: %@", error);
            return;
        }
        if (pokemon != nil) {
            self->_pokemonArray = pokemon;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [[self tableView] reloadData];
        });
        
        // Uncomment the following line to preserve selection between presentations.
        // self.clearsSelectionOnViewWillAppear = NO;
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    }];
     }
     
#pragma mark - Table view data source
     
     - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
         return 1;
     }
     
     - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
         return _pokemonArray.count;
     }
     
     
     - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
         UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
         
         cell.textLabel.text = [[_pokemonArray objectAtIndex:indexPath.row] name];
         
         return cell;
     }
     
     
    /*
     // Override to support conditional editing of the table view.
     - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
     // Return NO if you do not want the specified item to be editable.
     return YES;
     }
     */
     
    /*
     // Override to support editing the table view.
     - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
     if (editingStyle == UITableViewCellEditingStyleDelete) {
     // Delete the row from the data source
     [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
     } else if (editingStyle == UITableViewCellEditingStyleInsert) {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
     
    /*
     // Override to support rearranging the table view.
     - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
     }
     */
     
    /*
     // Override to support conditional rearranging of the table view.
     - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
     // Return NO if you do not want the item to be re-orderable.
     return YES;
     }
     */

     #pragma mark - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
         NSIndexPath *indexPath = [[self tableView] indexPathForSelectedRow];
         ABCPokemonDetailViewController *destination = segue.destinationViewController;
         destination.pokemon = _pokemonArray[indexPath.row];
     }
     
     @end
