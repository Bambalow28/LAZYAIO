//
//  adminOnlyAccess.swift
//  LAZYAIO
//
//  Created by Joshua Alanis on 2020-11-16.
//

import UIKit
import Firebase

class adminOnlyAccess: UIViewController {

    @IBOutlet weak var genKeyBtn: UIButton!
    @IBOutlet weak var saveKeyBtn: UIButton!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var genKeyText: UITextField!
    @IBOutlet weak var activeUsersCount: UILabel!
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "ADMIN"
        
        activeUsers()
        genKeyBtn.layer.cornerRadius = 10
        saveKeyBtn.layer.cornerRadius = 10
    }
    
    @IBAction func logoutClicked(_ sender: Any) {
        transitionToLogin()
    }
    
    func transitionToLogin() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loginController = storyBoard.instantiateViewController(withIdentifier: "loginScreen") as! loginScreen
        
        view.window?.rootViewController = loginController
        view.window?.makeKeyAndVisible()
    }

    @IBAction func genKey(_ sender: Any) {
        genKeyText.text = keyGenerator(length: 16)
        
        self.genKeyBtn.setTitle("Generated!", for: .normal)
        self.genKeyBtn.backgroundColor = UIColor.systemGreen
        
        let sec = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + sec) {
            self.genKeyBtn.setTitle("Generate", for: .normal)
            self.genKeyBtn.backgroundColor = UIColor.systemBlue
        }
    }
    
    @IBAction func saveToDatabase(_ sender: Any) {
        
        let ref = db.collection("adminAccess")
        
        ref.document(genKeyText.text!).setData([
            "Email": email.text!,
            "Key": genKeyText.text!
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                self.saveKeyBtn.setTitle("Saved!", for: .normal)
                self.saveKeyBtn.backgroundColor = UIColor.systemGreen
                
                let sec = 1.0
                DispatchQueue.main.asyncAfter(deadline: .now() + sec) {
                    self.saveKeyBtn.setTitle("Save Key To Database", for: .normal)
                    self.saveKeyBtn.backgroundColor = UIColor.systemBlue
                }
            }
        }
    }
    
    func keyGenerator(length: Int) -> String {
      let keys = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in keys.randomElement()! })
    }
    
    func activeUsers() {
        let ref = db.collection("adminAccess")
        
        ref.getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    var users = 0
                    for _ in querySnapshot!.documents {
                        users += 1
                    }
                    
                    self.activeUsersCount.text! = ("\(users)")
                }
        }
    }
}
