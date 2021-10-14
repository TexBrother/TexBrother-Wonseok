//
//  CardInfo.swift
//  StarBucks_Clone
//
//  Created by Wonseok Lee on 2021/09/21.
//

import Foundation

// MARK: CardInfo Struct

struct CardInfo {
    let cardImgName: String
    let name: String
    let balance: String
    let barcodeImgName: String?
    let barcodeNum: String?
    let isStar: Bool?
}

// MARK: Mock Data

var cardListData: [CardInfo] = [
    CardInfo(cardImgName: "cardSample", name: "첫번째 카드", balance: "59,000원", barcodeImgName: "barcord", barcodeNum: "****-****-**36-6582", isStar: true),
    CardInfo(cardImgName: "cardSample2", name: "두번째 카드", balance: "14,000원", barcodeImgName: "barcord", barcodeNum: "****-****-**36-6582", isStar: false)
]

//var cardListData = [CardInfo]()

var cardPlainData = CardInfo(cardImgName: "cardFrame", name: "스타벅스 카드를 등록해보세요.", balance: "매장과 사이렌오더에서 쉽고 편리하게\n사용할 수 있고, 별도 적립할 수 있습니다.", barcodeImgName: nil, barcodeNum: nil, isStar: nil)

