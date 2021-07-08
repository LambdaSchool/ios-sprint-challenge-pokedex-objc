//
//  PokemonAPI.swift
//  PokedexObjc
//
//  Created by Dillon McElhinney on 3/8/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import Foundation

@objc class PokemonAPI: NSObject {
    @objc static let shared: PokemonAPI = PokemonAPI()
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!

    // MARK: - Networking
    /// Fetches the first 151 pokemon
    @objc func fetchAllPokemon(completion: @escaping ([DRMPokemon]?, Error?) -> Void) {
        
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        let limitQuery = URLQueryItem(name: "limit", value: "151")
        components.queryItems = [limitQuery]
        
        let requestURL = components.url!
        var pokemons: [DRMPokemon] = []
        
        let datatask = URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching all pokemon: \(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                NSLog("No data was returned... ")
                completion(nil, nil)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let results = json["results"] as! [[String: String]]
                for result in results {
                    if let pokemon = DRMPokemon(dictionary: result) {
                        pokemons.append(pokemon)
                    }
                }
                completion(pokemons, nil)
            } catch {
                NSLog("Error decoding Pokemon: \(error)")
                completion(nil, error)
            }
        }
        datatask.resume()
    }
    
    /// Fetches the missing details for the given pokemon so that they can be filled in
    @objc func fillInDetails(for pokemon: DRMPokemon) {
        
        let datatask = URLSession.shared.dataTask(with: pokemon.url) { (data, _, error) in
            if let error = error {
                NSLog("Error filling in details for pokemon: \(error)")
                return
            }
            
            guard let data = data else {
                NSLog("No data was returned...")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                pokemon.fillIn(with: json)
                
            } catch {
                NSLog("Error decoding Pokemon detail: \(error)")
            }
        }
        
        datatask.resume()
    }
}
