//
//  Block.swift
//  BitFreezer-BitcoinKit
//
//  Created by Oleksii Shulzhenko on 25.03.2020.
//

import Foundation

public class Block {

    var version: Int
    var previousBlockHash: Data
    public var merkleRoot: Data
    public var timestamp: Int
    public var bits: Int
    var nonce: Int

    public var headerHash: Data
    public var height: Int
    var stale: Bool = false
    var hasTransactions: Bool = false

    public init(withHeader header: BlockHeader, height: Int) {
        version = header.version
        previousBlockHash = header.previousBlockHeaderHash
        merkleRoot = header.merkleRoot
        timestamp = header.timestamp
        bits = header.bits
        nonce = header.nonce
        headerHash = header.headerHash
        self.height = height
    }

    public convenience init(withHeader header: BlockHeader, previousBlock: Block) {
        self.init(withHeader: header, height: previousBlock.height + 1)
    }

}
