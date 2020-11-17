//
//  proxyScreen.swift
//  LAZYAIO
//
//  Created by Joshua Alanis on 2020-10-29.
//

import UIKit
import WebKit
import SwiftSoup

class proxyScreen: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var testBtn: UIButton!
    
    //Set Status Bar Elements to Light
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "PROXIES"
        
        let url = URL(string: "https://www.supremenewyork.com/shop/all/accessories")
        let request = URLRequest(url:url!)
        
        webView.load(request)
    }
    @IBAction func testClicked(_ sender: Any) {
//        let url = URL(string: "https://www.supremenewyork.com/shop/all/accessories")
//        let request = url!.absoluteString
//        do {
//            let doc: Document = try SwiftSoup.parse(request)
//            print(doc)
//            //let links: Elements = try doc.select("a[href]") // a with href
//        } catch Exception.Error(let type, let message) {
//            print(message)
//        } catch {
//            print("error")
//        }
        
        
        
        webView.evaluateJavaScript("document.querySelector('#container > li:nth-child(1) > div > div.product-name > a').click();", completionHandler: nil)
            
            //print("INNER HTML: \(value!)")
//            if let valueString = value as? String {
//                let url = URL(string: valueString)
//                let request = URLRequest(url:url!)
//
//                self.webView.load(request)
//            }
            
            //print("ERROR: \(error!)")
        //})
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
    @IBAction func addProxyClicked(_ sender: Any) {
        self.transitionToAddProxy()
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
    
    func transitionToAddProxy() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let addProxyScreenController = storyBoard.instantiateViewController(withIdentifier: "addProxiesScreen") as! addProxiesScreen
        
        self.navigationController?.pushViewController(addProxyScreenController, animated: true)
    }
    
    func transitionToLogin() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loginController = storyBoard.instantiateViewController(withIdentifier: "loginScreen") as! loginScreen
        
        view.window?.rootViewController = loginController
        view.window?.makeKeyAndVisible()
    }
    
}
