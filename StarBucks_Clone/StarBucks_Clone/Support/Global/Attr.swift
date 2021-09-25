//
//  Attr.swift
//  StarBucks_Clone
//
//  Created by Wonseok Lee on 2021/09/25.
//

import UIKit

public struct Attr {
    static var nameAttribute: [NSAttributedString.Key: Any] {
        return [.font: UIFont.systemFont(ofSize: 13.0, weight: .semibold),
                .foregroundColor: UIColor.black]
    }
    
    static var balanceAttribute: [NSAttributedString.Key: Any] {
        return [.font: UIFont.systemFont(ofSize: 16.0, weight: .semibold),
                .foregroundColor: UIColor.black]
    }
    
    static var etcAttribute: [NSAttributedString.Key: Any] {
        return [.font: UIFont.systemFont(ofSize: 11.0, weight: .bold),
                .foregroundColor: UIColor.gray]
    }
    
    static var naviAttribute: [NSAttributedString.Key: Any] {
        let shadow = NSShadow()
        shadow.shadowColor = .none
        shadow.shadowBlurRadius = 0
        return [.font: UIFont.systemFont(ofSize: 28.0, weight: .bold),
                .foregroundColor: UIColor.black, .shadow: shadow]
    }
}
