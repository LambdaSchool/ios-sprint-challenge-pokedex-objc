//
//  PokemonController.swift
//  Pokedex-ObjC
//
//  Created by Fabiola S on 2/21/20.
//  Copyright © 2020 Fabiola Saga. All rights reserved.
//

import Foundation
import UIKit

let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!

@objc (PokemonController)
class PokemonController: NSObject {
    typealias CompletionHandler = ([Pokemon]?, Error?) -> Void
    
    @objc(sharedController) static let shared = PokemonController()
    
    @objc func fetchPokemon(completion: @escaping CompletionHandler = { _, _ in }) {
        let urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        guard let requestURL = urlComponents?.url else { NSLog("requestURL: nil"); completion(nil, NSError()); return }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching data: \(error)")
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from data task");
                DispatchQueue.main.async {
                    completion(nil, NSError())
                }
                return
            }
            
            do {
                guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                    let error = NSError();
                    throw error
                }
                
                guard let pokemonDictionaries = dictionary["results"] as? [[String: Any]] else {
                    let error = NSError();
                    throw error
                }
                
                let pokemon = pokemonDictionaries.compactMap { Pokemon(dictionary: $0) }
                
                DispatchQueue.main.async {
                    completion(pokemon, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }.resume()
    }
    
    @objc func fetchPokemonDetails(pokemon: Pokemon) {
        var urlComponents = URLComponents(url: baseURL.appendingPathComponent(pokemon.name!), resolvingAgainstBaseURL: true)
        
        guard let requestURL = urlComponents?.url else { NSLog("requestURL is nil"); return }
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching data: \(error)")
                return
            }
            
            guard let data = data else {
                NSLog("No data returned");
                return
            }
            
            do {
                guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                    let error = NSError();
                    throw error
                }
                
                let pokemonImage = dictionary["sprites"] as! [String: Any]
                let imageString = pokemonImage["front_default"] as! String
                pokemon.sprites = imageString
                
                let id = dictionary["id"] as! Int
                pokemon.id = Int32(id)
                
                let abilitiesDictionaries = dictionary["abilities"] as! [[String: Any]]
                var names: [String] = []
                
                for abilityDictionary in abilitiesDictionaries {
                    let ability = abilityDictionary["ability"] as! [String: Any]
                    let name = ability["name"] as! String
                    names.append(name)
                }
                
                let typesDictionaries = dictionary["types"] as! [[String: Any]]
                var typesNames: [String] = []
                
                for typeDictionary in typesDictionaries {
                    let type = typeDictionary["type"] as! [String: Any]
                    let typeName = type["name"] as! String
                    typesNames.append(typeName)
                }
                
                pokemon.types = typesNames
                pokemon.abilities = names
            } catch {
                let error = NSError();
                return;
            }
        }.resume()
    }
}
