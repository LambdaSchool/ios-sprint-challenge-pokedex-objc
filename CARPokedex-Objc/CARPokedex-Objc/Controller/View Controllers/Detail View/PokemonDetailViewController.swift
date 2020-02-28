//
//  PokemonDetailViewController.swift
//  CARPokedex-Objc
//
//  Created by Chad Rutherford on 2/28/20.
//  Copyright © 2020 Chad Rutherford. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    @IBOutlet weak var spriteImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokemonIdLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @objc dynamic var pokemon: Pokemon?
    var idObservation: NSKeyValueObservation?
    var abilitiesObservation: NSKeyValueObservation?
    var spriteObservation: NSKeyValueObservation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupObservers()
        fillInDetails()
    }
    
    private func fillInDetails() {
        guard let pokemon = pokemon else { return }
        PokemonAPI.shared.fillInDetails(for: pokemon)
    }
    
    private func setupObservers() {
        guard let pokemon = pokemon else { return }
        idObservation = observe(\.pokemon?.pokemonId) { [weak self] object, change in
            guard let self = self,
                let pokemonId = pokemon.pokemonId else { return }
            self.pokemonIdLabel.text = "\(pokemonId)"
        }
        abilitiesObservation = observe(\.pokemon?.abilities) { [weak self] object, change in
            guard let self = self, let abilities = pokemon.abilities else { return }
            var abilityString = ""
            for ability in abilities {
                abilityString = "\(abilityString)\(ability.capitalized)\n"
            }
            self.abilitiesLabel.text = abilityString
        }
        spriteObservation = observe(\.pokemon?.spriteURL) { [weak self] object, change in
            guard let self = self else { return }
            self.fetchSpriteImage(for: pokemon.spriteURL)
        }
        nameLabel.text = pokemon.name.capitalized
        title = pokemon.name.capitalized
    }
    
    deinit {
        idObservation?.invalidate()
        idObservation = nil
        abilitiesObservation?.invalidate()
        abilitiesObservation = nil
        spriteObservation?.invalidate()
        spriteObservation = nil
    }
    
    private func fetchSpriteImage(for pokemonURL: String) {
        guard let url = URL(string: pokemonURL) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.spriteImageView.image = image
            }
        }.resume()
    }
}
