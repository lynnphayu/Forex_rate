//
//  ViewController.swift
//  Forex
//
//  Created by Lynn Phay U on 1/1/19.
//  Copyright © 2019 Lynn Phay U. All rights reserved.
//

import UIKit
import SwiftChart

class ViewController: UIViewController,  ChartDelegate{

    @IBOutlet weak var USDForexRate: UILabel!
    @IBOutlet weak var chart: Chart!
    @IBOutlet weak var onChangeCurrency: UIBarButtonItem!
    
    var timer = Timer()
    var currency = "USD"
    let myActivityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.white)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myActivityIndicator.center = chart.center
        myActivityIndicator.hidesWhenStopped = false
        myActivityIndicator.startAnimating()
        view.addSubview(myActivityIndicator)
        
        USDForexRate.text = currency
        chart.delegate = self
        chart.showXLabelsAndGrid = false
        chart.backgroundColor = .black
        chart.labelColor = .white
        chart.lineWidth = 0.5
        chart.labelFont = UIFont.systemFont(ofSize: 12)
//        chart.backgroundColor = UIColor.black
        updateChart()
//        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.updateChart), userInfo: nil, repeats: true)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "onChooseCurrencySegue",
            let destination = segue.destination as? CurrencyTableViewController
        {
            destination.currencyHolder = currency
        }
    }

    func didTouchChart(_ chart: Chart, indexes: [Int?], x: Double, left: CGFloat) {
        
    }
    
    func didFinishTouchingChart(_ chart: Chart) {
        
    }
    
    func didEndTouchingChart(_ chart: Chart) {
        
    }
    
    
    
    @objc func updateChart() {
        getCBMForexRate(completion: {(result)->Void in
            let series = ChartSeries(Array(result.values))
            series.color = ChartColors.redColor()
            series.area = true
            self.myActivityIndicator.removeFromSuperview()
            self.chart.add(series)
            self.myActivityIndicator.stopAnimating()
        }, dateArray: dateDelegate(length: 90), currency: currency)
    }

}

