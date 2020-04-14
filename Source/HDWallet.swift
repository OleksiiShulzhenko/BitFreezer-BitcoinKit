//
//  HDWallet.swift
//  BitFreezer-BitcoinKit
//
//  Created by Oleksii Shulzhenko on 26.03.2020.
//

import Foundation

public class HDWallet {
    private let seed: Data
    private let keychain: HDKeychain

    private let purpose: UInt32
    private let coinType: UInt32
    public var gapLimit: Int

    public init(seed: Data, coinType: UInt32, xPrivKey: UInt32, xPubKey: UInt32, gapLimit: Int = 5, purpose: Purpose = .bip44) {
        self.seed = seed
        self.gapLimit = gapLimit

        keychain = HDKeychain(seed: seed, xPrivKey: xPrivKey, xPubKey: xPubKey)
        self.purpose = purpose.rawValue
        self.coinType = coinType
    }
    //"m/44'/0'/0'/0/0"
    public func privateKey(account: Int, index: Int, chain: Chain) throws -> HDPrivateKey {
        return try privateKey(path: "m/\(purpose)'/\(coinType)'/\(account)'/\(chain.rawValue)/\(index)")
    }

    public func privateKey(path: String) throws -> HDPrivateKey {
        let privateKey = try keychain.derivedKey(path: path)
        return privateKey
    }

    public func publicKey(account: Int, index: Int, chain: Chain) throws -> HDPublicKey {
        return try privateKey(account: account, index: index, chain: chain).publicKey()
    }

    public enum Chain : Int {
        case external
        case `internal`
    }

}

extension HDWallet: IHDWallet {

    func publicKey(account: Int, index: Int, external: Bool) throws -> PublicKey {
        return PublicKey(withAccount: account, index: index, external: external, hdPublicKeyData: try publicKey(account: account, index: index, chain: external ? .external : .internal).raw)
    }

    func privateKeyData(account: Int, index: Int, external: Bool) throws -> Data {
        return try privateKey(account: account, index: index, chain: external ? .external : .internal).raw
    }

}
