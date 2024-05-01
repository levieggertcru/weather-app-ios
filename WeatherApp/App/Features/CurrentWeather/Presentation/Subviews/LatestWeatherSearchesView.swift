//
//  LatestWeatherSearchesView.swift
//  WeatherApp
//
//  Created by Levi Eggert on 5/1/24.
//

import SwiftUI
import shared

struct LatestWeatherSearchesView: View {
    
    private let contentHorizontalPadding: CGFloat
    
    @ObservedObject private var viewModel: CurrentWeatherViewModel
        
    init(viewModel: CurrentWeatherViewModel, contentHorizontalPadding: CGFloat) {
        
        self.viewModel = viewModel
        self.contentHorizontalPadding = contentHorizontalPadding
    }
    
    var body: some View {
         
        ScrollView(.horizontal, showsIndicators: false) {
            
            
            HStack(alignment: .center, spacing: 10) {
                
                ForEach(viewModel.latestWeatherSearches) { (weatherSearch: WeatherSearchDomainModel) in
                    
                    LatestWeatherSearchButton(
                        viewModel: viewModel,
                        weatherSearch: weatherSearch,
                        tappedClosure: {
                            viewModel.latestWeatherSearchTapped(weatherSearch: weatherSearch)
                        }
                    )
                }
            }
            .padding([.leading, .trailing], contentHorizontalPadding)
            .padding([.top, .bottom], 10)
        }
    }
}
