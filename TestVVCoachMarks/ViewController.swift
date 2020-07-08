//
//  ViewController.swift
//  TestVVCoachMarks
//
//  Created by Yash Bedi on 25/06/20.
//  Copyright © 2020 Yash Bedi. All rights reserved.
//

import UIKit
import TinyConstraints



final class ViewController: UIViewController {

    @IBOutlet weak var coachMark1IB: UIButton!
    @IBOutlet weak var coachMark2IB: UIButton!
    @IBOutlet weak var coachMark3IB: UIButton!
    @IBOutlet weak var coachMark4IB: UIButton!
    @IBOutlet weak var coachMark5IB: UIButton!
    
    private var coverView : YBCoachMarkCoverView?
    private var _tag: Int = 1
    
    private lazy var window : UIWindow = {
       return UIApplication.shared.windows.first!
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        coachMark3IB.layer.cornerRadius = coachMark3IB.frame.height / 2
        coachMark5IB.layer.cornerRadius = coachMark5IB.frame.height / 2
    }
}

private extension ViewController {
    @objc private func removeCoachMark() {
        coverView?.removeFromSuperview()
    }
    func showCoachMark(for anchorView: UIView, for shape: Shapes, origin: PopOverOrigin = .bottom){
        removeCoachMark()
        coverView = YBCoachMarkCoverView(frame: window.frame)
        coverView?.delegate = self
        coverView?._tag = _tag
        coverView?.origin = origin
        
        coverView?.setMask(with:
            view.convert(anchorView.frame,
                              to: anchorView.superview),
                                shape: shape,
                                cornerRadius: shape == Shapes.circle ? 0 : anchorView.layer.cornerRadius)
        
        
//        let gesture = UITapGestureRecognizer(target: self, action: #selector(removeCoachMark))
//        coverView?.addGestureRecognizer(gesture)
        window.addSubview(coverView!)
        coverView?.edges(to: window)
    }
}

private extension ViewController {
    @IBAction func coachMark1(_ sender: Any) {
        _tag = 1
        showCoachMark(for: coachMark1IB, for: .roundedRect)
    }
}

extension ViewController : ButtonTapOnPopOver {
    func nextButtonTap(_ button: UIButton) {
        switch button.tag {
        case 1:
            _tag += 1
            showCoachMark(for: coachMark2IB, for: .roundedRect)
        case 2:
            _tag += 1
            showCoachMark(for: coachMark3IB, for: .circle)
        case 3:
            _tag += 1
            showCoachMark(for: coachMark4IB, for: .roundedRect, origin: .top)
        case 4:
            _tag += 1
            showCoachMark(for: coachMark5IB, for: .circle, origin: .top )
        case 5:
            removeCoachMark()
        default : break
        }
    }
    func prevButtonTap(_ button: UIButton) {
        switch button.tag {
        case 1:
            removeCoachMark()
        case 2:
            _tag -= 1
            showCoachMark(for: coachMark1IB, for: .roundedRect)
        case 3:
            _tag -= 1
            showCoachMark(for: coachMark2IB, for: .roundedRect)
        case 4:
            _tag -= 1
            showCoachMark(for: coachMark3IB, for: .circle)
        case 5:
            _tag -= 1
            showCoachMark(for: coachMark4IB, for: .rect, origin: .top)
        default : break
        }
    }
}
