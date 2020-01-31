//
//  PokemonAPI.swift
//  Pokdex-Hybrid
//
//  Created by Isaac Lyons on 12/20/19.
//  Copyright © 2019 Isaac Lyons. All rights reserved.
//

import Foundation

class PokemonAPI: NSObject {

    @objc(sharedController) static let shared: PokemonAPI = PokemonAPI()
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!

    @objc func fetchAllPokemon(completion: @escaping ([Pokemon]?, Error?) -> Void) {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)
        urlComponents!.queryItems = [URLQueryItem(name: "limit", value: "2000")]
        URLSession.shared.dataTask(with: urlComponents!.url!) { data, _, error in
            if let error = error {
                return completion(nil, error)
            }
            
            guard let data = data else {
                NSLog("No data returned from request in fetchAllPokemon")
                return completion(nil, NSError())
            }
            
            do {
                guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary else {
                    NSLog("Data returned was not a dictionary")
                    return completion(nil, NSError())
                }
                
                guard let pokemonArray = dictionary["results"] as? NSArray else {
                    NSLog("Could not find pokemon list from results")
                    return completion(nil, NSError())
                }
                
                var results: [Pokemon] = []
                for pokemonDictionary in pokemonArray {
                    guard let pokemonDictionary = pokemonDictionary as? [String: Any] else { continue }
                    if let pokemon = Pokemon(dictionary: pokemonDictionary) {
                        results.append(pokemon)
                    }
                }
                
                completion(results, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }

    @objc func fillInDetails(for pokemon: Pokemon) {
        let url = baseURL.appendingPathComponent(pokemon.name)
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                NSLog("\(error)")
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from request in fillInDetails")
                return
            }
            
            do {
                guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                    NSLog("Data returned was not a dictionary")
                    return
                }
                
                pokemon.update(from: dictionary)
            } catch {
                NSLog("\(error)")
            }
        }.resume()
    }
}
