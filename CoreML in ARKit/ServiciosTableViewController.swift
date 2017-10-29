//
//  ServiciosTableViewController.swift
//  CoreML in ARKit
//
//  Created by Ivo Reyes Román on 10/29/17.
//  Copyright © 2017 CompanyName. All rights reserved.
//

import UIKit

class Service {
    let id: Int
    let icon: String
    let name: String
    let intent: String
    let slogan: String
    let description: String
    
    init(dict: [String: Any]) {
        self.id = dict["id"] as! Int
        self.icon = dict["icon"] as! String
        self.name = dict["name"] as! String
        self.slogan = dict["slogan"] as! String
        self.intent = dict["intent"] as! String
        self.description = dict["description"] as! String
    }
}

class ServiciosTableViewController: UITableViewController {

    var entries: [Service]?
    let host = "http://309e0da5.ngrok.io"
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "ServicioTableViewCell", bundle: nil), forCellReuseIdentifier: "servicioCell")
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        self.tableView.backgroundView = refreshControl
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.entries == nil {
            return 0
        } else {
            return self.entries!.count
        }
    }
    
    @objc func refresh(_ refreshControl: UIRefreshControl) {
        loadEntries()
    }
    
    func loadEntries() {
        let url = URL(string: self.host + "/api/v1/products")
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if let data = data {
                do {
                    // Convert the data to JSON
                    let jsonSerialized = try JSONSerialization.jsonObject(with: data, options: []) as? Array<[String: Any]>
                    
                    self.entries = jsonSerialized!.map { dict in
                        let service = Service(dict: dict)
                        print(service.id)
                        return service
                    }
                   
                    
                    DispatchQueue.main.async {
                        self.refreshControl?.endRefreshing()
                        self.tableView.reloadData()
//                        self.tableView.refreshControl = nil
//                        self.refreshControl?.removeFromSuperview()
                    }
                    
                }  catch let error as NSError {
                    print(error.localizedDescription)
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        
        task.resume()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "servicioCell", for: indexPath) as! ServicioTableViewCell

        cell.titleLabel.text = self.entries![indexPath.row].name
        cell.descriptionLabel.text = self.entries![indexPath.row].slogan
        
//        let imgTitle = self.entries![indexPath.row].intent
//        let filePath = Bundle.main.path(forResource: imgTitle, ofType: "png")
        
//        cell.imgView = UIImageView(image: UIImage(contentsOfFile: filePath!))
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = URL(string: "https://api.tropo.com/1.0/sessions?action=create&token=47746c754f6f746472676663556e6a77546c4b5450694b746c647777434f53655459465548625a5374485347&numberToDial=5215571083907&otherNumber=5212222938191&userName=Martin")
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if let data = data {
                do {
                    
                    
                }  catch let error as NSError {
                    print(error.localizedDescription)
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        
        task.resume()
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
