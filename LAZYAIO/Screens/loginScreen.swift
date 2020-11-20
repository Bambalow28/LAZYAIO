//
//  ViewController.swift
//  LAZYAIO
//
//  Created by Joshua Alanis on 2020-10-28.
//

import UIKit
import Firebase

class loginScreen: UIViewController {
    
    @IBOutlet weak var keyInput: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    let db = Firestore.firestore()
    
    //Set Status Bar Elements to Light
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        keyInput.attributedPlaceholder = NSAttributedString(string: "XXXX-XXXX-XXXX-XXXX",attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))
            
            view.addGestureRecognizer(tap)
        
        loginBtn.layer.cornerRadius = 10
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

    @IBAction func loginClicked(_ sender: Any) {
        keyAuthentication()
        
        switch(keyInput.text!) {
        
        case "testing":
            loginBtn.setTitle("Success!", for: .normal)
            loginBtn.layer.backgroundColor = UIColor.systemGreen.cgColor
            
            let sec = 1.0
            DispatchQueue.main.asyncAfter(deadline: .now() + sec) {
                self.transitionToMain()
            }
        
        case "admin":
            loginBtn.setTitle("Success!", for: .normal)
            loginBtn.layer.backgroundColor = UIColor.systemGreen.cgColor
            
            let sec = 1.0
            DispatchQueue.main.asyncAfter(deadline: .now() + sec) {
                self.transitionToAdmin()
            }
            
        default:
            loginBtn.setTitle("Invalid Key!", for: .normal)
            loginBtn.layer.backgroundColor = UIColor.systemRed.cgColor
            
            let sec = 1.0
            DispatchQueue.main.asyncAfter(deadline: .now() + sec) {
                self.loginBtn.setTitle("Login", for: .normal)
                self.loginBtn.layer.backgroundColor = UIColor.systemIndigo.cgColor
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
    
    func transitionToAdmin() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let adminController = storyBoard.instantiateViewController(withIdentifier: "adminOnlyAccess") as! adminOnlyAccess
        
        let navController = UINavigationController(rootViewController: adminController)
        
        navController.modalPresentationStyle = .fullScreen
        navController.modalTransitionStyle = .crossDissolve
        
        self.present(navController, animated: true, completion: nil)
    }
    
    func keyAuthentication() {
        db.collection("adminAccess").getDocuments() { (keys, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for key in keys!.documents {
                    print("Key: \(key)")
                }
            }
        }
    }
}

