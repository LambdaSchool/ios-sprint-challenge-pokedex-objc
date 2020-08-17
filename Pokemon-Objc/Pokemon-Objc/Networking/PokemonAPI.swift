//
//  PokemonAPI.swift
//  Pokemon-Objc
//
//  Created by Chad Parker on 8/14/20.
//  Copyright © 2020 Chad Parker. All rights reserved.
//

import Foundation
import UIKit

enum NetworkError: Error {
    case noData
    case noDecode
}

class PokemonAPI: NSObject {

    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!

    @objc(sharedController) static let shared = PokemonAPI()

    private override init() {}

    @objc func fetchAllPokemon(completion: @escaping ([LSIPokemon]?, Error?) -> Void) {
        URLSession.shared.dataTask(with: baseURL) { data, _, error in
            guard error == nil else {
                print("Error fetching data: \(error!)")
                DispatchQueue.main.async {
                    completion(nil, error!)
                }
                return
            }
            guard let data = data else {
                print("Error: no data returned")
                DispatchQueue.main.async {
                    completion(nil, NetworkError.noData)
                }
                return
            }
            guard let results = LSIPokemonResults(from: data) else {
                print("No pokemon results")
                DispatchQueue.main.async {
                    completion(nil, NetworkError.noDecode)
                }
                return
            }
            DispatchQueue.main.async {
                completion(results.pokemonArray, nil)
            }
        }.resume()
    }

    @objc func fillInDetails(for pokemon: LSIPokemon) {
        let detailURL = baseURL.appendingPathComponent(pokemon.name)
        URLSession.shared.dataTask(with: detailURL) { data, _, error in
            guard error == nil else {
                print("Error fetching data: \(error!)")
                return
            }
            guard let data = data else {
                print("Error: no data returned")
                return
            }
            pokemon.update(withDetailsData: data)
        }.resume()
    }
    
    @objc func fetchImage(at urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                completion(nil)
                return
            }
            guard let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            completion(image)
        }.resume()
    }
}
