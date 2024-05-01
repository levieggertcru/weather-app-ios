//
//  WeatherSearchDomainModel+Identifiable.swift
//  WeatherApp
//
//  Created by Levi Eggert on 5/1/24.
//

import Foundation
import shared

extension WeatherSearchDomainModel: Identifiable {
    var identifier: String {
        return zipCode
    }
}
