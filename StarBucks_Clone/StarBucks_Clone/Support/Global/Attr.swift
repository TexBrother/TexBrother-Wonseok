//
//  Attr.swift
//  StarBucks_Clone
//
//  Created by Wonseok Lee on 2021/09/25.
//

import UIKit

// MARK: Attributes
public struct Attr {
    /// weight, color λν΄νΈλ regular, black
    static func setFont(size: CGFloat, weight: UIFont.Weight = .regular, color: UIColor = .black) -> [NSAttributedString.Key: Any] {
        return [.font: UIFont.systemFont(ofSize: size, weight: weight), .foregroundColor: color]
    }
}
