//
//  CALayer+.swift
//  StarBucks_Clone
//
//  Created by Wonseok Lee on 2021/09/25.
//

import AsyncDisplayKit

extension CALayer {
    
    // MARK: - Set ASDisplayNode's Shadow
    
    func dropShadow(color: UIColor, offSet: CGSize, opacity: Float, blur: CGFloat) {
        // 그림자 색상 설정
        self.shadowColor = color.cgColor
        // 그림자 크기 설정
        self.shadowOffset = offSet
        // 그림자 투명도 설정
        self.shadowOpacity = opacity
        // 그림자의 blur 설정
        self.shadowRadius = blur
        
        self.masksToBounds = false
    }
    
    // MARK: - Set ASDisplayNode's Radius
    
    func makeRounded(cornerRadius : CGFloat?){
        if let cornerRadius_ = cornerRadius {
            self.cornerRadius = cornerRadius_
        }  else {
            // cornerRadius 가 nil 일 경우의 default
            self.cornerRadius = self.frame.height / 2
        }
        
        self.masksToBounds = true
    }
}

