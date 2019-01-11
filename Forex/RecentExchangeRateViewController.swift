//
//  RecentExchangeRateViewController.swift
//  Forex
//
//  Created by Lynn Phay U on 1/2/19.
//  Copyright © 2019 Lynn Phay U. All rights reserved.
//

import UIKit

class RecentExchangeRateViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var kbzRate = NSDictionary()
    var cbRate = NSDictionary()
    var mabRate = NSDictionary()
    var ayaRate = NSDictionary()
    
    var kbzRowCount:Int = 0
    var cbRowCount:Int = 0
    var mabRowCount:Int = 0
    var ayaRowCount:Int = 0
    
    
    let dispatch_group = DispatchGroup()
    
    @IBOutlet weak var CurrencyTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        CurrencyTableView.delegate = self
        CurrencyTableView.dataSource = self
        loadRemoteData()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        kbzRowCount = (kbzRate.object(forKey: "currencyRates") as? NSDictionary)?.count ?? 0
        cbRowCount = (cbRate.object(forKey: "currencyRates") as? NSDictionary)?.count ?? 0
        mabRowCount = (mabRate.object(forKey: "currencyRates") as? NSDictionary)?.count ?? 0
        ayaRowCount = (ayaRate.object(forKey: "currencyRates") as? NSDictionary)?.count ?? 0
    
        return kbzRowCount+cbRowCount+mabRowCount+ayaRowCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cellIdentifier:String?
        
        cellIdentifier = "currencyRateCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier!, for: indexPath) as? RecentCurrencyRateTableViewCell else {
            fatalError("The dequeued cell is not an instance of CurrencyCell.")
        }
        switch indexPath.row {
            case 0:
                cell.currency.text = "KBZ"
                cell.buy.text = "BUY"
                cell.sell.text = "SELL"
            
            case 1..<kbzRowCount+1:
                let currency = (kbzRate.object(forKey: "currencyRates") as! NSDictionary).allKeys[indexPath.row-1] as? String
                cell.currency.text = currency
                cell.buy.text = extractRateDict(exchangeRateData: kbzRate, currency: currency!, buyOrSell: "buy")
                cell.sell.text = extractRateDict(exchangeRateData: kbzRate, currency: currency!, buyOrSell: "sell")
            
            case kbzRowCount+1:
                cell.currency.text = "CB"
                cell.buy.text = "BUY"
                cell.sell.text = "SELL"
            
            case kbzRowCount+2..<kbzRowCount+cbRowCount+2:
                let currency = (cbRate.object(forKey: "currencyRates") as! NSDictionary).allKeys[indexPath.row-kbzRowCount-2] as? String
                cell.currency.text = currency
                cell.buy.text = extractRateDict(exchangeRateData: cbRate, currency: currency!, buyOrSell: "buy")
                cell.sell.text = extractRateDict(exchangeRateData: cbRate, currency: currency!, buyOrSell: "sell")
            
            case kbzRowCount+cbRowCount+2:
                cell.currency.text = "MAB"
                cell.buy.text = "BUY"
                cell.sell.text = "SELL"
            
            case kbzRowCount+cbRowCount+3..<kbzRowCount+cbRowCount+mabRowCount+3:
                let currency = (mabRate.object(forKey: "currencyRates") as! NSDictionary).allKeys[indexPath.row-(kbzRowCount+cbRowCount)-3] as? String
                cell.currency.text = currency
                cell.buy.text = extractRateDict(exchangeRateData: mabRate, currency: currency!, buyOrSell: "buy")
                cell.sell.text = extractRateDict(exchangeRateData: mabRate, currency: currency!, buyOrSell: "sell")
            
            case kbzRowCount+cbRowCount+mabRowCount+3:
                cell.currency.text = "AYA"
                cell.buy.text = "BUY"
                cell.sell.text = "SELL"
            
            case kbzRowCount+cbRowCount+mabRowCount+4..<kbzRowCount+cbRowCount+mabRowCount+ayaRowCount+4:
                let currency = (ayaRate.object(forKey: "currencyRates") as! NSDictionary).allKeys[indexPath.row-(kbzRowCount+cbRowCount+mabRowCount)-4] as? String
                cell.currency.text = currency
                cell.buy.text = extractRateDict(exchangeRateData: ayaRate, currency: currency!, buyOrSell: "buy")
                cell.sell.text = extractRateDict(exchangeRateData: ayaRate, currency: currency!, buyOrSell: "sell")
            
            default: break
        
        }
        
        return cell
    }
    
    func extractRateDict(exchangeRateData:NSDictionary, currency:String, buyOrSell:String) -> String {
        let rate = ((exchangeRateData.object(forKey: "currencyRates") as! NSDictionary).object(forKey: currency) as! NSDictionary).object(forKey: buyOrSell) as? String
        return rate ?? "Failed"
    }
    
    func loadRemoteData() {
        
        dispatch_group.enter()
        getExchangeRateFromSpecificBank(bankName: "KBZ", completion: { (result) -> Void in
            self.kbzRate = result as NSDictionary
            self.dispatch_group.leave()
        })
        dispatch_group.enter()
        getExchangeRateFromSpecificBank(bankName: "CB", completion: { (result) -> Void in
            self.cbRate = result as NSDictionary
            self.dispatch_group.leave()
        })
        dispatch_group.enter()
        getExchangeRateFromSpecificBank(bankName: "MAB", completion: { (result) -> Void in
            self.mabRate = result as NSDictionary
            self.dispatch_group.leave()
        })
        dispatch_group.enter()
        getExchangeRateFromSpecificBank(bankName: "AYA", completion: { (result) -> Void in
            self.ayaRate = result as NSDictionary
            self.dispatch_group.leave()
        })
        dispatch_group.notify(queue: .main, execute: {
            self.CurrencyTableView.reloadData()
        })
        
    }
}
