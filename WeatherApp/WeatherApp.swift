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
                getCurrentWeatherUseCase: appDiContainer.feature.currentWeather.domainLayer.getCurrentWeatherUseCase()
            )
            
            CurrentWeatherView(
                viewModel: viewModel
            )
        }
    }
}
