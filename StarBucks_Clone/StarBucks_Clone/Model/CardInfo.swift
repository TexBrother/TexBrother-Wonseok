//
//  CardInfo.swift
//  StarBucks_Clone
//
//  Created by Wonseok Lee on 2021/09/21.
//

import Foundation

struct CardInfo {
    let cardImgName: String
    let name: String
    let balance: String
    let barcodeImgName: String
    let barcodeNum: String
}

var CardListData: [CardInfo] = [
    CardInfo(cardImgName: "cardSample", name: "카드", balance: "4,000원", barcodeImgName: "barcord", barcodeNum: "****-****-**36-6582"),
    CardInfo(cardImgName: "cardSample", name: "카드", balance: "4,000원", barcodeImgName: "barcord", barcodeNum: "****-****-**36-6582")
]
//var CardListData = [CardInfo]()
