//
//  WeatherManager.swift
//  Clima
//
//  Created by Anshumali Karna on 03/03/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation


struct WeatherManager {
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?appid=908eafbc4e8644b65ae61d6e9e993330"
    
    func fetchWeather(city:String){
        let url = "\(weatherUrl)&q=\(city)"
        performRequest(urlString: url)
    }
    
    func performRequest(urlString:String){
        // create a URL
        if let url = URL(string: urlString){
            // create a urlSession
            let session = URLSession(configuration: .default)
            // give session a task
            let task = session.dataTask(with: url, completionHandler: handle(data: response: error: ))
            
            // start the task
            
            task.resume()
        }
    }
    
    func handle(data: Data?, response: URLResponse?, error: Error?) -> Void {
        if error != nil {
            print(error!)
            return
        }
        
        if let safeData = data {
            let dataString = String(data: safeData, encoding: .utf8)
            print(dataString)
        }
        
    }
}
