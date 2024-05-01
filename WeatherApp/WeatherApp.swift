//
//  WeatherApp.swift
//  WeatherApp
//
//  Created by Levi Eggert on 12/29/23.
//

import SwiftUI
import shared

@main
struct WeatherApp: App {
    var body: some Scene {
        WindowGroup {
            
            let appDiContainer = AppDiContainer(
                networkRequester: URLSessionNetworkRequester()
            )
            
            let viewModel = CurrentWeatherViewModel(
                searchCurrentWeatherUseCase: appDiContainer.feature.currentWeather.domainLayer.getSearchCurrentWeatherUseCase(),
                getLatestWeatherSearchesUseCase: appDiContainer.feature.currentWeather.domainLayer.getLatestWeatherSearchesUseCase()
            )
            
            CurrentWeatherView(
                viewModel: viewModel
            )
        }
    }
}
