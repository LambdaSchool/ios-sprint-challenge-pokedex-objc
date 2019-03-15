//
//  PokemonAPI.swift
//  PokeDexObjC
//
//  Created by TuneUp Shop  on 3/15/19.
//  Copyright © 2019 jkaunert. All rights reserved.
//

import Foundation

@objcMembers
class PokemonAPI: NSObject {
    static let shared: PokemonAPI = PokemonAPI()
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    func fetchAllPokemon(completion: @escaping ([JMKPokemon]?, Error?) -> Void) {
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        let queryItem = URLQueryItem(name: "limit", value: "801") //limits query to 801 pokemon to avoid crashes. Can't figure out yet why over 801 causes crash.
        urlComponents.queryItems = [queryItem]
        let requestURL = urlComponents.url!
        
        var allPokemon:[JMKPokemon] = []
        
        URLSession.shared.dataTask(with: requestURL) {(data, _, error) in
            
            if let error = error {
                NSLog("Error fetching data: \(error)")
                return completion(nil, error)
            }
            
            guard let data = data else {
                NSLog("Error: Data is nil!")
                return completion(nil, nil)
            }
            
            do {
                let jsonDict = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let resultsDict = jsonDict["results"] as! [[String: String]]
                for dictionary in resultsDict {
                    if let pokemon = JMKPokemon(dictionary: dictionary) {
                        allPokemon.append(pokemon)
                    }
                }
                completion(allPokemon, nil)
            } catch  {
                NSLog("Error decoding json into object: \(error)")
                completion(nil, error)
            }
        }.resume()
    }
    
    func fillInDetails(for pokemon: JMKPokemon) {
        
        URLSession.shared.dataTask(with: pokemon.url) { (data, _, error) in
            
            if let error = error {
                NSLog("Error fetching details: \(error)")
                return
            }
            
            guard let data = data else {
                NSLog("Error: data is nil!")
                return
            }
            
            do {
                let jsonDict = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                pokemon.fillInDetails(with: jsonDict)
            } catch {
                NSLog("Error decoding json data: \(error)")
                return
            }
        }.resume()
    }
}
