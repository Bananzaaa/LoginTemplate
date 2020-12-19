//
//  AppSettingsManager.swift
//  LoginTemplate
//
//  Created by Ацкий Станислав on 15.12.2020.
//

import Foundation

protocol IAppSettingsManager {
    func set(_ data: Data, for key: String)
    func getData(for key: String) -> Data?
}

final class AppSettingsManager: IAppSettingsManager {
    
    private let defaults = UserDefaults.standard
        
    func set(_ data: Data, for key: String) {
        defaults.setValue(data, forKey: key)
    }
    
    func getData(for key: String) -> Data? {
        defaults.data(forKey: key)
    }
}
