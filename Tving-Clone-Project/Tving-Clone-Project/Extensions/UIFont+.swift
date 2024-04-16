//
//  UIFont+.swift
//  Tving-Clone-Project
//
//  Created by 서은수 on 4/16/24.
//

import UIKit

extension UIFont {
    enum PretendardType: String {
        case black = "Pretendard-Black"
        case bold = "Pretendard-Bold"
        case extraBold = "Pretendard-ExtraBold"
        case extraLight = "Pretendard-ExtraLight"
        case light = "Pretendard-Light"
        case medium = "Pretendard-Medium"
        case regular = "Pretendard-Regular"
        case semiBold = "Pretendard-SemiBold"
        case thin = "Pretendard-Thin"
    }

    static func pretendard(_ type: PretendardType, size: CGFloat) -> UIFont {
        return UIFont.init(name: type.rawValue, size: size) ?? UIFont()
    }
}
