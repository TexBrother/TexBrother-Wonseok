//
//  Attr.swift
//  StarBucks_Clone
//
//  Created by Wonseok Lee on 2021/09/25.
//

import UIKit

public struct Attr {
    static var twelveSM: [NSAttributedString.Key: Any] {
        return [.font: UIFont.systemFont(ofSize: 12.0, weight: .semibold),
                .foregroundColor: UIColor.black]
    }
    
    static var fifteenReg: [NSAttributedString.Key: Any] {
        return [.font: UIFont.systemFont(ofSize: 15.0, weight: .regular),
                .foregroundColor: UIColor.black]
    }
    
    static var twentyThreeBold: [NSAttributedString.Key: Any] {
        return [.font: UIFont.systemFont(ofSize: 23.0, weight: .bold),
                .foregroundColor: UIColor.black]
    }
    
    static var thirteenSM: [NSAttributedString.Key: Any] {
        return [.font: UIFont.systemFont(ofSize: 11.0, weight: .bold),
                .foregroundColor: UIColor.gray]
    }
    
    static var twentyEightBold: [NSAttributedString.Key: Any] {
        return [.font: UIFont.systemFont(ofSize: 28.0, weight: .bold),
                .foregroundColor: UIColor.black]
    }
}
