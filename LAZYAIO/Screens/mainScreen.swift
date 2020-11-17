//
//  mainScreen.swift
//  LAZYAIO
//
//  Created by Joshua Alanis on 2020-10-28.
//

import UIKit
import Firebase

class mainScreen: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var taskTableView: UITableView!
    @IBOutlet weak var successTableView: UITableView!
    
    let db = Firestore.firestore()
    
    var taskName = [getTasksInfo]()
    var successName = ["Jordan 1"]
    
    //Set Status Bar Elements to Light
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Home"
        
        taskTableView.delegate = self
        taskTableView.dataSource = self
        successTableView.delegate = self
        successTableView.dataSource = self
        
        getTasks()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (taskName.count)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 97.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == taskTableView,
           let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell") as? mainTaskCell {
            
            cell.taskView.layer.borderWidth = 4.0
            cell.taskView.layer.borderColor = UIColor.clear.cgColor
            
            let tasks = taskName[indexPath.row]
            
            cell.siteName.text = tasks.siteSelected
            cell.size.text = tasks.itemSize
            cell.skuValue.text = tasks.modeChosen
            cell.profileName.text = tasks.profileUsed

            return cell
            
        } else if tableView == successTableView,
                  let cell = tableView.dequeueReusableCell(withIdentifier: "successCell") as? successMainCell {
            
            cell.successView.layer.borderWidth = 4.0
            cell.successView.layer.borderColor = UIColor.clear.cgColor
            
            cell.itemName.text = "Air Jordan 1 'Mocha'"
            cell.itemSize.text = "9"
            cell.profileName.text = "SUPREMO"
            
            
            return cell
        }
        
        return UITableViewCell()
    }

    @IBAction func homeClicked(_ sender: Any) {
        self.transitionToMain()
    }
    
    @IBAction func logoutClicked(_ sender: Any) {
        self.transitionToLogin()
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
    
    @IBAction func helpClicked(_ sender: Any) {
        let alert = UIAlertController(title: "Whats Wrong?", message: nil, preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Enter Problem..."
        }
        
        alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func transitionToMain() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mainScreenController = storyBoard.instantiateViewController(withIdentifier: "mainScreen") as! mainScreen
        
        let navController = UINavigationController(rootViewController: mainScreenController)
        
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
    
    func getTasks() {
        db.collection("tasks").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for task in querySnapshot!.documents {
                    
                    let tasksInfo = getTasksInfo()
                    
                    let dictionary = task.data() as [String : Any]
                    
                    tasksInfo.siteSelected = dictionary["sitePicked"] as? String
                    tasksInfo.itemSize = dictionary["itemSize"] as? String
                    tasksInfo.profileUsed = dictionary["profileUsed"] as? String
                    tasksInfo.modeChosen = dictionary["taskMode"] as? String

                    self.taskName.append(tasksInfo)
                    
                    DispatchQueue.main.async {
                        self.taskTableView.reloadData()
                    }
                }
            }
        }
    }
}
