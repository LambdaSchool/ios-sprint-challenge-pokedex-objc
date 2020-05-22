//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Tobi Kuyoro on 22/05/2020.
//  Copyright © 2020 Tobi Kuyoro. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var abilitiesLabel: UILabel!

    // MARK: - Properties

    @objc var pokemon: Pokemon? {
        didSet {
            fetchDetails()
        }
    }

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }

    func fetchDetails() {
        guard let pokemon = pokemon else { return }
        APIController.shared.fillInDetails(for: pokemon) { pokemon in
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }

    func updateViews() {
        guard
            isViewLoaded,
            let pokemon = pokemon,
            let abilities = pokemon.abilities,
            let imageData = try? Data(contentsOf: pokemon.sprite!) else { return }

        let abilitiesString = abilities.componentsJoined(by: ", ").capitalized
        self.nameLabel.text = pokemon.name.capitalized
        self.imageView.image = UIImage(data: imageData)
        self.idLabel.text = "ID: \(pokemon.identifier.description)"
        self.abilitiesLabel.text = abilitiesString
    }
}
