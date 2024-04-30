//
//  LiveProgram.swift
//  Tving-Clone-Project
//
//  Created by 서은수 on 4/30/24.
//

import UIKit

/// 라이브 프로그램 데이터 모델
struct LiveProgram {
    var ranking: String
    var title: String
    var channel: String
    var viewingRating: String
    var image: UIImage
}

extension LiveProgram {
    static func dummyData() -> [LiveProgram] {
        return [
            LiveProgram(ranking: "1", title: "눈물의 여왕", channel: "tvN", viewingRating: "25.4", image: .queenOfTearLive),
            LiveProgram(ranking: "2", title: "선재 업고 튀어", channel: "tvN", viewingRating: "12.4", image: .seonUpRunLive),
            LiveProgram(ranking: "3", title: "눈물의 여왕", channel: "tvN", viewingRating: "25.4", image: .queenOfTearLive),
            LiveProgram(ranking: "4", title: "선재 업고 튀어", channel: "tvN", viewingRating: "12.4", image: .seonUpRunLive),
            LiveProgram(ranking: "5", title: "눈물의 여왕", channel: "tvN", viewingRating: "25.4", image: .queenOfTearLive)
        ]
    }
}
