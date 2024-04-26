//
//  WeatherListItemView.swift
//  iosApp
//
//  Created by Levi Eggert on 12/16/23.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI
import shared

struct WeatherListItemView: View {
    
    private let geometry: GeometryProxy
    private let backgroundColor: Color = Color.white
    private let cornerRadius: CGFloat = 6
    private let domainModel: WeatherListItemDomainModel
    
    init(geometry: GeometryProxy, domainModel: WeatherListItemDomainModel) {
        
        self.geometry = geometry
        self.domainModel = domainModel
    }
    
    var body: some View {
        
        ZStack(alignment: .leading) {
                    
            backgroundColor
            
            VStack(alignment: .leading, spacing: 0) {
                
                Text("id: " + domainModel.id)
                    .foregroundColor(Color.black)
                    .font(Font.system(size: 17))
                
                Text("location: " + domainModel.location)
                    .foregroundColor(Color.black)
                    .font(Font.system(size: 17))
                
                Text("temperature: " + domainModel.temperature)
                    .foregroundColor(Color.black)
                    .font(Font.system(size: 17))
            }
            .padding([.top, .bottom], 15)
            .padding([.leading, .trailing], 15)
        }
        .cornerRadius(cornerRadius)
        .shadow(color: Color.black.opacity(0.25), radius: 4, y: 2)
        .padding([.leading, .trailing], 15)
        .contentShape(Rectangle()) // This fixes tap area not taking entire card into account.  Noticeable in iOS 14.
        .onTapGesture {

        }
    }
}
