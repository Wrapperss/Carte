//
//  StringExtension.swift
//  creams
//
//  Created by Rawlings on 22/11/2016.
//  Copyright © 2016 jiangren. All rights reserved.
//

import Foundation
import UIKit
import SwiftRichString
import AttributedLib

extension NSMutableAttributedString {
    
    func appending(_ tail: NSAttributedString) -> NSMutableAttributedString {
        self.append(tail)
        return self
    }
}

extension NSAttributedString {

    static func attribute(_ text: String,
                          _ color: UIColor,
                          fontSize: CGFloat = 13,
                          fontWeight: CGFloat = UIFontWeightRegular,
                          align: NSTextAlignment = .left) -> NSMutableAttributedString {

        let style = Style({
            $0.font = FontAttribute(font: UIFont.systemFont(ofSize: fontSize, weight: fontWeight))
            $0.align = align
            $0.color = color
        })

        return text.set(style: style)
    }

    func upgradeLineSpacing(lineSpacing: CGFloat) -> NSMutableAttributedString {
        return upgradeParagraphStyle(config: { (para) in
            para.lineSpacing = lineSpacing
        })
    }

    func upgradeParagraphStyle(config: (NSMutableParagraphStyle) -> Void) -> NSMutableAttributedString {
        let style = Style({
            let para = $0.attributes[NSParagraphStyleAttributeName] as! NSMutableParagraphStyle
            config(para)
        })
        let mutable = NSMutableAttributedString(attributedString: self)
        return mutable.add(style: style)
    }
    
    public func attributedBetweenTwoChar(_ first: String, _ second: String, _ conf: Attributes) -> NSAttributedString {
        
        let str = self.string
        guard NSString(string: str).contains(first) && NSString(string: str).contains(second) else {
            return self
        }
        
        let start = (str as NSString).range(of: "(").location
        let end = (str as NSString).range(of: ")").location
        
        let range = NSRange.init(location: start, length: end - start + 1)
      
        return self.at
            .modified(with: conf, for: range)
        
    }
    
}

extension String {

    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
    
    var containsWhitespace : Bool {
        return(self.rangeOfCharacter(from: .whitespacesAndNewlines) != nil)
    }
}



extension String {

    init(_ aClass: AnyClass) {
        self = "\(aClass.self)"
    }

    var length: Int {
        let set = NSCharacterSet.whitespacesAndNewlines
        let string = NSString(string: self as NSString)
        let filter = string.trimmingCharacters(in: set)
        return filter.count
    }
}

extension String {

    func index(from: Int) -> Index {
        
        return self.index(startIndex, offsetBy: from)
    }

    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return substring(from: fromIndex)
    }

    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return substring(to: toIndex)
    }

    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return substring(with: startIndex..<endIndex)
    }

}

extension String {

    func validateEmail() -> Bool {
        let emailRegex: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: self)
    }

    func originURL() -> URL {
        return URL(string: self)!
    }

    func toDictionary() -> Dictionary<String, AnyObject>? {
        if let data = self.data(using: String.Encoding.utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as?  Dictionary<String, AnyObject>
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }

    func isEqualToString(_ find: String!) -> Bool! {
        return String(format: self) == find
    }

    func callNumber() {
        guard let number = URL(string: "tel://" + self) else { return }
        let application: UIApplication = UIApplication.shared

        if #available(iOS 10.0, *) {
            application.open(number)
        } else {
            if (application.canOpenURL(number)) {
                application.openURL(number)
            } else if let phoneCallURL: URL = URL(string: "telprompt://\(self)") {
                if (application.canOpenURL(phoneCallURL)) {
                    application.openURL(phoneCallURL)
                }
            }
        }
    }

    func toDate(withFormatter formatter: String) -> Date? {
        let format = DateFormatter()
        format.dateFormat = formatter
        return format.date(from: self)
    }

    func toDate(withFormatter formatter: DateFormatter) -> Date? {
        return formatter.date(from: self)
    }
}

func checkStringAvailable(_ str: String?) -> Bool {
    return str != nil && str!.length > 0
}

extension String {
    func generateAttributedString(with searchTerm: String, highlightSearchTermColor: UIColor) -> NSAttributedString? {
        let attributedString = NSMutableAttributedString(string: self)
        do {
            let regex = try NSRegularExpression(pattern: searchTerm, options: .caseInsensitive)
            let range = NSRange(location: 0, length: self.utf16.count)
            for match in regex.matches(in: self, options: .withTransparentBounds, range: range) {
                if #available(iOS 8.2, *) {
                    attributedString.addAttribute(NSForegroundColorAttributeName, value: highlightSearchTermColor, range: match.range)
                } else {
                    // Fallback on earlier versions
                }
            }
            return attributedString
        } catch _ {
            return attributedString
        }
    }

    func generateAttributedString(color: UIColor) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        attributedString.addAttribute(NSForegroundColorAttributeName, value: color, range: NSRange(location: 0, length: self.length))
        return attributedString
    }

}

extension CharacterSet {
    static var urlQueryParametersAllowed: CharacterSet {
        // Does not include "?" or "/" due to RFC 3986 - Section 3.4
        let generalDelimitersToEncode = ":#[]@"
        let subDelimitersToEncode = "!$&'()*+,;="

        var allowedCharacterSet = CharacterSet.urlQueryAllowed
        allowedCharacterSet.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")

        return allowedCharacterSet
    }
}

extension String {

    var lastPathComponent: String {
        return (self as NSString).lastPathComponent
    }
    var pathExtension: String {
        return (self as NSString).pathExtension
    }
    var stringByDeletingLastPathComponent: String {
        return (self as NSString).deletingLastPathComponent
    }
    var stringByDeletingPathExtension: String {
        return (self as NSString).deletingPathExtension
    }
    var pathComponents: [String] {
        return (self as NSString).pathComponents
    }
    func stringByAppendingPathComponent(path: String) -> String {
        let nsSt = self as NSString
        return nsSt.appendingPathComponent(path)
    }
    func stringByAppendingPathExtension(ext: String) -> String? {
        let nsSt = self as NSString
        return nsSt.appendingPathExtension(ext)
    }
}

extension String {

    func encodeUTF8() -> String? {

        if let _ = URL(string: self) {
            return self
        }

        let optionalLastComponent = self.split { $0 == "/" }.last
        if let lastComponent = optionalLastComponent {
            let lastComponentAsString = lastComponent.map { String($0) }.reduce("", +)
            if let rangeOfLastComponent = self.range(of: lastComponentAsString) {
                let stringWithoutLastComponent = self.substring(to: rangeOfLastComponent.lowerBound)
                if let lastComponentEncoded = lastComponentAsString.addingPercentEncoding(withAllowedCharacters: .urlQueryParametersAllowed) {
                    let encodedString = stringWithoutLastComponent + lastComponentEncoded
                    return encodedString
                }
            }
        }

        return nil
    }
}

extension Optional where Wrapped == String {

    var string: String {
        guard let value = self else {
            return ""
        }
        return value
    }
}

extension String {
    public func toUrl() -> URL? {
        return URL(string: self)
    }
}

//extension Optional where Wrapped == String {
//    public func toUrl() -> URL {
//        guard let str = self else {
//            return URL(string: "https://www")!
//        }
//        return str.toUrl()
//    }
//}

//extension String {
//    public func toUrl() -> URL {
//        var url = ""
//        if self.hasPrefix("http") {
//            url = self
//        } else if self.isEmpty {
//            url = "https://www"
//        } else {
//            url = Constants.APIKey.upyunRootURL + self
//        }
//        return URL(string: url)!
//    }
//}
