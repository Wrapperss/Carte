//
//  Number+Extension.swift
//  creams
//
//  Created by hasayakey on 9/11/17.
//  Copyright © 2017 creams.io. All rights reserved.
//

import Foundation

extension Int {
    var string: String {
        return "\(self)"
    }
}

extension Bool {
    var intValue: Int {
        return self == true ? 1 : 0
    }
}

extension Optional where Wrapped == Int {
    var string: String {
        guard let value = self else {
            return ""
        }
        return "\(value)"
    }
}

extension Double {

    var string: String {
        return "\(self)"
    }

    var cleanString: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}

extension Double {

    var noDecimalString: String {
        return String(format:"%.0f", roundTo(places: 0))
    }

    var oneDecimalString: String {
        return String(format:"%.1f", roundTo(places: 1))
    }

    var twoDecimalString: String {
        return String(format:"%.2f", roundTo(places: 2))
    }

    func toPercentString(round: Int) -> String {
        return String(format:"%.\(round)f", (self * 100.0).roundTo(places: round)) + "%"
    }

    func roundTo(places: Int) -> Double {
        guard self != 0 else {
            return 0
        }

        let divisor = pow(10.0, Double(places))
        let rounded = (self * divisor).rounded()

        return rounded / divisor
    }
}

extension Optional where Wrapped == Double {

    var noDecimalString: String {

        guard let value = self else {
            return ""
        }

        return value.noDecimalString
    }

    var oneDecimalString: String {

        guard let value = self else {
            return ""
        }

        return value.oneDecimalString
    }

    var twoDecimalString: String {

        guard let value = self else {
            return ""
        }

        return value.twoDecimalString
    }

    func toPercentString(round: Int) -> String {

        guard let value = self else {
            return numberEmptyContent
        }

        return value.toPercentString(round: round)
    }

    func roundTo(places: Int) -> Double {

        guard let value = self else {
            return 0
        }

        return value.roundTo(places: places)
    }
}
