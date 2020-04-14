//
//  BlockHash.swift
//  BitFreezer-BitcoinKit
//
//  Created by Oleksii Shulzhenko on 26.03.2020.
//

import Foundation

public class BlockHash {
    let headerHash: Data
    let height: Int
    let sequence: Int

    public init(headerHash: Data, height: Int, order: Int) {
        self.headerHash = headerHash
        self.height = height
        self.sequence = order
    }

    init?(headerHashReversedHex: String, height: Int, sequence: Int) {
        guard let headerHash = Data(hex: headerHashReversedHex) else {
            return nil
        }

        self.headerHash = Data(headerHash.reversed())
        self.height = height
        self.sequence = sequence

    }

}

extension BlockHash: Equatable {

    public static func ==(lhs: BlockHash, rhs: BlockHash) -> Bool {
        return lhs.headerHash == rhs.headerHash
    }

}
