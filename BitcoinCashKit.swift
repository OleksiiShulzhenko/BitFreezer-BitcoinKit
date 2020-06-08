//
//  BitcoinCashKit.swift
//  BitFreezer-BitcoinKit
//
//  Created by Oleksii Shulzhenko on 08.06.2020.
//

import Foundation
import OpenSslKit

public class BitcoinCashKit {
    
    public static func createWallet() -> (Address) {
        
        let entrophy = generateEntrophy()
        let mnemonic = Mnemonic.generate( entropy: entrophy)
        let seed = Mnemonic.seed(mnemonic: mnemonic)
    
        let network = BitcoinCashMainNet()
        
        let addressConverter = Base58AddressConverter(addressVersion: network.pubKeyHash, addressScriptVersion: network.scriptHash)
        
        let wallet = HDWallet(seed: seed, coinType: network.coinType, xPrivKey: network.xPrivKey, xPubKey: network.xPubKey)
        
        let publicKey = try! wallet.publicKey(account: 0, index: 0, external: true)
        let address = try! addressConverter.convert(publicKey: publicKey, type: Bip.bip44.scriptType)
        
        return Address(address: address.stringValue, mnemonic: mnemonic, entrophy: entrophy)
        
    }
    
    private static func generateEntrophy() -> Data {
        if let entrophy = try? Mnemonic.generateEntropy() {
            return entrophy
        } else {
            return generateEntrophy()
        }
    }
    
    public static func exportPrivateKey(entrophy: Data) -> Data {
        let mnemonic = Mnemonic.generate(entropy: entrophy)
        let seed = Mnemonic.seed(mnemonic: mnemonic)
        
        let network = BitcoinCashMainNet()
        
        let wallet = HDWallet(seed: seed, coinType: network.coinType, xPrivKey: network.xPrivKey, xPubKey: network.xPubKey)
        
        return try! wallet.privateKey(path: "m/44'/145'/0'/0/0").raw
    }
    
    public static func exportMnemonic(entrophy: Data) -> [String] {
        return Mnemonic.generate(entropy: entrophy)
    }
    
    public static func createTransaction(entrophy: Data, toAddress: String, value: Int, unspentOutputs: [UnspentOutput]) throws -> String {
            
            let network = BitcoinCashMainNet()
        
            let mnemonic = Mnemonic.generate( entropy: entrophy)
            let seed = Mnemonic.seed(mnemonic: mnemonic)
            
            let hdWallet = HDWallet(seed: seed, coinType: network.coinType, xPrivKey: network.xPrivKey, xPubKey: network.xPubKey, gapLimit: 20, purpose: .bip44)
            
            let publicKey = try! hdWallet.publicKey(account: 0, index: 0, external: true)
            
            let mutableTransaction = MutableTransaction()
            
            let addressConverter = Base58AddressConverter(addressVersion: network.pubKeyHash, addressScriptVersion: network.scriptHash)
            
            let scriptConverter = ScriptConverter()
            
            let logger = Logger(network: network, minLogLevel: Logger.Level.verbose)
            
            let pluginManager = PluginManager(scriptConverter: scriptConverter, logger: logger)
            
            let factory = Factory(network: network)
            
            let outputSetter = OutputSetter(addressConverter: addressConverter, factory: factory, pluginManager: pluginManager)
            
            try outputSetter.setOutputs(to: mutableTransaction, toAddress: toAddress, value: value, skipChecks: false)
            
            let unspentOutputSelector = UnspentOutputSelectorChain()
            
            let transactionSizeCalculator = TransactionSizeCalculator()
            
            unspentOutputSelector.prepend(unspentOutputSelector: UnspentOutputSelector(calculator: transactionSizeCalculator, unspentOutputs: unspentOutputs))
            
            unspentOutputSelector.prepend(unspentOutputSelector: UnspentOutputSelectorSingleNoChange(calculator: transactionSizeCalculator, unspentOutputs: unspentOutputs))
            
            let dustCalculator = DustCalculator(dustRelayTxFee: network.dustRelayTxFee, sizeCalculator: transactionSizeCalculator)
            
            let inputSetter = InputSetter(unspentOutputSelector: unspentOutputSelector, transactionSizeCalculator: transactionSizeCalculator, addressConverter: addressConverter, fromPublicKey: publicKey, factory: factory, pluginManager: pluginManager, dustCalculator: dustCalculator, changeScriptType: Bip.bip44.scriptType)
            
            try inputSetter.setInputs(to: mutableTransaction, feeRate: 3, senderPay: true)
            
            let lockTimeSetter = LockTimeSetter()
            
            lockTimeSetter.setLockTime(to: mutableTransaction, lastBlockHeight: 0)
            
            let inputSigner = InputSigner(hdWallet: hdWallet, network: network)
            
            let transactionSigner = TransactionSigner(inputSigner: inputSigner)
            
            try transactionSigner.sign(mutableTransaction: mutableTransaction)
            
            let transaction = mutableTransaction.build()
            
            return TransactionSerializer.serialize(transaction: transaction).hex
        }
    
    public struct Address {
        
        public let address: String
        public let mnemonic: [String]
        public let entrophy: Data
    }
}
