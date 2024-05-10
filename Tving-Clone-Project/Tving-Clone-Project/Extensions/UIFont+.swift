//
//  UIFont+.swift
//  Tving-Clone-Project
//
//  Created by 서은수 on 4/16/24.
//

import UIKit

extension UIFont {
    
    enum PretendardType: String {
        case thin = "Pretendard-Thin"
        case extraLight = "Pretendard-ExtraLight"
        case light = "Pretendard-Light"
        case regular = "Pretendard-Regular"
        case medium = "Pretendard-Medium"
        case semiBold = "Pretendard-SemiBold"
        case bold = "Pretendard-Bold"
        case extraBold = "Pretendard-ExtraBold"
        case black = "Pretendard-Black"
    }

    static func pretendard(weight: Int, size: CGFloat) -> UIFont {
        switch weight {
        case 100:
            return UIFont.init(name: PretendardType.thin.rawValue, size: size) ?? UIFont()
        case 200:
            return UIFont.init(name: PretendardType.extraLight.rawValue, size: size) ?? UIFont()
        case 300:
            return UIFont.init(name: PretendardType.light.rawValue, size: size) ?? UIFont()
        case 400:
            return UIFont.init(name: PretendardType.regular.rawValue, size: size) ?? UIFont()
        case 500:
            return UIFont.init(name: PretendardType.medium.rawValue, size: size) ?? UIFont()
        case 600:
            return UIFont.init(name: PretendardType.semiBold.rawValue, size: size) ?? UIFont()
        case 700:
            return UIFont.init(name: PretendardType.bold.rawValue, size: size) ?? UIFont()
        case 800:
            return UIFont.init(name: PretendardType.extraBold.rawValue, size: size) ?? UIFont()
        case 900:
            return UIFont.init(name: PretendardType.black.rawValue, size: size) ?? UIFont()
        default:
            return UIFont.init(name: PretendardType.regular.rawValue, size: size) ?? UIFont()
        }
    }
}
