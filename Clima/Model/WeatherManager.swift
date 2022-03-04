//
//  WeatherManager.swift
//  Clima
//
//  Created by Anshumali Karna on 03/03/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation


struct WeatherManager {
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?appid=908eafbc4e8644b65ae61d6e9e993330&units=metric"
    
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
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(weatherData: safeData) {
                        let weatherVC = WeatherViewController()
                        weatherVC.didUpdateWeather(weather: weather)
                    }
                }
            }
            
            // start the task
            
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            
            return weather
           
        }
        catch{
            print(error)
            
            return nil
        }
    }
    
}
