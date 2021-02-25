//
//  OnboardViewController.swift
//  NoodlesNThings
//
//  Created by Joseph Veverka on 2/25/21.
//

import UIKit

class OnboardViewController: UIViewController {
    
    //MARK: - UI Outlets -
    @IBOutlet weak var viewStartOrder: UIView!
    @IBOutlet weak var imgViewBackground: UIImageView!
    
    //MARK: - Lifecycle and Overridden Methods -
    override func viewWillAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.25) {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialView()
    }
    
    //MARK: - Class Methods -
    func setInitialView() {
        viewStartOrder.layer.cornerRadius = 16.0
        viewStartOrder.clipsToBounds = true
    }
}

