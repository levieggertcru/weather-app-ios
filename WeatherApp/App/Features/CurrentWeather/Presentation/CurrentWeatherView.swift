//
//  CurrentWeatherView.swift
//  WeatherApp
//
//  Created by Levi Eggert on 4/24/24.
//

import SwiftUI

struct CurrentWeatherView: View {
    
    private let contentHorizontalPadding: CGFloat = 30
    
    @ObservedObject private var viewModel: CurrentWeatherViewModel
    
    @State private var zipCodeInput: String = ""
    
    init(viewModel: CurrentWeatherViewModel) {
        
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            
            VStack(alignment: .leading, spacing: 0) {
                
                Rectangle()
                    .frame(height: 50)
                    .foregroundColor(Color.clear)
                
                Text("Page Header")
                    .font(Font.system(size: 18))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                    .padding([.leading], contentHorizontalPadding)
                
                Text("Input a zipcode to see the current weather")
                    .font(Font.system(size: 14))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                    .padding([.leading], contentHorizontalPadding)
                    .padding([.top], 10)
                
                HStack(alignment: .center, spacing: 10) {
                    
                    TextField("", text: $zipCodeInput)
                        .font(Font.system(size: 20))
                        .foregroundColor(.black)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .frame(width: 180, height: 40)
                        .border(Color.blue, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                        .padding([.leading], contentHorizontalPadding)
                    
                    ConfirmZipButton(viewModel: viewModel, tappedClosure: {
                        viewModel.userDidSearchCurrentWeather(zipCode: zipCodeInput)
                    })
                    
                    if viewModel.isLoadingWeather {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .black))
                    }
                }
                .padding([.top], 20)
                
                Rectangle()
                    .fill(Color.clear)
                    .frame(height: 15)
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    HStack(alignment: .center, spacing: 10) {
                        
                        Text("City: ")
                            .foregroundColor(.black)
                            .font(Font.system(size: 16))
                        
                        Text(viewModel.currentWeather.city)
                            .foregroundColor(.black)
                            .font(Font.system(size: 16))
                    }
                    
                    HStack(alignment: .center, spacing: 10) {
                        
                        Text("State: ")
                            .foregroundColor(.black)
                            .font(Font.system(size: 16))
                        
                        Text(viewModel.currentWeather.state)
                            .foregroundColor(.black)
                            .font(Font.system(size: 16))
                    }
                    
                    HStack(alignment: .center, spacing: 10) {
                        
                        Text("Temperature: ")
                            .foregroundColor(.black)
                            .font(Font.system(size: 16))
                        
                        Text(viewModel.currentWeather.temperatureInFahrenheit)
                            .foregroundColor(.black)
                            .font(Font.system(size: 16))
                    }
                }
                .padding([.leading, .trailing], contentHorizontalPadding)
            }
        }
        .background(Color.white)
    }
}
