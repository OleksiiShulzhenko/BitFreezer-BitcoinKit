//
//  String.swift
//  BitFreezer-BitcoinKit
//
//  Created by Oleksii Shulzhenko on 26.03.2020.
//

import Foundation

extension String {

    public var reversedData: Data? {
        return Data(hex: self).map { Data($0.reversed()) }
    }

}
