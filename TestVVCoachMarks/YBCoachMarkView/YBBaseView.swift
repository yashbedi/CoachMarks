//
//  YBBaseView.swift
//  TestVVCoachMarks
//
//  Created by Yash Bedi on 25/06/20.
//  Copyright © 2020 Yash Bedi. All rights reserved.
//

import UIKit


class YBBaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension CGRect {
    mutating func giveInternalPadding(_ byValue: CGFloat) {
        self.size.width += (2 * byValue)
        self.size.height += (2 * byValue)
        self.origin.x -= byValue
        self.origin.y -= byValue
    }
}
