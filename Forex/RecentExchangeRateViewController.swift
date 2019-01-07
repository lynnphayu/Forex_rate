//
//  RecentExchangeRateViewController.swift
//  Forex
//
//  Created by Lynn Phay U on 1/2/19.
//  Copyright © 2019 Lynn Phay U. All rights reserved.
//

import UIKit

class KBZTableViewCell: UITableViewCell {
    @IBOutlet weak var currency: UILabel!
    @IBOutlet weak var buy: UILabel!
    @IBOutlet weak var sell: UILabel!
    
}

class CBTableViewCell: UITableViewCell {
    @IBOutlet weak var currency: UILabel!
    @IBOutlet weak var sell: UILabel!
    @IBOutlet weak var buy: UILabel!
    
}

class MABTableViewCell: UITableViewCell {
    @IBOutlet weak var currency: UILabel!
    @IBOutlet weak var sell: UILabel!
    @IBOutlet weak var buy: UILabel!
    
}

class AYATableViewCell: UITableViewCell {
    @IBOutlet weak var currency: UILabel!
    @IBOutlet weak var buy: UILabel!
    @IBOutlet weak var sell: UILabel!
    
}


class RecentExchangeRateViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var KBZTableView: UITableView!
    @IBOutlet weak var CBTableView: UITableView!
    @IBOutlet weak var MABTableView: UITableView!
    @IBOutlet weak var AYATableView: UITableView!
    
    var kbzRate:[String:Any] = [:]
    var cbRate:[String:Any] = [:]
    var mabRate:[String:Any] = [:]
    var ayaRate:[String:Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getExchangeRateFromSpecificBank(bankName: "KBZ", completion: { (result) -> Void in
            self.kbzRate = result
        })
        getExchangeRateFromSpecificBank(bankName: "CB", completion: { (result) -> Void in
            self.cbRate = result
        })
        getExchangeRateFromSpecificBank(bankName: "MAB", completion: { (result) -> Void in
            self.mabRate = result
        })
        getExchangeRateFromSpecificBank(bankName: "AYA", completion: { (result) -> Void in
            self.ayaRate = result
        })
        
        KBZTableView.dataSource = self
        KBZTableView.delegate = self
        KBZTableView.register(UITableViewCell.self, forCellReuseIdentifier: "KBZTableCell")
        
        CBTableView.dataSource = self
        CBTableView.delegate = self
        CBTableView.register(UITableViewCell.self, forCellReuseIdentifier: "CBTableCell")
        
        MABTableView.dataSource = self
        MABTableView.delegate = self
        MABTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MABTableCell")
        
        AYATableView.dataSource = self
        AYATableView.delegate = self
        AYATableView.register(UITableViewCell.self, forCellReuseIdentifier: "AYATableCell")
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count:Int?
        
        switch tableView {
        case self.KBZTableView:
            count = kbzRate.count
        case self.CBTableView:
            count = kbzRate.count
        case self.MABTableView:
            count = kbzRate.count
        case self.AYATableView:
            count = kbzRate.count
        default:
            count = 0
        }
        
        return count!
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell?
        
        switch tableView {
        case self.KBZTableView:
            cell = tableView.dequeueReusableCell(withIdentifier: "KBZTableCell", for: indexPath)
        case self.CBTableView:
            cell = tableView.dequeueReusableCell(withIdentifier: "CBTableCell", for: indexPath)
        case self.MABTableView:
            cell = tableView.dequeueReusableCell(withIdentifier: "MABTableCell", for: indexPath)
        case self.AYATableView:
            cell = tableView.dequeueReusableCell(withIdentifier: "AYATableCell", for: indexPath)
        default:
            cell = nil
        }
        
        return cell!
    }
}
