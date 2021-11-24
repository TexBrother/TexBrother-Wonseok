//
//  CardDetailInfo.swift
//  StarBucks_Clone
//
//  Created by Wonseok Lee on 2021/10/05.
//

import Foundation

// MARK: Card Detail Info

struct CardDetailInfo {
    let iconImgName: String
    let menuTitle: String
}

let cardDetailMenuData: [CardDetailInfo] = [
    CardDetailInfo(iconImgName: "icNormalCharge", menuTitle: "이용내역"),
    CardDetailInfo(iconImgName: "icAutoCharge", menuTitle: "자동충전"),
    CardDetailInfo(iconImgName: "icNormalCharge", menuTitle: "일반충전"),
    CardDetailInfo(iconImgName: "icNormalCharge", menuTitle: "분실 신고 및 잔액 이전"),
    CardDetailInfo(iconImgName: "icNormalCharge", menuTitle: "카드 등록 해지"),
]
