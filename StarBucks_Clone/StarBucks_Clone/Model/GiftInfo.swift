//
//  GiftInfo.swift
//  StarBucks_Clone
//
//  Created by Wonseok Lee on 2021/11/10.
//

import Foundation
import UIKit

// MARK: GiftInfo Struct

struct GiftInfo {
    let iconImg: String
    let title: String
    let description: String
}

// MARK: Mock Data

var giftInfoList: [GiftInfo] = [
    GiftInfo(iconImg: Const.GiftTab.shipping, title: "배송하기", description: "스타벅스의 MD를\n이제 집에서 받아보세요."),
    GiftInfo(iconImg: Const.GiftTab.giftItem, title: "e-Gift Item", description: "고마운 마음,\n모바일 상품권으로 선물하세요."),
    GiftInfo(iconImg: Const.GiftTab.giftCard, title: "e-Gift Card", description: "소중한 사람에게 쉽고 빠르게\n마음을 전해보세요.")
]

