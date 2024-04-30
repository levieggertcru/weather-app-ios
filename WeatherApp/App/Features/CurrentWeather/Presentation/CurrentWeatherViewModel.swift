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
    private let getSearchedWeatherUseCase: GetSearchedWeatherUseCase
    
    private var getCurrentWeatherCancellable: CancellableInterface?
    private var getSearchedWeatherCancellable: CancellableInterface?
    
    @Published var currentWeather: CurrentWeatherDomainModel
    @Published var isLoadingWeather: Bool = false
    @Published var latestSearches: String = ""
    
    init(getCurrentWeatherUseCase: GetCurrentWeatherUseCase, getSearchedWeatherUseCase: GetSearchedWeatherUseCase) {
        
        self.getCurrentWeatherUseCase = getCurrentWeatherUseCase
        self.getSearchedWeatherUseCase = getSearchedWeatherUseCase
        
        currentWeather = CurrentWeatherDomainModel(city: "", state: "", temperatureInFahrenheit: "")
        
        searchCurrentWeather(zipCode: "33304")
        
        getSearchedWeatherCancellable = getSearchedWeatherUseCase
            .getLatestSearches { [weak self] (value: KotlinInt) in
                print("new search value: \(value)")
                self?.latestSearches = "latest searches: \(value)"
            }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            print("-> cancel search")
            self?.getSearchedWeatherCancellable?.cancel()
        }
    }
    
    deinit {
        
        getCurrentWeatherCancellable?.cancel()
        getSearchedWeatherCancellable?.cancel()
    }
    
    private func searchCurrentWeather(zipCode: String) {
        
        isLoadingWeather = true
        
        getCurrentWeatherCancellable = getCurrentWeatherUseCase.getCurrentWeather(zipCode: zipCode) { [weak self] (currentWeather: CurrentWeatherDomainModel) in
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
