//
//  LocalizationSupportType.swift
//  LanguageViewController
//
//  Created by Pham Quang Huy on 1/30/18.
//  Copyright © 2018 Pham Quang Huy. All rights reserved.
//

import Foundation

var languageChangeReceiverManager = LanguageChangeReceiverManager()

enum Language: Int {
    case japanese, english, chinese, tagalog, portuguese, thai, vietnamese, indonesian, spanish
    
    static var count: Int { return 9 }
    static let allLangs: [Language] = [english, japanese, thai, vietnamese]
    func toString() -> String {
        switch self {
        case .japanese:
            return "日本語"
        case .english:
            return "English"
        case .chinese:
            return "中文"
        case .tagalog:
            return "Tagalog"
        case .portuguese:
            return "Português"
        case .thai:
            return "ภาษาไทย"
        case .vietnamese:
            return "Tiếng Việt"
        case .indonesian:
            return "Bahasa Indonesia"
        case .spanish:
            return "Español"
        }
    }
    
    func toIsoString() -> String {
        switch self {
        case .japanese:
            return "ja"
        case .english:
            return "en"
        case .chinese:
            return "zh"
        case .tagalog:
            return "tl"
        case .portuguese:
            return "pt"
        case .thai:
            return "th"
        case .vietnamese:
            return "vi"
        case .indonesian:
            return "id"
        case .spanish:
            return "es"
        }
    }
    
    // 該当するものがない場合、English になる
    init(isoString: String?) {
        guard let isoString = isoString else {
            self = .english
            return
        }
        
        if isoString.hasPrefix("ja") { self = .japanese }
        else if isoString.hasPrefix("en") { self = .english }
        else if isoString.hasPrefix("zh") { self = .chinese }
        else if isoString.hasPrefix("tl") { self = .tagalog }
        else if isoString.hasPrefix("pt") { self = .portuguese }
        else if isoString.hasPrefix("th") { self = .thai }
        else if isoString.hasPrefix("vi") { self = .vietnamese }
        else if isoString.hasPrefix("id") { self = .indonesian }
        else if isoString.hasPrefix("es") { self = .spanish }
        else { self = .english }
    }
    
    var localizeTableName: String {
        switch self {
        case .japanese:
            return "Localizable_ja"
        case .english:
            return "Localizable_en"
        case .chinese:
            return "Localizable_zh"
        case .tagalog:
            return "Localizable_tl"
        case .portuguese:
            return "Localizable_pt"
        case .thai:
            return "Localizable_th"
        case .vietnamese:
            return "Localizable_vi"
        case .indonesian:
            return "Localizable_in"
        case .spanish:
            return "Localizable_es"
        }
    }
}

protocol LocalizeSupportType : AnyObject {
    var language: Language { get set }
}

extension LocalizeSupportType {
    func beginLocalizing() {
        // TODO: ユーザの設定している言語を代入
        language = appConfig.language
        languageChangeReceiverManager.assign(self)
    }
}

class LanguageChangeReceiverManager: Sequence {
    // FIXME: 後で _WeakContainerRef 消す
    fileprivate class _WeakContainerRef {
        struct WeakContainer {
            weak var receiver: LocalizeSupportType?
        }
        
        var _containers: [WeakContainer]
        
        var containersExcludeNilContiner: [WeakContainer] {
            return _containers.filter { $0.receiver != nil }
        }
        
        var receivers: [LocalizeSupportType] {
            return containersExcludeNilContiner.map { $0.receiver! }
        }
        
        init(containers: [WeakContainer]) {
            _containers = containers
        }
        
        func dropWeaks() {
            _containers = containersExcludeNilContiner
        }
        
        func generate() -> AnyIterator<LocalizeSupportType> {
            return AnyIterator(containersExcludeNilContiner.map { $0.receiver! }.makeIterator())
        }
    }
    
    typealias PublishType = Language
    fileprivate var _weakContainerRef: _WeakContainerRef
    
    fileprivate init() {
        _weakContainerRef = _WeakContainerRef(containers: [])
    }
    
    fileprivate init<T: LocalizeSupportType>(objects: T...) {
        _weakContainerRef = _WeakContainerRef(containers: objects.map(_WeakContainerRef.WeakContainer.init))
    }
    
    fileprivate var receivers: [LocalizeSupportType] {
        return _weakContainerRef.receivers
    }
    
    func makeIterator() -> AnyIterator<LocalizeSupportType> {
        _weakContainerRef.dropWeaks()
        return _weakContainerRef.generate()
    }
    
    fileprivate func assign<T: LocalizeSupportType>(_ content: T) {
        _weakContainerRef.dropWeaks()
        let x = _WeakContainerRef.WeakContainer(receiver: content)
        _weakContainerRef._containers.append(x)
    }
    
    /**
     登録されてる LocalizeSupportType の language を変更する
     - parameter language: 言語設定
     */
    func publish(_ language: PublishType) {
        receivers.forEach {
            $0.language = language
        }
    }
}
