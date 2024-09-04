//
//  BaseballSlogan.swift
//  Tving-Clone-Project
//
//  Created by 서은수 on 4/30/24.
//

import UIKit

/// 야구 슬로건 데이터 모델
struct BaseballSlogan {
    var image: UIImage
}

extension BaseballSlogan {
    static func dummyData() -> [BaseballSlogan] {
        return [
            BaseballSlogan(image: .bearsSloganWhite),
            BaseballSlogan(image: .bearsSloganBlack),
            BaseballSlogan(image: .bearsSloganWhite),
            BaseballSlogan(image: .bearsSloganBlack)
        ]
    }
}
