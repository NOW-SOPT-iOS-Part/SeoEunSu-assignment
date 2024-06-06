//
//  StringLiteral.swift
//  Tving-Clone-Project
//
//  Created by 서은수 on 6/6/24.
//

import Foundation

enum StringLiteral: String {
    // 탭바 타이틀
    case homeTitle = "홈"
    case soonTitle = "공개예정"
    case searchTitle = "검색"
    case recordTitle = "기록"
    
    // 탭바 기본 이미지
    case homeImgName = "house"
    case soonImgName = "video"
    case searchImgName = "magnifyingglass"
    case recordImgName = "clock"
    
    // 탭바 클릭 안 됐을 때 이미지
    case homeUnselectedImgName = "house.fill"
    case soonUnselectedImgName = "video.fill"
    case recordUnselectedImgName = "clock.fill"
}
