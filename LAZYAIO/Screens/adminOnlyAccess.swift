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
    @IBOutlet weak var genKeyText: UITextField!
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "ADMIN"
        
        genKeyBtn.layer.cornerRadius = 10
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
    }
    
    @IBAction func saveToDatabase(_ sender: Any) {
        
        let ref = db.collection("adminAccess")
        
        ref.document().setData([
            "Key": genKeyText.text!
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                self.genKeyBtn.setTitle("Generated!", for: .normal)
                self.genKeyBtn.backgroundColor = UIColor.systemGreen
                
                let sec = 1.0
                DispatchQueue.main.asyncAfter(deadline: .now() + sec) {
                    self.genKeyBtn.setTitle("Generate", for: .normal)
                    self.genKeyBtn.backgroundColor = UIColor.systemBlue
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
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                    }
                }
        }
    }
}
