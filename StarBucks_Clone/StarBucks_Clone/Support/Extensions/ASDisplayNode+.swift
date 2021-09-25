//
//  ASDisplayNode+.swift
//  StarBucks_Clone
//
//  Created by Wonseok Lee on 2021/09/25.
//

import AsyncDisplayKit

extension ASDisplayNode {
    // MARK: - Set UIView's Shadow
    func dropShadow(color: UIColor, offSet: CGSize, opacity: Float, blur: CGFloat) {
        // 그림자 색상 설정
        self.layer.shadowColor = color.cgColor
        // 그림자 크기 설정
        self.layer.shadowOffset = offSet
        // 그림자 투명도 설정
        self.layer.shadowOpacity = opacity
        // 그림자의 blur 설정
        self.layer.shadowRadius = blur
        // 구글링 해보세요!
        self.layer.masksToBounds = false
    }
    
    func makeRounded(cornerRadius : CGFloat?){
        if let cornerRadius_ = cornerRadius {
            self.layer.cornerRadius = cornerRadius_
        }  else {
            // cornerRadius 가 nil 일 경우의 default
            self.layer.cornerRadius = self.layer.frame.height / 2
        }
        
        self.layer.masksToBounds = true
    }
}
