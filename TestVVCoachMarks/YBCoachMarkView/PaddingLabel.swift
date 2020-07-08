//
//  PaddingLabel.swift
//  
//
//  Created by Yash Bedi on 25/06/20.
//

import UIKit

final class LabelWithPadding: UILabel {
    var padding : UIEdgeInsets
    
    required init(_ padding: UIEdgeInsets = UIEdgeInsets(top: 2, left: 5, bottom: 2, right: 5)) {
        self.padding = padding
        super.init(frame: CGRect.zero)
    }
    
    // MARK: initialisers
    
    override init(frame: CGRect) {
        padding = UIEdgeInsets.zero
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        padding = UIEdgeInsets.zero
        super.init(coder: coder)
    }
    override var intrinsicContentSize: CGSize {
        let superContentSize = super.intrinsicContentSize
        let width = superContentSize.width + padding.left + padding.right
        let heigth = superContentSize.height + padding.top + padding.bottom
        return CGSize(width: width, height: heigth)
    }
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let superSizeThatFits = super.sizeThatFits(size)
        let width = superSizeThatFits.width + padding.left + padding.right
        let heigth = superSizeThatFits.height + padding.top + padding.bottom
        return CGSize(width: width, height: heigth)
    }
}
