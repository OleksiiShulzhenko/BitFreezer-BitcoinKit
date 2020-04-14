//
//  SigHashType.swift
//  BitFreezer-BitcoinKit
//
//  Created by Oleksii Shulzhenko on 25.03.2020.
//

import Foundation

public enum SigHashType {
    case bitcoinAll
    case bitcoinCashAll

    var value: UInt8 {
        switch self {
            case .bitcoinAll: return 0x01
            case .bitcoinCashAll: return 0x41
        }
    }

    var forked: Bool {
        switch self {
            case .bitcoinAll: return false
            case .bitcoinCashAll: return true
        }
    }
}
