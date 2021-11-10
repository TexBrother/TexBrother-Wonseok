//
//  AssetName.swift
//  StarBucks_Clone
//
//  Created by Wonseok Lee on 2021/11/10.
//

import Foundation
import UIKit

public struct Const {
    
    struct TabBar {
        static let home = UIImage(named: "icHome")!
        static let homeActivated = UIImage(named: "icHomeFill")!
        static let pay = UIImage(named: "icPay")!
        static let payActivated = UIImage(named: "icPayFill")!
        static let order = UIImage(named: "icOrder")!
        static let orderActivated = UIImage(named: "icOrderFill")!
        static let gift = UIImage(named: "icGift")!
        static let giftActivated = UIImage(named: "icGiftFill")!
        static let other = UIImage(named: "icOther")!
        static let otherActivated = UIImage(named: "icOtherFill")
    }

    struct PayTab {
        static let normalCharge = UIImage(named: "icNormalCharge")
        static let autoCharge = UIImage(named: "icAutoCharge")
        static let pencil = UIImage(named: "icPencil")
        static let star = UIImage(named: "icStar")
        static let starActivated = UIImage(named: "icStarFill")
    }
    
    struct GiftTab {
        static let shipping = "icShipping"
        static let giftItem = "icGiftItem"
        static let giftCard = "icGiftCard"
    }
}
