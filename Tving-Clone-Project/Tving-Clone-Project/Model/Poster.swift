//
//  Poster.swift
//  Tving-Clone-Project
//
//  Created by 서은수 on 4/30/24.
//

import UIKit

/// 프로그램 포스터 데이터 모델
struct Poster {
    var name: String
    var image: UIImage
    var explaination: String?
}

extension Poster {
    /// 작은 크기의 포스터 셀을 위한 더미 데이터
    static func dummyDataForSmall() -> [Poster] {
        return [
            Poster(name: "시그널", image: .signalPoster),
            Poster(name: "해리포터", image: .harryporterPoster),
            Poster(name: "반지의 제왕", image: .ringPoster),
            Poster(name: "스즈메의 문단속", image: .doorPoster),
            Poster(name: "시그널", image: .signalPoster)
        ]
    }
    
    /// 맨 위의 큰 사이즈로 쓰이는 포스터 셀을 위한 더미 데이터
    static func dummyDataForBig() -> [Poster] {
        return [
            Poster(name: "너의 이름은", image: .yournamePoster, explaination: "너의 이름은은 어떤 설명입니다"),
            Poster(name: "해리포터", image: .harryporterPoster, explaination: "해리포터는 저떤 설명입니다"),
            Poster(name: "반지의 제왕", image: .ringPoster, explaination: "반지의 제왕은 그떤 설명입니다"),
            Poster(name: "스즈메의 문단속", image: .doorPoster, explaination: "스즈메의 문단속은 문떤 설명입니다")
        ]
    }
}
