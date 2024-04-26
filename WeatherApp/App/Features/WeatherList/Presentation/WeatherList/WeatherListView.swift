//
//  WeatherListView.swift
//  iosApp
//
//  Created by Levi Eggert on 12/16/23.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

struct WeatherListView: View {
    
    @ObservedObject private var viewModel: WeatherListViewModel
    
    init(viewModel: WeatherListViewModel) {
        
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ScrollView(.vertical) {
                
                LazyVStack(alignment: .leading) {
                    
                    ForEach(viewModel.weatherItems, id: \.self) { weatherItem in
                        
                        WeatherListItemView(
                            geometry: geometry,
                            domainModel: weatherItem
                        )
                    }
                }
            }
        }
    }
}


