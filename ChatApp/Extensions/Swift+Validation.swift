//
//  Swift+Validation.swift
//  ChatApp
//
//  Created by 萬木大志 on 2020/04/20.
//  Copyright © 2020 makimaki. All rights reserved.
//

import Foundation

extension String {
    
    var length: Int {
        let string_NS = self as NSString
        return string_NS.length
    }
    
    //正規表現の検索をします
    func pregMatche(pattern: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: pattern) else {
            return false
        }
        let matches = regex.matches(in: self, range: NSMakeRange(0, self.length))
        print(matches)
        return matches.count > 0
    }
}
