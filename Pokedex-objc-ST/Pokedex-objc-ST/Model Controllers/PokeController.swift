//
//  PokeController.swift
//  Pokedex-objc-ST
//
//  Created by Jake Connerly on 11/15/19.
//  Copyright © 2019 jake connerly. All rights reserved.
//

import UIKit

class PokeController: NSObject {
    
    //MARK: - Properties
    
    private let baseURL = URL(string:"https://pokeapi.co/api/v2/pokemon")!
    @objc var allPokemon = [JLCPokemon]()
    @objc var selectedPokemon = JLCPokemon()
    var pokeImage = UIImage()
    
    //MARK: - Fetch All Pokemon
    
    @objc func fetchAllPokemon(completion: @escaping ([JLCPokemon]?, Error?) -> Void) {
        
        var components = URLComponents(url: self.baseURL, resolvingAgainstBaseURL: true)!
        
        let limitQuery = URLQueryItem(name: "limit", value: "964")
        components.queryItems = [limitQuery]
        let url = components.url!
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching all pokemon:\(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                let error = NSError()
                NSLog("Bad data. Error with data when fetching all pokemon:\(error)")
                completion(nil, error)
                return
            }
            
            do{
                guard let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any],
                    let pokeDictionaries = jsonDictionary["results"] as? [[String : Any]] else {
                        throw NSError()
                }
                
                let pokemon = pokeDictionaries.compactMap { JLCPokemon(dictionary: $0) }
                self.allPokemon = pokemon
                completion(pokemon, nil)
            } catch {
                NSLog("Error decoding pokemon:\(error)")
                completion(nil, error)
            }
        }.resume()
    }
    
    //MARK: - Fetch Single Pokemon By Name

    @objc func fetchSinglePokemon(with name: String, completion: @escaping (JLCPokemon?, Error?) -> Void) {
        
        let url = baseURL.appendingPathComponent(name)
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            if let error = error {
                NSLog("Error fetching pokemon \(name) with error:\(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError())
                return
            }
            
            do{
                guard let pokeDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any],
                      let pokemon = JLCPokemon(dictionary: pokeDictionary) else {
                        throw NSError()
                }
                self.selectedPokemon = pokemon
            } catch {
                NSLog("Error when decoding pokemon \(name) with error:\(error)")
                completion(nil, error)
            }
            completion(self.selectedPokemon, nil)
        }.resume()
    }
    
    //MARK: - Fetch Image From URL
    
    func fetchImageFromURL(url: URL, completion: @escaping (UIImage?, Error?) -> Void) {
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching image at url \(url) with error:\(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                NSLog("Bad data from image at URL: \(url)")
                completion(nil, error)
                return
            }
            
            guard let image = UIImage(data: data) else {
                NSLog("Error converting image from data")
                return
            }
            self.pokeImage = image
            completion(image, nil)
        }.resume()
    }
}
