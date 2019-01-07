//
//  dateDelegate.swift
//  Forex
//
//  Created by Lynn Phay U on 1/2/19.
//  Copyright © 2019 Lynn Phay U. All rights reserved.
//

import Foundation

let date = Date()
let formatter = DateFormatter()

extension Date {
    func allDates(till endDate: Date, duration: Int) -> [String] {
        var date = self
        var array: [String] = []
        while date > Calendar.current.date(byAdding: .day, value: -duration, to: Date())! {
            array.append(formatter.string(from: date))
            date = Calendar.current.date(byAdding: .day, value: -1, to: date)!
        }
        return array
    }
}

func dateDelegate(length: Int) -> [String] {
    formatter.dateFormat = "dd-MM-yyyy"
    let dateArray = Date().allDates(till: date, duration: length)
    print(dateArray)
    return dateArray
}
