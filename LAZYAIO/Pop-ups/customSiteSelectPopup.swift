//
//  customSiteSelectPopup.swift
//  LAZYAIO
//
//  Created by Joshua Alanis on 2020-11-01.
//

import UIKit

protocol customSiteURL {
    func customSiteData(websiteURL: String)
}

class customSiteSelectPopup: UIViewController {

    @IBOutlet weak var customSiteView: UIView!
    @IBOutlet weak var applyChanges: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    @IBOutlet weak var enterURL: UITextField!
    
    var customSiteDelegate: customSiteURL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        enterURL.attributedPlaceholder = NSAttributedString(string: "Enter URL",attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])

        applyChanges.layer.cornerRadius = 10
        cancelBtn.layer.cornerRadius = 10
        
        customSiteView.layer.cornerRadius = 10
        customSiteView.layer.borderWidth = 1.0
        customSiteView.layer.borderColor = UIColor.gray.cgColor
        
        //only apply the blur if the user hasn't disabled transparency effects
        if !UIAccessibility.isReduceTransparencyEnabled {
            view.backgroundColor = .clear
            
            let blurEffect = UIBlurEffect(style: .dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            
            //always fill the view
            blurEffectView.frame = self.view.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            view.addSubview(blurEffectView)
            view.insertSubview(customSiteView, aboveSubview: blurEffectView)
            
        } else {
            view.backgroundColor = .black
        }
    }
    
    @IBAction func applyClicked(_ sender: Any) {
        let customURL = self.enterURL.text!
        customSiteDelegate.customSiteData(websiteURL: customURL)
        
        let sec = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + sec) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelBtnClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
