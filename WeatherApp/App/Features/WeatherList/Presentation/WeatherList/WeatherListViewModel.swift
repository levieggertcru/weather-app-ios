//
//  WeatherListViewModel.swift
//  iosApp
//
//  Created by Levi Eggert on 12/16/23.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import shared

class WeatherListViewModel: ObservableObject {
    
    private let viewMyWeatherListUseCase: ViewMyWeatherListUseCase
    private let viewMyWeatherListDomainModel: ViewMyWeatherListDomainModel
    
    @Published var weatherItems: [WeatherListItemDomainModel] = Array()
    
    init(viewMyWeatherListUseCase: ViewMyWeatherListUseCase) {
        
        self.viewMyWeatherListUseCase = viewMyWeatherListUseCase
        
        viewMyWeatherListDomainModel = viewMyWeatherListUseCase.view()
        
        weatherItems = viewMyWeatherListDomainModel.weatherItems
    }
}
