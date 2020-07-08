//
//  YBPopOverView.swift
//  TestVVCoachMarks
//
//  Created by Yash Bedi on 25/06/20.
//  Copyright © 2020 Yash Bedi. All rights reserved.
//

import UIKit

protocol ButtonTapOnPopOver : class {
    func nextButtonTap(_ button: UIButton)
    func prevButtonTap(_ button: UIButton)
}

final class YBPopOverView: YBBaseView {
    private let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.layer.cornerRadius = 4
        button.setTitleColor(.systemBlue, for: .normal)
//        button.titleEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        return button
    }()
    private let prevButton: UIButton = {
        let button = UIButton()
        button.setTitle("Prev", for: .normal)
        button.layer.cornerRadius = 4
        button.setTitleColor(.systemBlue, for: .normal)
//        button.titleEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        return button
    }()
    private let label: LabelWithPadding = {
        let label = LabelWithPadding()
        label.text = "The Data"
        label.numberOfLines = 0
        label.padding = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        label.textColor = .black
        return label
    }()
    public weak var delegate: ButtonTapOnPopOver?
    public var _tag: Int = 0
    override init(frame: CGRect) {
        super.init(frame: frame)
        nextButton.addTarget(self, action: #selector(nextButtonTap(_:)), for: .touchUpInside)
        prevButton.addTarget(self, action: #selector(prevButtonTap(_:)), for: .touchUpInside)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension YBPopOverView {
    func commonInIt(){
        setUI()
        setHierarchy()
        setConstraints()
    }
    func setUI(){
        backgroundColor = .white
        layer.cornerRadius = 4
    }
    func setHierarchy(){
        addSubview(label)
        addSubview(nextButton)
        addSubview(prevButton)
    }
    func setConstraints(){
        label.topToSuperview()
        label.leadingToSuperview()
        label.trailingToSuperview()
        
        prevButton.leadingToSuperview()
        prevButton.bottomToSuperview()
        prevButton.trailingToLeading(of: nextButton, offset: 2)
        
        nextButton.trailingToSuperview()
        nextButton.bottomToSuperview()
    }
}
extension YBPopOverView {
    override func layoutSubviews() {
        super.layoutSubviews()
        nextButton.tag = _tag
        prevButton.tag = _tag
        commonInIt()
    }
    @objc func nextButtonTap(_ sender: UIButton) {
        delegate?.nextButtonTap(sender)
    }
    @objc func prevButtonTap(_ sender: UIButton) {
        delegate?.prevButtonTap(sender)
    }
}
