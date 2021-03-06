//
//  File.swift
//  Yelpy
//
//  Created by Memo on 5/21/20.
//  Copyright © 2020 memo. All rights reserved.
//

import Foundation


struct API {
    
    static func getRestaurants(completion: @escaping ([Restaurant]?) -> Void) {
        
        // ––––– TODO: Add your own API key!
        let apikey = "D3B44wKmfhIQEnO1vuP-XUUE-LCW4zbNzRQzeVbDbNObZP5vUpcam2f4fVFF_VbwtUPVlpz0cYAvD5FSnl8aZrZ_IMxPbX7KpL8uwFm6BPK-QZtB-GiR4OjX_IZLYHYx"
        
        
        // Coordinates for San Francisco
        let lat = 37.773972
        let long = -122.431297
        
        
        // Coordinates for Union Square, New York, NY
        //let lat = 40.7359
        //let long = 73.9911
        
        
        let url = URL(string: "https://api.yelp.com/v3/transactions/delivery/search?latitude=\(lat)&longitude=\(long)")!
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        // Insert API Key to request
        request.setValue("Bearer \(apikey)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                
        

                // ––––– TODO: Get data from API and return it using completion
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

                // Get array of restaurant dictionaries
                let restDictionaries = dataDictionary["businesses"] as! [[String: Any]]

                // Variable to store array of Restaurants
                var restaurants: [Restaurant] = []

                // Use each restaurant dictionary to initialize Restaurant object
                for dictionary in restDictionaries {
                    let restaurant = Restaurant.init(dict: dictionary)
                    restaurants.append(restaurant) // add to restaurants array
                }

                return completion(restaurants)

                
                }
            }
        
            task.resume()
        
        }
    }

    
