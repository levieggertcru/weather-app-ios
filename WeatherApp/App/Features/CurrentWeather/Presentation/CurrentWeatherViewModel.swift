//
//  CurrentWeatherViewModel.swift
//  WeatherApp
//
//  Created by Levi Eggert on 4/24/24.
//

import Foundation
import shared

class CurrentWeatherViewModel: ObservableObject {
    
    private let getCurrentWeatherUseCase: GetCurrentWeatherUseCase
    
    @Published var currentWeather: CurrentWeatherDomainModel
    @Published var isLoadingWeather: Bool = false
    
    init(getCurrentWeatherUseCase: GetCurrentWeatherUseCase) {
        
        self.getCurrentWeatherUseCase = getCurrentWeatherUseCase
        
        currentWeather = CurrentWeatherDomainModel(city: "", state: "", temperatureInFahrenheit: "")
        
        searchCurrentWeather(zipCode: "33304")
    }
    
    private func searchCurrentWeather(zipCode: String) {
        
        isLoadingWeather = true
        
        getCurrentWeatherUseCase.getCurrentWeather(zipCode: zipCode) { [weak self] (currentWeather: CurrentWeatherDomainModel) in
            DispatchQueue.main.async { [weak self] in
                self?.currentWeather = currentWeather
                self?.isLoadingWeather = false
            }
        }
    }
}

// MARK: - Inputs

extension CurrentWeatherViewModel {
    
    func userDidSearchCurrentWeather(zipCode: String) {
        
        searchCurrentWeather(zipCode: zipCode)
    }
}
