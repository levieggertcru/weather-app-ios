//
//  LatestWeatherSearchButton.swift
//  WeatherApp
//
//  Created by Levi Eggert on 5/1/24.
//

import SwiftUI
import shared

struct LatestWeatherSearchButton: View {
    
    private let weatherSearch: WeatherSearchDomainModel
    private let buttonSize: CGSize = CGSize(width: 110, height: 45)
    private let buttonCornerRadius: CGFloat = 12
    private let tappedClosure: (() -> Void)?
    
    @ObservedObject private var viewModel: CurrentWeatherViewModel
        
    init(viewModel: CurrentWeatherViewModel, weatherSearch: WeatherSearchDomainModel, tappedClosure: (() -> Void)?) {
        
        self.viewModel = viewModel
        self.weatherSearch = weatherSearch
        self.tappedClosure = tappedClosure
    }
    
    var body: some View {
        
        Button(action: {
            
            tappedClosure?()
        }) {
            
            ZStack(alignment: .center) {
                
                Rectangle()
                    .fill(.clear)
                    .frame(width: buttonSize.width, height: buttonSize.height)
                    .cornerRadius(buttonCornerRadius)
                
                Text(weatherSearch.zipCode)
                    .font(Font.system(size: 15, weight: .semibold))
                    .foregroundColor(.black)
                    .padding()
            }
        }
        .frame(width: buttonSize.width, height: buttonSize.height, alignment: .center)
        .background(Color.white)
        .accentColor(borderColor)
        .cornerRadius(buttonCornerRadius)
        .overlay(
            RoundedRectangle(cornerRadius: buttonCornerRadius)
                .stroke(borderColor, lineWidth: 1)
        )
    }
    
    var borderColor: Color {
        weatherSearch.zipCode == viewModel.selectedWeatherSearch?.zipCode ? .green : .black
    }
}
