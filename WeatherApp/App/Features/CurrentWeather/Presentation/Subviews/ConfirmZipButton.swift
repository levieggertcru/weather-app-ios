//
//  ConfirmZipButton.swift
//  WeatherApp
//
//  Created by Levi Eggert on 4/24/24.
//

import SwiftUI

struct ConfirmZipButton: View {
    
    private let buttonSize: CGFloat = 50
    private let buttonCornerRadius: CGFloat = 12
    private let tappedClosure: (() -> Void)?
    
    @ObservedObject private var viewModel: CurrentWeatherViewModel
        
    init(viewModel: CurrentWeatherViewModel, tappedClosure: (() -> Void)?) {
        
        self.viewModel = viewModel
        self.tappedClosure = tappedClosure
    }
    
    var body: some View {
        
        Button(action: {
            
            tappedClosure?()
        }) {
            
            ZStack(alignment: .center) {
                
                Rectangle()
                    .fill(.clear)
                    .frame(width: buttonSize, height: buttonSize)
                    .cornerRadius(buttonCornerRadius)
                
                Text("GO")
                    .font(Font.system(size: 15, weight: .semibold))
                    .foregroundColor(.white)
                    .padding()
            }
        }
        .frame(width: buttonSize, height: buttonSize, alignment: .center)
        .background(Color.white)
        .accentColor(borderColor)
        .cornerRadius(buttonCornerRadius)
        .overlay(
            RoundedRectangle(cornerRadius: buttonCornerRadius)
                .stroke(borderColor, lineWidth: 1)
        )
    }
    
    var borderColor: Color {
        viewModel.isLoadingWeather ? .green : .red
    }
}
