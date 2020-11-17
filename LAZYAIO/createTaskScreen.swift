//
//  createTaskScreen.swift
//  LAZYAIO
//
//  Created by Joshua Alanis on 2020-10-29.
//

import UIKit
import Firebase
import DropDown

protocol taskCounted {
    func taskCountNum(taskCounter: [String])
}

class createTaskScreen: UIViewController, selectedFootsite, selectedShopifySite, customSiteURL {

    @IBOutlet weak var supremeBtn: UIButton!
    @IBOutlet weak var footlockerBtn: UIButton!
    @IBOutlet weak var shopifyBtn: UIButton!
    @IBOutlet weak var yeezyBtn: UIButton!
    @IBOutlet weak var walmartBtn: UIButton!
    @IBOutlet weak var customBtn: UIButton!
    
    @IBOutlet weak var keywords: UITextField!
    @IBOutlet weak var size: UITextField!
    @IBOutlet weak var taskCount: UITextField!
    
    @IBOutlet weak var modeSelect: UIButton!
    @IBOutlet weak var profileSelect: UIButton!
    @IBOutlet weak var createTask: UIButton!
    @IBOutlet weak var releaseType: UISegmentedControl!

    var siteSelected: String = ""
    var modeSelected: String = ""
    var profileSelected: String = ""
    var releaseTypeSelected: String = ""
    var loadProfiles = [getProfileInfo]()
    var loadProfileName = [String]()
    
    var optionSelected: String = ""
    var taskNum: String = ""
    
    var taskDelegate: taskCounted!
    
    let profileDropDown = DropDown()
    let modeDropDown = DropDown()
    
    let db = Firestore.firestore()
    
    //Set Status Bar Elements to Light
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "CREATE TASK"
        
        modeSelect.layer.cornerRadius = 10
        profileSelect.layer.cornerRadius = 10
        createTask.layer.cornerRadius = 10
        
        profileDropDown.dismissMode = .automatic
        modeDropDown.dismissMode = .automatic
        
        keywords.attributedPlaceholder = NSAttributedString(string: "+add,+keywords",attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
        profiles()
        
        let sec = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + sec) {
            self.profileNames()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func footsiteData(footsiteName: String) {
        optionSelected = footsiteName
    }
    
    func shopifyData(shopifyName: String) {
        optionSelected = shopifyName
    }
    
    func customSiteData(websiteURL: String) {
        optionSelected = websiteURL
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if ((notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= 90
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    
    @objc func DismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_textFeld: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    @IBAction func supremeSiteClicked(_ sender: Any) {
        supremeBtn.layer.borderWidth = 2.0
        supremeBtn.layer.borderColor = UIColor.systemBlue.cgColor

        siteSelected = "https://www.supremenewyork.com/shop/all"
        optionSelected = "Supreme US"
        
        footlockerBtn.layer.borderWidth = 2.0
        footlockerBtn.layer.borderColor = UIColor.clear.cgColor
        
        shopifyBtn.layer.borderWidth = 2.0
        shopifyBtn.layer.borderColor = UIColor.clear.cgColor
        
        yeezyBtn.layer.borderWidth = 2.0
        yeezyBtn.layer.borderColor = UIColor.clear.cgColor
        
        walmartBtn.layer.borderWidth = 2.0
        walmartBtn.layer.borderColor = UIColor.clear.cgColor
        
        customBtn.layer.borderWidth = 2.0
        customBtn.layer.borderColor = UIColor.clear.cgColor
    }
    @IBAction func footlockerSiteClicked(_ sender: Any) {
        footlockerBtn.layer.borderWidth = 2.0
        footlockerBtn.layer.borderColor = UIColor.systemBlue.cgColor
        
        openFootsiteOptions()
        
        siteSelected = "https://www.footlocker.com/category/mens/new-arrivals.html"
        
        supremeBtn.layer.borderWidth = 2.0
        supremeBtn.layer.borderColor = UIColor.clear.cgColor
        
        shopifyBtn.layer.borderWidth = 2.0
        shopifyBtn.layer.borderColor = UIColor.clear.cgColor
        
        yeezyBtn.layer.borderWidth = 2.0
        yeezyBtn.layer.borderColor = UIColor.clear.cgColor
        
        walmartBtn.layer.borderWidth = 2.0
        walmartBtn.layer.borderColor = UIColor.clear.cgColor
        
        customBtn.layer.borderWidth = 2.0
        customBtn.layer.borderColor = UIColor.clear.cgColor
    }
    @IBAction func shopifySiteClicked(_ sender: Any) {
        shopifyBtn.layer.borderWidth = 2.0
        shopifyBtn.layer.borderColor = UIColor.systemBlue.cgColor
        
        openShopifyOptions()
        
        supremeBtn.layer.borderWidth = 2.0
        supremeBtn.layer.borderColor = UIColor.clear.cgColor
        
        footlockerBtn.layer.borderWidth = 2.0
        footlockerBtn.layer.borderColor = UIColor.clear.cgColor

        yeezyBtn.layer.borderWidth = 2.0
        yeezyBtn.layer.borderColor = UIColor.clear.cgColor
        
        walmartBtn.layer.borderWidth = 2.0
        walmartBtn.layer.borderColor = UIColor.clear.cgColor
        
        customBtn.layer.borderWidth = 2.0
        customBtn.layer.borderColor = UIColor.clear.cgColor
    }
    @IBAction func yeezySiteClicked(_ sender: Any) {
        yeezyBtn.layer.borderWidth = 2.0
        yeezyBtn.layer.borderColor = UIColor.systemBlue.cgColor
        
        siteSelected = "https://www.yeezysupply.com"
        optionSelected = "YeezySupply"
        
        supremeBtn.layer.borderWidth = 2.0
        supremeBtn.layer.borderColor = UIColor.clear.cgColor
        
        shopifyBtn.layer.borderWidth = 2.0
        shopifyBtn.layer.borderColor = UIColor.clear.cgColor
        
        footlockerBtn.layer.borderWidth = 2.0
        footlockerBtn.layer.borderColor = UIColor.clear.cgColor
        
        walmartBtn.layer.borderWidth = 2.0
        walmartBtn.layer.borderColor = UIColor.clear.cgColor
        
        customBtn.layer.borderWidth = 2.0
        customBtn.layer.borderColor = UIColor.clear.cgColor
    }
    @IBAction func walmartSiteClicked(_ sender: Any) {
        walmartBtn.layer.borderWidth = 2.0
        walmartBtn.layer.borderColor = UIColor.systemBlue.cgColor
        
        siteSelected = "https://www.walmart.com"
        optionSelected = "Walmart"
        
        supremeBtn.layer.borderWidth = 2.0
        supremeBtn.layer.borderColor = UIColor.clear.cgColor
        
        shopifyBtn.layer.borderWidth = 2.0
        shopifyBtn.layer.borderColor = UIColor.clear.cgColor
        
        yeezyBtn.layer.borderWidth = 2.0
        yeezyBtn.layer.borderColor = UIColor.clear.cgColor
        
        footlockerBtn.layer.borderWidth = 2.0
        footlockerBtn.layer.borderColor = UIColor.clear.cgColor
        
        customBtn.layer.borderWidth = 2.0
        customBtn.layer.borderColor = UIColor.clear.cgColor
    }
    @IBAction func customSiteClicked(_ sender: Any) {
        customBtn.layer.borderWidth = 2.0
        customBtn.layer.borderColor = UIColor.systemBlue.cgColor
        
        openCustomSiteOptions()
        optionSelected = "Custom Site"
        
        supremeBtn.layer.borderWidth = 2.0
        supremeBtn.layer.borderColor = UIColor.clear.cgColor
        
        shopifyBtn.layer.borderWidth = 2.0
        shopifyBtn.layer.borderColor = UIColor.clear.cgColor
        
        yeezyBtn.layer.borderWidth = 2.0
        yeezyBtn.layer.borderColor = UIColor.clear.cgColor
        
        walmartBtn.layer.borderWidth = 2.0
        walmartBtn.layer.borderColor = UIColor.clear.cgColor
        
        footlockerBtn.layer.borderWidth = 2.0
        footlockerBtn.layer.borderColor = UIColor.clear.cgColor
    }
    
    @IBAction func backClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func homeClicked(_ sender: Any) {
        self.transitionToMain()
    }
    @IBAction func taskClicked(_ sender: Any) {
        self.transitionToTasks()
    }
    @IBAction func proxyClicked(_ sender: Any) {
        self.transitionToProxies()
    }
    @IBAction func profileClicked(_ sender: Any) {
        self.transitionToProfile()
    }
    
    @IBAction func releaseTypeControl(_ sender: Any) {
        switch releaseType.selectedSegmentIndex
            {
            case 0:
                releaseTypeSelected = "Normal"
            case 1:
                releaseTypeSelected = "Queue"
            default:
                break
            }
    }
    @IBAction func selectProfileClicked(_ sender: UIButton) {
        profileDropDown.dataSource = loadProfileName//4
        profileDropDown.anchorView = sender as AnchorView //5
        profileDropDown.bottomOffset = CGPoint(x: 0, y: (sender as AnyObject).frame.size.height) //6
        profileDropDown.show() //7
        profileDropDown.selectionAction = { [weak self] (index: Int, item: String) in //8
              guard let _ = self else { return }
                (sender as AnyObject).setTitle(item, for: .normal) //9
            }
    }
    
    @IBAction func modeSelectClicked(_ sender: UIButton) {
        modeDropDown.dataSource = ["Select", "Normal", "Safe", "Request", "Hybrid"]//4
        modeDropDown.anchorView = sender as AnchorView //5
        modeDropDown.bottomOffset = CGPoint(x: 0, y: (sender as AnyObject).frame.size.height) //6
        modeDropDown.show() //7
        modeDropDown.selectionAction = { [weak self] (index: Int, item: String) in //8
              guard let _ = self else { return }
                (sender as AnyObject).setTitle(item, for: .normal)//9
            }
    }
    
    @IBAction func createTaskClicked(_ sender: Any) {
        profileSelected = profileSelect.currentTitle!
        modeSelected = modeSelect.currentTitle!

        var ref: DocumentReference? = nil
        ref = db.collection("tasks").addDocument(data: [
            "site": siteSelected,
            "releaseType": releaseTypeSelected,
            "keywords": keywords.text!,
            "itemSize": size.text!,
            "taskMode": modeSelected,
            "profileUsed": profileSelected,
            "sitePicked": optionSelected,
            "taskCount": taskCount.text!
        ]) { err in
            if err != nil {
                self.createTask.setTitle("Error!", for: .normal)
                self.createTask.backgroundColor = UIColor.systemRed

                let sec = 1.0
                DispatchQueue.main.asyncAfter(deadline: .now() + sec) {
                    self.createTask.setTitle("Create Task", for: .normal)
                    self.createTask.backgroundColor = UIColor.systemGreen
                }
            } else {
                self.createTask.setTitle("Task Created!", for: .normal)

                let sec = 1.0
                DispatchQueue.main.asyncAfter(deadline: .now() + sec) {
                    self.createTask.setTitle("Create Task", for: .normal)
                    self.createTask.backgroundColor = UIColor.systemGreen
                }
            }
        }
    }
    
    func transitionToMain() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "mainScreen") as! mainScreen
        
        let navController = UINavigationController(rootViewController: newViewController)
        
        navController.modalPresentationStyle = .fullScreen
        navController.modalTransitionStyle = .crossDissolve
        
        self.present(navController, animated: true, completion: nil)
    }
    
    func transitionToTasks() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let taskScreenController = storyBoard.instantiateViewController(withIdentifier: "taskScreen") as! taskScreen
        
        let navController = UINavigationController(rootViewController: taskScreenController)
        
        navController.modalPresentationStyle = .fullScreen
        navController.modalTransitionStyle = .crossDissolve
        
        self.present(navController, animated: true, completion: nil)
    }
    
    func transitionToProxies() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let taskScreenController = storyBoard.instantiateViewController(withIdentifier: "proxyScreen") as! proxyScreen
        
        let navController = UINavigationController(rootViewController: taskScreenController)
        
        navController.modalPresentationStyle = .fullScreen
        navController.modalTransitionStyle = .crossDissolve
        
        self.present(navController, animated: true, completion: nil)
    }
    
    func transitionToProfile() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let profileScreenController = storyBoard.instantiateViewController(withIdentifier: "profileScreen") as! profileScreen
        
        let navController = UINavigationController(rootViewController: profileScreenController)
        
        navController.modalPresentationStyle = .fullScreen
        navController.modalTransitionStyle = .crossDissolve
        
        self.present(navController, animated: true, completion: nil)
    }
    
    func openFootsiteOptions() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let footsiteSelectController = storyBoard.instantiateViewController(withIdentifier: "footsiteSelectPopup") as! footsiteSelectPopup
        
        footsiteSelectController.footsiteDelegate = self
        
        footsiteSelectController.modalPresentationStyle = .overCurrentContext
        footsiteSelectController.modalTransitionStyle = .crossDissolve
        
        self.present(footsiteSelectController, animated: true, completion: nil)
    }
    
    func openShopifyOptions() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let shopifySelectController = storyBoard.instantiateViewController(withIdentifier: "shopifySelectPopup") as! shopifySelectPopup
        
        shopifySelectController.shopifyDelegate = self
        
        shopifySelectController.modalPresentationStyle = .overCurrentContext
        shopifySelectController.modalTransitionStyle = .crossDissolve
        
        self.present(shopifySelectController, animated: true, completion: nil)
    }
    
    func openCustomSiteOptions() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let customSiteSelectController = storyBoard.instantiateViewController(withIdentifier: "customSiteSelectPopup") as! customSiteSelectPopup
        
        customSiteSelectController.customSiteDelegate = self
        
        customSiteSelectController.modalPresentationStyle = .overCurrentContext
        customSiteSelectController.modalTransitionStyle = .crossDissolve
        
        self.present(customSiteSelectController, animated: true, completion: nil)
    }
    
    func profiles() {
        db.collection("profiles").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for profile in querySnapshot!.documents {
                    
                    let profileInfo = getProfileInfo()
                    
                    let dictionary = profile.data() as [String : Any]
                    
                    profileInfo.profileName = dictionary["profileName"] as? String
                    profileInfo.firstName = dictionary["firstName"] as? String
                    profileInfo.lastName = dictionary["lastName"] as? String
                    profileInfo.email = dictionary["email"] as? String
                    profileInfo.address = dictionary["address"] as? String
                    profileInfo.zip = dictionary["zip"] as? String
                    profileInfo.city = dictionary["city"] as? String
                    profileInfo.province = dictionary["province"] as? String
                    profileInfo.country = dictionary["country"] as? String
                    profileInfo.phoneNum = dictionary["phoneNum"] as? String
                    profileInfo.cardNum = dictionary["cardNumber"] as? String
                    profileInfo.securityCode = dictionary["securityCode"] as? String
                    profileInfo.expDate = dictionary["expDate"] as? String
                    
                    self.loadProfiles.append(profileInfo)
                    
                }
            }
        }
    }
    
    func profileNames() {
        db.collection("profiles").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for profile in querySnapshot!.documents {
                    
                    let profileInfo = profile.data()
                    
                    let profileName = profileInfo["profileName"] as! String
                    
                    self.loadProfileName.append(profileName)
                    
                }
            }
        }
    }
}
