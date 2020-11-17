//
//  createProfile.swift
//  LAZYAIO
//
//  Created by Joshua Alanis on 2020-11-04.
//

import UIKit
import Firebase
import DropDown

class createProfile: UIViewController {
    
    @IBOutlet weak var profileName: UITextField!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var zip: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var province: UITextField!
    @IBOutlet weak var country: UITextField!
    @IBOutlet weak var phoneNum: UITextField!
    @IBOutlet weak var cardNum: UITextField!
    @IBOutlet weak var securityCode: UITextField!
    @IBOutlet weak var expDate: UITextField!
    
    @IBOutlet weak var createProfileBtn: UIButton!
    @IBOutlet weak var loadProfileBtn: UIButton!
    
    let loadProfileDropdown = DropDown()
    let db = Firestore.firestore()
    
    var profileNames = [String]()
    
    //Set Status Bar Elements to Light
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()

       title = "Create Profile"
        
        loadProfileDropdown.dismissMode = .automatic
        
        createProfileBtn.layer.cornerRadius = 10
        loadProfileBtn.layer.cornerRadius = 10
        
        getProfileInfo()
   
    }
    
    @IBAction func returnToMain(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func loadProfileClicked(_ sender: UIButton) {
        loadProfileDropdown.dataSource = profileNames//4
        loadProfileDropdown.anchorView = sender as AnchorView //5
        loadProfileDropdown.bottomOffset = CGPoint(x: 0, y: (sender as AnyObject).frame.size.height) //6
        loadProfileDropdown.show() //7
        loadProfileDropdown.selectionAction = { [weak self] (index: Int, item: String) in //8
              guard let _ = self else { return }
            
            self!.fillInfo(inputProfileName: item)
        }
    }
    
    @IBAction func createProfileClicked(_ sender: Any) {
        
        let ref = db.collection("profiles")
        
        ref.document(profileName.text!).setData([
            "profileName": profileName.text!,
            "firstName": firstName.text!,
            "lastName": lastName.text!,
            "email": email.text!,
            "address": address.text!,
            "zip": zip.text!,
            "city": city.text!,
            "province": province.text!,
            "country": country.text!,
            "phoneNum": phoneNum.text!,
            "cardNumber": cardNum.text!,
            "securityCode": securityCode.text!,
            "expDate": expDate.text!
            
        ]){ err in
            if err != nil {
                self.createProfileBtn.setTitle("Error!", for: .normal)
                self.createProfileBtn.backgroundColor = UIColor.systemRed

                let sec = 1.0
                DispatchQueue.main.asyncAfter(deadline: .now() + sec) {
                    self.createProfileBtn.setTitle("Create Profile", for: .normal)
                    self.createProfileBtn.backgroundColor = UIColor.systemGreen
                }
            } else {
                self.createProfileBtn.setTitle("Profile Created!", for: .normal)

                let sec = 1.0
                DispatchQueue.main.asyncAfter(deadline: .now() + sec) {
                    self.createProfileBtn.setTitle("Create Profile", for: .normal)
                    self.createProfileBtn.backgroundColor = UIColor.systemGreen
                }
            }
        }
    }
    
    func getProfileInfo() {
        let docRef = db.collection("profiles")

        docRef.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let test = document.documentID
                    self.profileNames.append(test)
                }
            }
        }
    }
    
    func fillInfo(inputProfileName: String) {
        let ref = db.collection("profiles")
        ref.getDocuments { (snapshot, err) in
              if let err = err {
                  print("Error getting documents: \(err)")
              } else {
                  for document in snapshot!.documents {
                     let profileName = document.documentID
                    
                    if profileName == inputProfileName {
                        let firstName = document.get("firstName") as! String
                        let lastName = document.get("lastName") as! String
                        let email = document.get("email") as! String
                        let address = document.get("address") as! String
                       let zip = document.get("zip") as! String
                       let city = document.get("city") as! String
                       let province = document.get("province") as! String
                       let country = document.get("country") as! String
                       let phoneNum = document.get("phoneNum") as! String
                       let cardNum = document.get("cardNumber") as! String
                       let secCode = document.get("securityCode") as! String
                       let expDate = document.get("expDate") as! String
                        
                        self.profileName.text = profileName
                        self.firstName.text = firstName
                        self.lastName.text = lastName
                        self.email.text = email
                        self.address.text = address
                        self.zip.text = zip
                        self.city.text = city
                        self.province.text = province
                        self.country.text = country
                        self.phoneNum.text = phoneNum
                        self.cardNum.text = cardNum
                        self.securityCode.text = secCode
                        self.expDate.text = expDate
                    }
                  }
              }
        }
    }
}
