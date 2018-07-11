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
        
        DispatchQueue.global(qos: .userInitiated).async {
            [unowned self] in
            if let url = URL(string: query) {
                if let data = try? Data(contentsOf: url) {
                    let json = try! JSON(data: data)
                    self.parse(json: json)
                    return
                }
            }
            self.loadError()
        }
    }
    
    func parse(json: JSON) {
        DispatchQueue.main.async {
            [unowned self] in
            print("here")
            for result in json[""].arrayValue{
                print("yay")
                let icon = result["icon"].stringValue
                let summary = result["summary"].stringValue
                let data = result["data"].stringValue
                let forecast = ["icon": icon, "summary": summary, data: "data"]
                self.forecasts.append(forecast)
                print(forecast)
            }
            self.tableView.reloadData()
        }
    }
    
    func loadError() {
        DispatchQueue.main.async {
            [unowned self] in
            let alert = UIAlertController(title: "Loading Error", message: "There was a problem loading the news feed", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let forecast = forecasts[indexPath.row]
        cell.textLabel?.text = forecast["summary"]
        cell.detailTextLabel?.text = forecast["data"]
        
        return cell
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

