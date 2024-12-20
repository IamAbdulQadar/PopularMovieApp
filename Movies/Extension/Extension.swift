//
//  Extension.swift
//  Movies
//
//  Created by Abdul Qadar on 20/12/2024.
//

import Foundation
import UIKit

extension Dictionary {
    func toJSONString() -> String? {
        if let theJSONData = try? JSONSerialization.data(withJSONObject: self, options: []) {
            return String(data: theJSONData,encoding: .utf8)
        }
        return nil
    }
}

extension Array {

    func toJSONString() -> String? {
        if let theJSONData = try? JSONSerialization.data(withJSONObject: self, options: []) {
            return String(data: theJSONData,encoding: .utf8)
        }
        return nil
    }
}

extension UIView {

    class var nibName: String {
        return "\(self)".components(separatedBy: ".").first ?? ""
    }

    class var nib: UINib? {
        if let _ = Bundle.main.path(forResource: nibName, ofType: "nib") {
            return UINib(nibName: nibName, bundle: nil)
        } else {
            return nil
        }
    }
}
