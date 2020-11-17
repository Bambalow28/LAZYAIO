//
//  footsiteSelectPopup.swift
//  LAZYAIO
//
//  Created by Joshua Alanis on 2020-10-31.
//

import UIKit
import DropDown

protocol selectedFootsite {
    func footsiteData(footsiteName: String)
}

class footsiteSelectPopup: UIViewController {
    
    @IBOutlet weak var footsiteOptionsView: UIView!
    @IBOutlet weak var applyChanges: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var footsiteSelect: UIButton!
    
    var footsiteDelegate: selectedFootsite!
    
    let footsiteDropdown = DropDown()
    var footsiteDropdownSelected: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        footsiteDropdown.dismissMode = .automatic
        
        applyChanges.layer.cornerRadius = 10
        cancelBtn.layer.cornerRadius = 10
        
        footsiteOptionsView.layer.cornerRadius = 10
        footsiteOptionsView.layer.borderWidth = 1.0
        footsiteOptionsView.layer.borderColor = UIColor.gray.cgColor
        
        //only apply the blur if the user hasn't disabled transparency effects
        if !UIAccessibility.isReduceTransparencyEnabled {
            view.backgroundColor = .clear
            
            let blurEffect = UIBlurEffect(style: .dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            
            //always fill the view
            blurEffectView.frame = self.view.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            view.addSubview(blurEffectView)
            view.insertSubview(footsiteOptionsView, aboveSubview: blurEffectView)
            
        } else {
            view.backgroundColor = .black
        }
    }

    @IBAction func cancelClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectFootsiteSelected(_ sender: UIButton) {
        footsiteDropdown.dataSource = ["Select","Footlocker US","Footlocker CA","Champs Sports","FootAction","EastBay"]//4
        footsiteDropdown.anchorView = sender as AnchorView //5
        footsiteDropdown.bottomOffset = CGPoint(x: 0, y: (sender as AnyObject).frame.size.height) //6
        footsiteDropdown.show() //7
        footsiteDropdown.selectionAction = { [weak self] (index: Int, item: String) in //8
              guard let _ = self else { return }
                (sender as AnyObject).setTitle(item, for: .normal) //9
            }
    }
    
    @IBAction func appliedClicked(_ sender: Any) {
        footsiteDropdownSelected = footsiteSelect.currentTitle!
        
        footsiteDelegate.footsiteData(footsiteName: footsiteDropdownSelected)

        let sec = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + sec) {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
