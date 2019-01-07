//
//  CurrencyTableViewController.swift
//  Forex
//
//  Created by Lynn Phay U on 1/2/19.
//  Copyright © 2019 Lynn Phay U. All rights reserved.
//

import UIKit

class CurrencyTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var data = [
            "USD": "United State Dollar",
            "EUR": "Euro",
            "SGD": "Singapore Dollar",
            "GBP": "Pound Sterling",
            "CHF": "Swiss Franc",
            "JPY": "Japanese Yen",
            "AUD": "Australian Dollar",
            "BDT": "Bangladesh Taka",
            "BND": "Brunei Dollar",
            "KHR": "Cambodian Riel",
            "CAD": "Canadian Dollar",
            "CNY": "Chinese Yuan",
            "HKD": "Hong Kong Dollar",
            "INR": "Indian Rupee",
            "IDR": "Indonesian Rupiah",
            "KRW": "Korean Won",
            "LAK": "Lao Kip",
            "MYR": "Malaysian Ringgit",
            "NZD": "New Zealand Dollar",
            "PKR": "Pakistani Rupee",
            "PHP": "Philippines Peso",
            "LKR": "Sri Lankan Rupee",
            "THB": "Thai Baht",
            "VND": "Vietnamese Dong",
            "BRL": "Brazilian Real",
            "CZK": "Czech Koruna",
            "DKK": "Danish Krone",
            "EGP": "Egyptian Pound",
            "ILS": "Israeli Shekel",
            "KES": "Kenya Shilling",
            "KWD": "Kuwaiti Dinar",
            "NPR": "Nepalese Rupee",
            "NOK": "Norwegian Kroner",
            "RUB": "Russian Rouble",
            "SAR": "Saudi Arabian Riyal",
            "RSD": "Serbian Dinar",
            "ZAR": "South Africa Rand",
            "SEK": "Swedish Krona"
        ] as [String : Any]
    
    var currencyHolder: String?
    
    @IBOutlet weak var currenciesTableView: UITableView!
    

    override func viewDidLoad(){
        super.viewDidLoad()
        
        currenciesTableView.delegate = self
        currenciesTableView.dataSource = self
        let indexPath = IndexPath(item: Array(data.keys).firstIndex(of: currencyHolder!)!, section: 0)
        currenciesTableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        self.tableView(currenciesTableView, didSelectRowAt: indexPath)
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "CurrencyCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CurrencyTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MusicCell.")
        }
        let currency = Array(data.keys)[indexPath.row]
        cell.currencyTitle.text = currency
        currencyHolder = currency
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath as IndexPath)?.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath as IndexPath)?.accessoryType = .none
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "currencySetter",
            let destinationTab = segue.destination as? UITabBarController,
            let destination = destinationTab.viewControllers![0] as? ViewController, 
            let blogIndex = currenciesTableView.indexPathForSelectedRow?.row
        {
            destination.currency = Array(data.keys)[blogIndex]
        }
    }

    @IBAction func onDimiss(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true) {
            return
        }
    }
    
}
