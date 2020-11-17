//
//  profileScreen.swift
//  LAZYAIO
//
//  Created by Joshua Alanis on 2020-10-29.
//

import UIKit

class profileScreen: UIViewController {
    
    //Set Status Bar Elements to Light
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "PROFILE"
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
    @IBAction func logoutClicked(_ sender: Any) {
        self.transitionToLogin()    
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
    
    func transitionToLogin() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loginController = storyBoard.instantiateViewController(withIdentifier: "loginScreen") as! loginScreen
        
        view.window?.rootViewController = loginController
        view.window?.makeKeyAndVisible()
    }

}
