//
//  AppConfig.swift
//  LanguageViewController
//
//  Created by Pham Quang Huy on 1/30/18.
//  Copyright © 2018 Pham Quang Huy. All rights reserved.
//

import Foundation

var appConfig = AppConfiguration()

class AppConfiguration {
    fileprivate var languageCash: Language? = nil
    
    var language: Language {
        get {
            if let languageCash = languageCash {
                return languageCash
            }
            
            let language: Language = {
                guard let storedValue = UserDefaults.standard.valueForKey(.Language) as? Int,
                    let language = Language(rawValue: storedValue) else {
                        // iOS9 から preferredLanguages の文字列変わったので切り分けます
                        let osLanguage: String? = Locale.preferredLanguages.first
                        return Language(isoString: osLanguage)
                }
                return language
            }()
            languageCash = language
            return language
        }
        
        set {
            languageCash = newValue
            let userDefaults = UserDefaults.standard
            userDefaults.setInteger(newValue.rawValue, forKey: .Language)
            userDefaults.synchronize()
        }
    }
}
