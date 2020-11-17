//
//  shopifySelectPopup.swift
//  LAZYAIO
//
//  Created by Joshua Alanis on 2020-10-31.
//

import UIKit
import DropDown

protocol selectedShopifySite {
    func shopifyData(shopifyName: String)
}

class shopifySelectPopup: UIViewController {
    
    @IBOutlet weak var selectShopifyView: UIView!
    @IBOutlet weak var selectShopifySite: UIButton!
    @IBOutlet weak var applyChanges: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    var shopifyDelegate: selectedShopifySite!
    
    let shopifyDropdown = DropDown()
    var shopifySiteSelected: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        shopifyDropdown.dismissMode = .automatic
        
        applyChanges.layer.cornerRadius = 10
        cancelBtn.layer.cornerRadius = 10
        
        selectShopifyView.layer.cornerRadius = 10
        selectShopifyView.layer.borderWidth = 1.0
        selectShopifyView.layer.borderColor = UIColor.gray.cgColor
        
        //only apply the blur if the user hasn't disabled transparency effects
        if !UIAccessibility.isReduceTransparencyEnabled {
            view.backgroundColor = .clear
            
            let blurEffect = UIBlurEffect(style: .dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            
            //always fill the view
            blurEffectView.frame = self.view.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            view.addSubview(blurEffectView)
            view.insertSubview(selectShopifyView, aboveSubview: blurEffectView)
            
        } else {
            view.backgroundColor = .black
        }
    }
    
    @IBAction func selectShopifySelected(_ sender: UIButton) {
        shopifyDropdown.dataSource = ["Select","Kith", "Shoepalace", "Livestock"]//4
        shopifyDropdown.anchorView = sender as AnchorView //5
        shopifyDropdown.bottomOffset = CGPoint(x: 0, y: (sender as AnyObject).frame.size.height) //6
        shopifyDropdown.show() //7
        shopifyDropdown.selectionAction = { [weak self] (index: Int, item: String) in //8
              guard let _ = self else { return }
                (sender as AnyObject).setTitle(item, for: .normal) //9
            }
    }
    
    @IBAction func applyClicked(_ sender: Any) {
        shopifySiteSelected = selectShopifySite.currentTitle!
        
        shopifyDelegate.shopifyData(shopifyName: shopifySiteSelected)

        let sec = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + sec) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelSelected(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
