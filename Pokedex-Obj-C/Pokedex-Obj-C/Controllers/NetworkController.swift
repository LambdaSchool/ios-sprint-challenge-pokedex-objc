//
//  NetworkController.swift
//  Pokedex-Obj-C
//
//  Created by Christopher Devito on 5/22/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

import Foundation

class NetworkController: NSObject {
    // MARK: - Properties
    @objc(sharedController) static let shared: NetworkController = NetworkController()
    @objc var pokemons: [Pokemon] = []
    @objc var pokemonList: [PokemonShort] = []
    let baseURL = "https://pokeapi.co/api/v2/pokemon/"

    // MARK: - Network Methods
    @objc func fetchAllPokemon(completion: @escaping ([PokemonShort]?, Error?) -> Void) {
        let resourceNumber = URLQueryItem(name: "limit", value: "60")
        var components = URLComponents(url: URL(string: baseURL)!, resolvingAgainstBaseURL: true)
        components?.queryItems = [resourceNumber]
        guard let url = components?.url else {
            print("Error composing URL: \(baseURL), \(resourceNumber), \(String(describing: components))")
            return }
        let urlRequest = URLRequest(url: url)
        print("URLRequest: \(urlRequest)")

        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Error fetcihng from network: \(error)")
                completion(nil, error)
                return
            }

            guard let data = data else {
                print("No data")
                completion(nil, nil)
                return
            }

            do {
//                guard let dictionary: Dictionary = try PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil) as? Dictionary<String, Any> else {
//                    print("Error decododing data to dictionary")
//                    return
//                }
                let dictionary: Dictionary = try JSONSerialization.jsonObject(with: data, options: []) as! Dictionary<String, Any>
                var entryArray: [PokemonShort]
                for entry in dictionary where entry.key == "results" {
                    let entryValues = entry.value as? [PokemonShort]
                    print("entryValues: \(String(describing: entryValues))")
                }
            }
            catch {
                print("\(error)")
            }
        }.resume()
    }

    @objc func fillInDetails(for pokemon: Pokemon) {

    }

    // MARK: - Helper Methods
}
