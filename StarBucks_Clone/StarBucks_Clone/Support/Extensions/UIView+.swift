//
//  UIView+.swift
//  StarBucks_Clone
//
//  Created by Wonseok Lee on 2021/09/22.
//

import UIKit

extension UIView {
    
    // MARK: - Set UIView's Shadow
    
    func dropShadow(color: UIColor, offSet: CGSize, opacity: Float, radius: CGFloat) {
        // 그림자 색상 설정
        layer.shadowColor = color.cgColor
        // 그림자 크기 설정
        layer.shadowOffset = offSet
        // 그림자 투명도 설정
        layer.shadowOpacity = opacity
        // 그림자의 blur 설정
        layer.shadowRadius = radius
        // 구글링 해보세요!
        layer.masksToBounds = false
    }
}
