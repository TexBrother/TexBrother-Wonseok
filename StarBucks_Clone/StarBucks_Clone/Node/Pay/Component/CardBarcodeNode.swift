//
//  CardBarcodeNode.swift
//  StarBucks_Clone
//
//  Created by Wonseok Lee on 2021/10/05.
//

import AsyncDisplayKit

final class CardBarcodeNode: ASDisplayNode {
    // MARK: UI
    
    let barcodeImgNode = ASImageNode().then {
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFit
    }
    
    let barcodeNumNode = ASTextNode().then {
        $0.style.flexShrink = 1.0
        $0.maximumNumberOfLines = 1
    }
    
    let validTimeTextNode = ASTextNode().then {
        $0.attributedText = NSAttributedString(string: "바코드 유효시간",
                                               attributes: Attr.setFont(size: 12, weight: .semibold))
    }
    
    let validTimerNode = ASTextNode().then {
        $0.attributedText = NSAttributedString(string: "10:00",
                                               attributes: Attr.setFont(size: 12, weight: .bold, color: .seaweedGreen))
    }
    
    // TODO: 타이머 Reset버튼
    
    // MARK: Variables
    
    var timer: Timer?
    var timerInfo = (600, 1.0, true)
    
    // MARK: Background Thread
    
    override init() {
        super.init()
        self.backgroundColor = .systemBackground
        self.automaticallyManagesSubnodes = true
        self.automaticallyRelayoutOnSafeAreaChanges = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension CardBarcodeNode {
    // MARK: Layout
    
    override func layoutSpecThatFits(_ constraintedSize: ASSizeRange) -> ASLayoutSpec {
        return ASStackLayoutSpec (
            direction: .vertical,
            spacing: 8,
            justifyContent: .start,
            alignItems: .center,
            children: [
                barcodeLayoutSpec(),
                timerLayoutSpec()
            ]
        )
    }
    
    private func barcodeLayoutSpec() -> ASLayoutSpec {
        return ASStackLayoutSpec(direction: .vertical, spacing: 8, justifyContent: .center, alignItems: .center, children: [barcodeImgNode, barcodeNumNode])
    }
    
    private func timerLayoutSpec() -> ASLayoutSpec {
        return ASStackLayoutSpec(direction: .horizontal, spacing: 3, justifyContent: .center, alignItems: .center, children: [validTimeTextNode, validTimerNode])
    }
    
    // MARK: Method
    
    func setRepeatTimer(totalTime: Int, timeInterval: Double, rp: Bool) {
        var timeLeft = totalTime
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: rp) { [weak self] timer in
            guard let self = self else { return }
            timeLeft -= 1
            if timeLeft <= 0 {
                timer.invalidate()
            }
            let hour = String(format: "%02d", Int(timeLeft / 60))
            let minute = String(format: "%02d", Int(timeLeft - (Int(hour)!*60)))
            let timeToStr = "\(hour):\(minute)"
            self.validTimerNode.attributedText = NSAttributedString(string: timeToStr,
                                                                    attributes: Attr.setFont(size: 12, weight: .bold, color: .seaweedGreen))
        }
    }
}
