//
//  addProxiesScreen.swift
//  LAZYAIO
//
//  Created by Joshua Alanis on 2020-11-01.
//

import UIKit

class addProxiesScreen: UIViewController {
    
    @IBOutlet weak var proxyListName: UITextField!
    @IBOutlet weak var addProxies: UITextView!
    
    //Set Status Bar Elements to Light
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "ADD PROXIES"
        
        proxyListName.attributedPlaceholder = NSAttributedString(string: "Enter Proxy Name",attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
    }
    
    @IBAction func returnClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}
