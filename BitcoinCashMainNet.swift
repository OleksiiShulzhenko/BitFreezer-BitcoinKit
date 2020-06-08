//
//  BitcoinCashMainNet.swift
//  BitFreezer-BitcoinKit
//
//  Created by Oleksii Shulzhenko on 08.06.2020.
//

import Foundation

public class BitcoinCashMainNet: INetwork {

    public let name = "bitcoin-cash-main-net"
    public let bundleName = "BitcoinCashKit"

    public let maxBlockSize: UInt32 = 32 * 1024 * 1024
    public let pubKeyHash: UInt8 = 0x00
    public let privateKey: UInt8 = 0x80
    public let scriptHash: UInt8 = 0x05
    public let bech32PrefixPattern: String = "bitcoincash"
    public let xPubKey: UInt32 = 0x0488b21e
    public let xPrivKey: UInt32 = 0x0488ade4
    public let magic: UInt32 = 0xe3e1f3e8
    public let port: UInt32 = 8333
    public let coinType: UInt32 = 0
    public let sigHash: SigHashType = .bitcoinCashAll
    public var syncableFromApi: Bool = true

    public let dnsSeeds = [
        "seed.bitcoinabc.org",
        "seed-abc.bitcoinforks.org",
    ]

    public let dustRelayTxFee = 1000    // https://github.com/Bitcoin-ABC/bitcoin-abc/blob/master/src/policy/policy.h#L78

    public var bip44CheckpointBlock: Block {
        Block(
                withHeader: BlockHeader(
                        version: 2,
                        headerHash: "00000000000000003decdbb5f3811eab3148fbc29d3610528eb3b50d9ee5723f".reversedData!,
                        previousBlockHeaderHash: "00000000000000006bcf448b771c8f4db4e2ca653474e3b29504ec08422b3fba".reversedData!,
                        merkleRoot: "4ea18e999a57fc55fb390558dbb88a7b9c55c71c7de4cec160c045802ee587d2".reversedData!,
                        timestamp: 1397755646,
                        bits: 419470732,
                        nonce: 2160181286
                ),
                height: 296352)
    }
    
    public init() {}

}
