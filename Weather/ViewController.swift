//
//  ViewController.swift
//  Weather
//
//  Created by Alush Benitez on 7/10/18.
//  Copyright © 2018 Alush Benitez. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var forecasts = [[String: String]]()
    let apiKey = "2e3355c39a38140bd9aac9d85b18b909"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Forecasts"
        let query = "https://api.darksky.net/forecast/\(apiKey)/41.8781,-87.6298"
        
        if let url = URL(string: query) {
            if let data = try? Data(contentsOf: url) {
                let json = try! JSON(data: data)
                if json["status"] == "ok" {
                    parse(json: json)
                    return
                }
            }
        }
        loadError()
    }
    
    func parse(json: JSON) {
        for result in json["hourly"].arrayValue{
            let summary = result["summary"].stringValue
            let icon = result["icon"].stringValue
            let data = result["data"].stringValue
            let forecast = ["summary": summary, "icon": icon, "data": data]
            self.forecasts.append(forecast)
        }
        self.tableView.reloadData()

    }
    
    func loadError() {
        let alert = UIAlertController(title: "Loading Error",
                                      message: "There was a problem loading the news feed",
                                      preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

