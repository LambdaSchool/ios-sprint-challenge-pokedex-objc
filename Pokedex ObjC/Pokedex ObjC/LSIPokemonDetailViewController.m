//
//  LSIPokemonDetailViewController.m
//  Pokedex ObjC
//
//  Created by macbook on 1/31/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

#import "LSIPokemonDetailViewController.h"

@interface LSIPokemonDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UITextView *abilitiesTextview;

@end

@implementation LSIPokemonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
