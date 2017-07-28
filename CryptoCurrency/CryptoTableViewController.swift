//
//  CryptoTableViewController.swift
//  CryptoCurrency
//
//  Created by Admin on 28.07.17.
//  Copyright © 2017 Svt. All rights reserved.
//

import UIKit

class CryptoTableViewController: UITableViewController {

    let cryptoLoadURL = "https://api.coinmarketcap.com/v1/ticker/"
    var currencies = [Currency]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getLatestCurrency()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return currencies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CryptoTableViewCell
        cell.nameLabel?.text = currencies[indexPath.row].name
        cell.costLabel?.text = String(currencies[indexPath.row].priceUsd) + "$"
        // Configure the cell...

        return cell
    }
    
    func parseJsonData(data: NSData) -> [Currency] {
        do {
            let jsonResult = try JSONSerialization.jsonObject(with: data as Data, options: .allowFragments) as? NSArray
            let currency = Currency()
            //parse JsonData
            currency.name = String(describing: jsonResult?.value(forKey: "name"))
            let jsonCurrencies = jsonResult! as [AnyObject]
            for jsonCurrency in jsonCurrencies {
            let currency = Currency()
            currency.name = jsonCurrency["name"] as! String
            currency.priceUsd = jsonCurrency["price_usd"] as! String
            currencies.append(currency)
            }
        }  catch {
            print (error)
            
        }
        return currencies
    }

    
    
    func getLatestCurrency()  {
        // Создание запроса на основе ссылки
        let request = NSURLRequest(url: NSURL(string: cryptoLoadURL)! as URL)
        // Создание сессии
        let urlSession = URLSession.shared
        let task = urlSession.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if let error = error {
                print (error)
                return
            }
            // Parsing
            if let data = data {
                self.currencies = self.parseJsonData(data: data as NSData)
                OperationQueue.main.addOperation({
                    () -> Void in
                    self.tableView.reloadData()
                })
            }
            
        })
        task.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Переход
        if segue.identifier == "toChanger" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! CurrencyChangerViewController
                destinationController.currency = currencies[indexPath.row]
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Скрытие Nav.Controller`a
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = true
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
