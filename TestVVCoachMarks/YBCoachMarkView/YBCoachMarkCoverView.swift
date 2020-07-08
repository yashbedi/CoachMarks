//
//  YBCoachMarkCoverView.swift
//  TestVVCoachMarks
//
//  Created by Yash Bedi on 25/06/20.
//  Copyright © 2020 Yash Bedi. All rights reserved.
//

import UIKit

enum Shapes {
    case ellipse
    case rect
    case roundedRect
    case circle
}

enum PopOverOrigin{
    case top
    case bottom
}

final class YBCoachMarkCoverView: YBBaseView {
    
    private var holeRect: CGRect? = nil
    private let popOverView: YBPopOverView = YBPopOverView()
    
    public weak var delegate: ButtonTapOnPopOver?
    public var _tag: Int = 0
    public var origin: PopOverOrigin = .bottom
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }
    
    private func configureUI() {
        backgroundColor = .darkGray
        alpha = 0.8
        guard let window = UIApplication.shared.windows.first else { return }
        frame = window.frame
    }
    
    func setMask(with hole: CGRect, shape: Shapes, cornerRadius: CGFloat = 0) {
        let mutablePath = CGMutablePath()
        mutablePath.addRect(bounds)
        holeRect = hole
        holeRect?.giveInternalPadding(10)
        switch shape {
        case .circle:
            let radius = holeRect!.height / 2
            mutablePath.addRoundedRect(in: holeRect!, cornerWidth: radius, cornerHeight: radius)
        case .roundedRect:
            mutablePath.addRoundedRect(in: holeRect!, cornerWidth: cornerRadius, cornerHeight: cornerRadius)
        case .ellipse:
            mutablePath.addEllipse(in: holeRect!)
        case .rect:
            mutablePath.addRect(holeRect!)
        }
        let mask = CAShapeLayer()
        mask.path = mutablePath
        mask.fillRule = .evenOdd
        layer.mask = mask
        
        commonInIt()
    }
}

// MARK: PopOver logic

private extension YBCoachMarkCoverView {
    
    func commonInIt(){
        setUI()
        setHierarchy()
        setConstraints()
    }
    func setUI(){
        popOverView._tag = _tag
        popOverView.delegate = delegate
    }
    func setHierarchy(){
        addSubview(popOverView)
    }
    func setConstraints(){
        popOverView.frame.size = CGSize(width: 120, height: 70)
        let y = origin == .bottom ? holeRect!.origin.y + holeRect!.height + 10 : holeRect!.origin.y - 90
        popOverView.frame.origin = CGPoint(x: holeRect!.origin.x ,
                                           y: y)
    }
}
