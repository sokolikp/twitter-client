//
//  HamburgerViewController.swift
//  twitter-client
//
//  Created by Paul Sokolik on 10/6/17.
//  Copyright © 2017 Paul Sokolik. All rights reserved.
//

import UIKit

class HamburgerViewController: UIViewController {

    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var leftMarginConstraint: NSLayoutConstraint!
    var originalLeftMargin: CGFloat!
    var menuViewController: UIViewController! {
        didSet {
            view.layoutIfNeeded()
            menuView.addSubview(menuViewController.view)
        }
    }
    var contentViewController: UIViewController! {
        didSet {
            view.layoutIfNeeded()
            contentView.addSubview(contentViewController.view)
            UIView.animate(withDuration: 0.3) {
                self.leftMarginConstraint.constant = 0
                self.view.layoutIfNeeded()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onPanGesture(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        let velocity = sender.velocity(in: view)
        
        if sender.state == .began {
            originalLeftMargin = leftMarginConstraint.constant
        } else if sender.state == .changed {
            if originalLeftMargin == 0 && velocity.x > 0 || originalLeftMargin != 0 && velocity.x < 0 {
                leftMarginConstraint.constant = originalLeftMargin + translation.x
            }
        } else if sender.state == .ended {
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.5, options: [], animations: {
                if velocity.x > 0 { // open menu
                    self.leftMarginConstraint.constant = self.view.frame.size.width * 0.75
                } else { // close menu
                    self.leftMarginConstraint.constant = 0
                }
                self.view.layoutIfNeeded()
            }, completion: nil)
           
        }
    }

}
