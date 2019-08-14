//
//  ViewController.swift
//  try3
//
//  Created by user157026 on 8/13/19.
//  Copyright © 2019 user157026. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var store_name: UIView!
    @IBOutlet weak var myTableView: UITableView!
    var PriceArray = [String]()
    var NameArray  = [String]()
    var ProductURL = [String]()
    
    var stopCalling = false
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PriceArray.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         getContactsData()
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        

      
        cell.textLabel?.text =   NameArray[indexPath.row] + "  " + PriceArray[indexPath.row] 
        return cell
    }
    override func viewDidLoad() {
        print(self.NameArray)
        print(self.PriceArray)
        print(self.ProductURL)
        if (!self.stopCalling )
        {
        getContactsData()
        }
        self.stopCalling = true
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let url_String = self.ProductURL[indexPath.row]
        if let url = URL(string: url_String)
        {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    func getContactsData(){
       
       /* Alamofire.request("https://api.barcodelookup.com/v2/products?barcode=9780140157376&formatted=y&key=o7ho8pwkhb1nhxp4gh26m098dhse4g",method: .get).responseJSON {
            response1 in
            if response1.result.isSuccess
            {
                print("Success")
                let jsonObject: JSON = JSON(response1.result.value!)
                //     print(jsonObject)
                if let storesArray = jsonObject["products"][0]["stores"].array {
                    for i in 0...(storesArray.count-1) {
                        var store_price = storesArray[i]["store_price"]
                        var store_name = storesArray[i]["store_name"]
                        var product_url = storesArray[i]["product_url"]
                        //       print(store_price)
                        self.NameArray.append(String(store_name.stringValue.prefix(20)));
                        self.PriceArray.append(store_price.stringValue)
                        self.ProductURL.append(product_url.stringValue)
                    }
                    print(self.NameArray)
                    print(self.PriceArray)
                    print(self.ProductURL)
                }
                
            }
           
                
            else {
                print("Error \(response1.result.error)")
            }
            
        //
 */
            Alamofire.request("https://api.barcodespider.com/v1/lookup?token=55b84a6438a390bf8f5f&upc=887276168630",method: .get).responseJSON {
                response2 in
                if response2.result.isSuccess
                {
                    print("Success")
                    let jsonObject: JSON = JSON(response2.result.value!)
                    if let storesArray = jsonObject["Stores"].array {
                        for i in 0...(storesArray.count-1) {
                            var store_price = storesArray[i]["price"]
                            var store_name = storesArray[i]["store_name"]
                            var product_url = storesArray[i]["link"]
                            //       print(store_price)
                            self.NameArray.append(String(store_name.stringValue.prefix(20)));
                            self.PriceArray.append(store_price.stringValue)
                            self.ProductURL.append(product_url.stringValue)
                        }
                        print(self.NameArray)
                        print(self.PriceArray)
                        print(self.ProductURL)
                    }
                    
                }
                else {
                    print("Error \(response2.result.error)")
                }
                
                //stop all request when data is fetched
                Alamofire.SessionManager.default.session.getAllTasks {
                    (tasks) in tasks.forEach({$0.cancel()})
                }
            if (self.stopCalling)
            {
      //      self.myTableView.reloadData()
            }
          
        }
    }

}


