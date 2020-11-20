//
//  taskScreen.swift
//  LAZYAIO
//
//  Created by Joshua Alanis on 2020-10-29.
//

import UIKit
import Firebase

class taskScreen: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var captchaBtn: UIButton!
    
    let db = Firestore.firestore()
    var tasks = [getTasksInfo]()
    var countTaskCreated: String?
    
    //Set Status Bar Elements to Light
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "TASKS"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        captchaBtn.layer.cornerRadius = 10
        
        getTasks()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell") as! taskCell
        
        let taskName = tasks[indexPath.row]
        
        cell.siteName.text = taskName.siteSelected
        cell.itemSize.text = taskName.itemSize
        cell.chosenMode.text = taskName.modeChosen
        cell.profileName.text = taskName.profileUsed
        cell.releaseType.text = taskName.releaseType
        
        switch taskName.siteSelected {
        
        case "Footlocker US":
            cell.taskImage.image = UIImage(named: "footlocker")
        case "Footlocker CA":
            cell.taskImage.image = UIImage(named: "footlocker")
        case "Champs Sports":
            cell.taskImage.image = UIImage(named: "footlocker")
        case "FootAction":
            cell.taskImage.image = UIImage(named: "footlocker")
        case "EastBay":
            cell.taskImage.image = UIImage(named: "footlocker")
        case "Supreme US":
            cell.taskImage.image = UIImage(named: "supreme")
        case "YeezySupply":
            cell.taskImage.image = UIImage(named: "yeezysupply")
        case "Shopify":
            cell.taskImage.image = UIImage(named: "shopify")
        case "Walmart":
            cell.taskImage.image = UIImage(named: "walmart")
        default:
            print("Oops! Something Went Wrong!")
        }
        
        return cell
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
    
    @IBAction func createTask(_ sender: Any) {
        self.createTasks()
    }
    
    @IBAction func editTask(_ sender: Any) {
        self.transitionToEditTask()
    }
    
    @IBAction func createProfileClicked(_ sender: Any) {
        self.transitionToCreateProfile()
    }
    @IBAction func captchaClicked(_ sender: Any) {
        self.openCaptcha()
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
    
    func transitionToCreateProfile() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let createProfileController = storyBoard.instantiateViewController(withIdentifier: "createProfile") as! createProfile
        
        self.navigationController?.pushViewController(createProfileController, animated: true)
    }
    
    func createTasks() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let createTaskController = storyBoard.instantiateViewController(withIdentifier: "createTaskScreen") as! createTaskScreen
        
        self.navigationController?.pushViewController(createTaskController, animated: true)
    }
    
    func transitionToLogin() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loginController = storyBoard.instantiateViewController(withIdentifier: "loginScreen") as! loginScreen
        
        view.window?.rootViewController = loginController
        view.window?.makeKeyAndVisible()
    }
    
    func openCaptcha() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let captchaScreenController = storyBoard.instantiateViewController(withIdentifier: "captchaScreen") as! captchaScreen
        
        captchaScreenController.modalPresentationStyle = .overCurrentContext
        captchaScreenController.modalTransitionStyle = .crossDissolve
        
        self.present(captchaScreenController, animated: true, completion: nil)
    }
    
    func transitionToEditTask() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let editTaskController = storyBoard.instantiateViewController(withIdentifier: "editTaskScreen") as! editTaskScreen
        
        self.navigationController?.pushViewController(editTaskController, animated: true)
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
                    tasksInfo.releaseType = dictionary["releaseType"] as? String
                    
                    self.countTaskCreated = dictionary["taskCount"] as? String
                    
                    self.tasks.append(tasksInfo)
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
}
