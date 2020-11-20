//
//  editTaskScreen.swift
//  LAZYAIO
//
//  Created by Joshua Alanis on 2020-11-18.
//

import UIKit

class editTaskScreen: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "EDIT TASK"
    }
    
    @IBAction func homeClicked(_ sender: Any) {
        transitionToMain()
    }
    @IBAction func tasksClicked(_ sender: Any) {
        transitionToTasks()
    }
    @IBAction func proxyClicked(_ sender: Any) {
        transitionToProxies()
    }
    @IBAction func profileClicked(_ sender: Any) {
        transitionToProfile()
    }
    
    @IBAction func returnClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
}
