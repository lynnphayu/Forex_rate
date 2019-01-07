//
//  ApiHandler.swift
//  Forex
//
//  Created by Lynn Phay U on 1/1/19.
//  Copyright © 2019 Lynn Phay U. All rights reserved.
//

import UIKit
import Alamofire

var CBMapi = "http://forex.cbm.gov.mm/api/history/"
var CBMCurrenciesApi = "https://forex.cbm.gov.mm/api/currencies"
var bankNames = [
    "KBZ" : "https://forexio.herokuapp.com/kbz",
    "CB" : "https://forexio.herokuapp.com/cb",
    "MAB" : "https://forexio.herokuapp.com/mab",
    "AYA" : "https://forexio.herokuapp.com/aya"
]

func getCBMForexRate(completion:@escaping (_ result: [String:Double])->Void, dateArray: [String], currency: String) {
    
    var forexRateArray: [String: Double] = [:]
    let tasks = DispatchGroup()
    
    for (_,element) in dateArray.enumerated(){
        
        tasks.enter()
        AF.request(CBMapi+element, encoding: URLEncoding.default)
            .responseJSON{ response in
                var statusCode = response.response?.statusCode
                let resultData = response.result.value
                switch response.result {
                case .success:
                    var placeholder: String
                    let allExRate = (resultData as! NSDictionary).object(forKey: "rates")
                    if let resultRate = allExRate as? NSDictionary{
                        placeholder = resultRate.object(forKey: currency) as! String
                        if let doubleCasted = Double(placeholder.replacingOccurrences(of: ",", with: "")){
                            forexRateArray[element] = doubleCasted
                        }
                    }
                    tasks.leave()
                    
                case .failure(let error):
                    statusCode = error._code // statusCode private
                    print("status code is: \(String(describing: statusCode))")
                    print(error)
                }
            }
        
        }
        tasks.notify(queue: .main) {
            completion(forexRateArray)
        }
}

func getExchangeRateFromSpecificBank(bankName:String, completion: @escaping (_ result: [String:Any])->Void) {
    
    AF.request(bankNames[bankName]!)
        .responseJSON{ response in
            var statusCode = response.response?.statusCode
            let resultData = response.result.value
            switch response.result {
            case .success:
                let exchangeRates = resultData as! NSDictionary
                completion(exchangeRates as! [String : Any])
                
            case .failure(let error):
                statusCode = error._code // statusCode private
                print("status code is: \(String(describing: statusCode))")
                print(error)
            }
        }
    
}






