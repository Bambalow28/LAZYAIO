//
//  captchaScreen.swift
//  LAZYAIO
//
//  Created by Joshua Alanis on 2020-11-06.
//

import UIKit
import WebKit

class captchaScreen: UIViewController {

    @IBOutlet weak var captchaScreenView: UIView!
    @IBOutlet weak var captchaView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: "https://www.google.ca")
            let request = URLRequest(url: url!)
            captchaView.load(request)
            self.captchaScreenView.addSubview(captchaView)
        
        captchaScreenView.layer.cornerRadius = 10
        captchaScreenView.layer.borderWidth = 1.0
        captchaScreenView.layer.borderColor = UIColor.gray.cgColor
        
        //only apply the blur if the user hasn't disabled transparency effects
        if !UIAccessibility.isReduceTransparencyEnabled {
            view.backgroundColor = .clear
            
            let blurEffect = UIBlurEffect(style: .dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            
            //always fill the view
            blurEffectView.frame = self.view.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            view.addSubview(blurEffectView)
            view.insertSubview(captchaScreenView, aboveSubview: blurEffectView)
            
        } else {
            view.backgroundColor = .black
        }
    }

}
