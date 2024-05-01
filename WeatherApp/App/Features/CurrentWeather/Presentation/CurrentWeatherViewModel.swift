//
//  CurrentWeatherViewModel.swift
//  WeatherApp
//
//  Created by Levi Eggert on 4/24/24.
//

import Foundation
import shared
import Combine

class CurrentWeatherViewModel: ObservableObject {
    
    private static let fortLauderdaleZipCode: String = "33304"
    
    private let searchCurrentWeatherUseCase: SearchCurrentWeatherUseCase
    private let getLatestWeatherSearchesUseCase: GetLatestWeatherSearchesUseCase

    private var cancellables: Set<AnyCancellable> = Set()
        
    @Published private var searchZipCode: String = ""
    
    @Published var currentWeather: CurrentWeatherDomainModel
    @Published var isLoadingWeather: Bool = false
    @Published var latestWeatherSearches: [WeatherSearchDomainModel] = Array()
    @Published var selectedWeatherSearch: WeatherSearchDomainModel?
    @Published var zipCodeTextInput: String = ""
    
    init(searchCurrentWeatherUseCase: SearchCurrentWeatherUseCase, getLatestWeatherSearchesUseCase: GetLatestWeatherSearchesUseCase) {
        
        self.searchCurrentWeatherUseCase = searchCurrentWeatherUseCase
        self.getLatestWeatherSearchesUseCase = getLatestWeatherSearchesUseCase
        
        currentWeather = CurrentWeatherDomainModel(city: "", state: "", temperatureInFahrenheit: "")
        
        zipCodeTextInput = CurrentWeatherViewModel.fortLauderdaleZipCode
        searchZipCode = CurrentWeatherViewModel.fortLauderdaleZipCode
        
        Publishers.FlowWrapperNeverPublisher(flowWrapper: getLatestWeatherSearchesUseCase.getSearches())
            .eraseToAnyPublisher()
            .map {
                $0.last?.weatherSearches ?? Array()
            }
            .receive(on: DispatchQueue.main)
            .assign(to: &$latestWeatherSearches)
        
        $searchZipCode
            .eraseToAnyPublisher()
            .flatMap({ [weak self] (zipCode: String) -> AnyPublisher<[CurrentWeatherDomainModel], Never> in
                
                self?.isLoadingWeather = true
                
                let isValid: Bool = self?.validateZipCode(zipCode: zipCode) ?? false
                
                if isValid {
                    
                    if let searchedWeather = self?.latestWeatherSearches.first(where: {$0.zipCode == zipCode}) {
                        self?.selectedWeatherSearch = searchedWeather
                    }
                    
                    return Publishers.FlowWrapperNeverPublisher(flowWrapper: searchCurrentWeatherUseCase.search(zipCode: zipCode))
                        .eraseToAnyPublisher()
                }
                else {
                    
                    return Just([])
                        .eraseToAnyPublisher()
                }
            })
            .map {
                $0.last
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (currentWeather: CurrentWeatherDomainModel?) in
                
                if let currentWeather = currentWeather {
                    self?.currentWeather = currentWeather
                }
                
                self?.isLoadingWeather = false
            }
            .store(in: &cancellables)
        
    }
    
    private func validateZipCode(zipCode: String) -> Bool {
        
        let isValid: Bool = zipCode.count == 5
        
        return isValid
    }
}

// MARK: - Inputs

extension CurrentWeatherViewModel {
    
    func userDidSearchCurrentWeather(zipCode: String) {
        
        searchZipCode = zipCode
        
        zipCodeTextInput = zipCode
    }
    
    func latestWeatherSearchTapped(weatherSearch: WeatherSearchDomainModel) {
        
        selectedWeatherSearch = weatherSearch
        
        searchZipCode = weatherSearch.zipCode
        
        zipCodeTextInput = weatherSearch.zipCode
    }
}
