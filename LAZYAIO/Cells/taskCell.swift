//
//  taskCell.swift
//  LAZYAIO
//
//  Created by Joshua Alanis on 2020-11-03.
//

import UIKit
import Alamofire
import SwiftyJSON
import WebKit
import Firebase

class taskCell: UITableViewCell, WKNavigationDelegate {

    @IBOutlet weak var taskView: UIView!
    @IBOutlet weak var siteName: UILabel!
    @IBOutlet weak var itemSize: UILabel!
    @IBOutlet weak var chosenMode: UILabel!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var releaseType: UILabel!
    @IBOutlet weak var taskStatus: UILabel!
    @IBOutlet weak var taskImage: UIImageView!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var stopBtn: UIButton!
    @IBOutlet weak var cloneBtn: UIButton!
    
    let db = Firestore.firestore()
    var siteURL = ""
    var keywords = ["Hanes", "Tagless", "Tees"]
    var test = "Medium"
    var colour = "White"
    
    var discordTest = "Success!"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        webView.navigationDelegate = self
        webView.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func startTaskClicked(_ sender: Any) {
        taskStatus.text = "Starting"
        taskStatus.textColor = UIColor.systemGreen
        
        let sitePicked = siteName.text!
        
        jsonRequest(siteName: sitePicked)
        
    }
    
    @IBAction func stopTaskClicked(_ sender: Any) {
        taskStatus.text = "Stopped"
        taskStatus.textColor = UIColor.systemRed
    }
    
    func jsonRequest(siteName:String) {
        
        switch siteName {
        
        case "Footlocker US":
            let url = URL(string: "https://www.footlocker.com/category/new-arrivals.html")
            let request = URLRequest(url:url!)
            
            webView.load(request)
            
            
        case "Footlocker CA":
            let url = URL(string: "https://www.footlocker.ca/en/category/new-arrivals.html")
            let request = URLRequest(url:url!)
            
            webView.load(request)
            
        case "Champs Sports":
            let url = URL(string: "https://www.champssports.com/category/mens/new-arrivals.html")
            let request = URLRequest(url:url!)
            
            webView.load(request)
            
        case "FootAction":
            let url = URL(string: "https://www.footaction.com/category/new-arrivals.html")
            let request = URLRequest(url:url!)
            
            webView.load(request)
            
        case "EastBay":
            let url = URL(string: "https://www.eastbay.com/category/new-releases.html")
            let request = URLRequest(url:url!)
            
            webView.load(request)
            
        case "YeezySupply":
            let url = URL(string: "https://www.yeezysupply.com")
            let request = URLRequest(url:url!)
            
            webView.load(request)
            
        case "Walmart":
            let url = URL(string: "https://www.walmart.com")
            let request = URLRequest(url:url!)
            
            webView.load(request)
            
        case "Custom Site":
            let url = URL(string: siteURL)
            let request = URLRequest(url:url!)
            
            webView.load(request)
            
        case "Supreme US":
            
            let url = URL(string: "https://www.supremenewyork.com/shop/all")
            let request = URLRequest(url:url!)
            
            webView.load(request)
            
            AF.request("https://www.supremenewyork.com/mobile_stock.json").responseJSON { response in
                
                switch response.result {
                case .success(let value):
                    let jsonResponse = JSON(value)
                    
                    for item in jsonResponse["products_and_categories"]["Accessories"].arrayValue
                    {
                        let itemName = item["name"].stringValue
                        let itemID = item["id"].stringValue
                        
//                        print("Item Name: \(itemName), ID: \(itemID)")
                        
                        let keywordItem = self.keywords.contains(where: {itemName.contains($0)})
                        
                        if (keywordItem == true)
                        {
                            for name in self.keywords where itemName.contains(name) {
                                
                                if (name == itemName) {
                                    print(name)
                                }
                                
                                self.taskStatus.text = "Item Found"
                                self.taskStatus.textColor = UIColor.systemGreen
                                
                                AF.request("https://www.supremenewyork.com/shop/\(itemID).json").responseJSON { response in
                                    
                                    switch response.result {
                                    
                                    case .success(let value):
                                        let jsonNew = JSON(value)
                                        
                                        if jsonNew["styles"].array != nil {
                                            
                                            for name in jsonNew["styles"].arrayValue {
                                                let itemColour = name["name"].stringValue
                                                let itemStyleID = name["id"].stringValue
                                                
                                                for size in name["sizes"].arrayValue {
                                                    let sizeName = size["name"].stringValue
                                                    let sizeID = size["id"].stringValue
                                                    
                                                    if(self.test == sizeName && self.colour == itemColour) {
                                                        
                                                        print("Item Name: \(itemName), Item Colour: \(itemColour), Colour ID: \(itemStyleID), Size: \(sizeName), Size ID: \(sizeID)")
                                                    }
                                                }
                                            }
                                        }
                                    default:
                                        print("Oops!")
                                    }
                                }
                            }
                        }
                    }
                    
                case .failure(let error):
                    print(error)
                }
            }
        default:
            print("Something went Wrong!")
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.taskStatus.text = "Page Loaded"
        self.taskStatus.textColor = UIColor.systemGreen
        
        sendWebhook()
        
    }
    
    func getSiteInfo() {
        let ref = db.collection("tasks")
        ref.getDocuments { (snapshot, err) in
              if let err = err {
                  print("Error getting documents: \(err)")
              } else {
                  for document in snapshot!.documents {
                        let siteURL = document.get("site") as! String
                        self.siteURL = siteURL
                  }
              }
        }
    }
    
    func sendWebhook() {
        guard let url = URL(string: "https://discord.com/api/webhooks/733177673546989578/Na9pY3mmqUtfuZOCKf99M9wQ5l86z1-UVwzArlH-RDkwV0NYVadmfKCoSeQLE4rngqay") else { return }
        let messageJson: [String: Any] = ["embeds": ["title": discordTest]]
            let jsonData = try? JSONSerialization.data(withJSONObject: messageJson)
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "content-type")
            request.httpBody = jsonData
            let task = URLSession.shared.dataTask(with: request)
            task.resume()
    }
}
