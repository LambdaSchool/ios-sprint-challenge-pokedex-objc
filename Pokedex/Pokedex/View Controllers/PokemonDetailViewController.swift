//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Joe Veverka on 7/24/20.
//  Copyright © 2020 Joe Veverka. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    //MARK: Public Props
    
    @objc var pokemon: Pokemon?
    @objc var apiClient: PokemonAPIClient?
    
    //MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: IBoutlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    // TODO: KVO
    deinit {
        pokemon?.removeObserver(self, forKeyPath: "abilities", context: &PokemonDetailViewController.kvoContext)
    }
    
    private static var kvoContext = 0
    
    private func updateSprite() {
        
        guard let pokemon = pokemon,
            let spriteURL = pokemon.spriteURL,
            let apiClient = apiClient else { return }
        
        apiClient.fetchPokeImage(url: spriteURL) { (result) in
            
            switch result {
                
            case .failure(let error):
                
                print(error)
                
            case .success(let image):
                
                DispatchQueue.main.async {
                    
                    self.imageView.image = image
                }
            }
        }
    }
    
    
}
