//
//  NSObject+.swift
//  Tving-Clone-Project
//
//  Created by 서은수 on 5/10/24.
//

import Foundation

extension NSObject {
    static var className: String {
        return String(describing: self)
    }
}
