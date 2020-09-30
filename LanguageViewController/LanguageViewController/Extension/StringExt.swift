//
//  StringExt.swift
//  LanguageViewController
//
//  Created by Pham Quang Huy on 1/31/18.
//  Copyright © 2018 Pham Quang Huy. All rights reserved.
//

import Foundation

extension String {
    @discardableResult func localize(_ comment: String? = nil) -> String {
        return NSLocalizedString(self,
                                 tableName: appConfig.language.localizeTableName,
                                 comment: comment ?? "")
    }
    
    //日・中 = 日本語
    //それ以外 = 英語
    func localizeForJaZhEnOnly(_ comment: String? = nil) -> String {
        if appConfig.language.localizeTableName == Language.japanese.localizeTableName
            || appConfig.language.localizeTableName == Language.chinese.localizeTableName {
            return NSLocalizedString(self,
                                     tableName: Language.japanese.localizeTableName,
                                     comment: comment ?? "")
        } else {
            return NSLocalizedString(self,
                                     tableName: Language.english.localizeTableName,
                                     comment: comment ?? "")
        }
    }
}
