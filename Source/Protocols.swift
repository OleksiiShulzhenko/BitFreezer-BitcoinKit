//
//  Protocols.swift
//  BitFreezer-BitcoinKit
//
//  Created by Oleksii Shulzhenko on 25.03.2020.
//

import Foundation

public protocol IAddressConverter {
    func convert(address: String) throws -> Address
    func convert(keyHash: Data, type: ScriptType) throws -> Address
    func convert(publicKey: PublicKey, type: ScriptType) throws -> Address
}

public protocol INetwork: class {
    var maxBlockSize: UInt32 { get }
    var protocolVersion: Int32 { get }
    var name: String { get }
    var bundleName: String { get }
    var pubKeyHash: UInt8 { get }
    var privateKey: UInt8 { get }
    var scriptHash: UInt8 { get }
    var bech32PrefixPattern: String { get }
    var xPubKey: UInt32 { get }
    var xPrivKey: UInt32 { get }
    var magic: UInt32 { get }
    var port: UInt32 { get }
    var dnsSeeds: [String] { get }
    var dustRelayTxFee: Int { get }
    var bip44CheckpointBlock: Block { get }
    var lastCheckpointBlock: Block { get }
    var coinType: UInt32 { get }
    var sigHash: SigHashType { get }
    var syncableFromApi: Bool { get }
}

public protocol IPluginData {
}

public protocol IPluginOutputData {
}

public protocol IPlugin {
    var id: UInt8 { get }
    var maxSpendLimit: Int? { get }
    func validate(address: Address) throws
    func processOutputs(mutableTransaction: MutableTransaction, pluginData: IPluginData, skipChecks: Bool) throws
    func processTransactionWithNullData(transaction: FullTransaction, nullDataChunks: inout IndexingIterator<[Chunk]>) throws
    func isSpendable(unspentOutput: UnspentOutput) throws -> Bool
    func inputSequenceNumber(output: Output) throws -> Int
    func parsePluginData(from: String, transactionTimestamp: Int) throws -> IPluginOutputData
    func keysForApiRestore(publicKey: PublicKey) throws -> [String]
}

public protocol IPluginManager {
    func validate(address: Address, pluginData: [UInt8: IPluginData]) throws
    func maxSpendLimit(pluginData: [UInt8: IPluginData]) throws -> Int?
    func add(plugin: IPlugin)
    func processOutputs(mutableTransaction: MutableTransaction, pluginData: [UInt8: IPluginData], skipChecks: Bool) throws
    func processInputs(mutableTransaction: MutableTransaction) throws
    func processTransactionWithNullData(transaction: FullTransaction, nullDataOutput: Output) throws
    func isSpendable(unspentOutput: UnspentOutput) -> Bool
    func parsePluginData(fromPlugin: UInt8, pluginDataString: String, transactionTimestamp: Int) -> IPluginOutputData?
}

protocol IOutputSetter {
    func setOutputs(to mutableTransaction: MutableTransaction, toAddress: String, value: Int, pluginData: [UInt8: IPluginData], skipChecks: Bool) throws
}

protocol IFactory {
    func block(withHeader header: BlockHeader, previousBlock: Block) -> Block
    func block(withHeader header: BlockHeader, height: Int) -> Block
    func blockHash(withHeaderHash headerHash: Data, height: Int, order: Int) -> BlockHash
    //func peer(withHost host: String, logger: Logger?) -> IPeer
    func transaction(version: Int, lockTime: Int) -> Transaction
    func inputToSign(withPreviousOutput: UnspentOutput, script: Data, sequence: Int) -> InputToSign
    func output(withIndex index: Int, address: Address, value: Int, publicKey: PublicKey?) throws -> Output
    func bloomFilter(withElements: [Data]) -> BloomFilter
}

protocol INetworkMessageParser {
    func parse(data: Data) -> NetworkMessage?
}

protocol INetworkMessageSerializer {
    func serialize(message: IMessage) throws -> Data
}

public protocol IMessage {
    var description: String { get }
}

public protocol IScriptConverter {
    func decode(data: Data) throws -> Script
}

protocol IInputSetter {
    func setInputs(to mutableTransaction: MutableTransaction, feeRate: Int, senderPay: Bool) throws
    func setInputs(to mutableTransaction: MutableTransaction, fromUnspentOutput unspentOutput: UnspentOutput, feeRate: Int) throws
}

public protocol IUnspentOutputSelector {
    func select(value: Int, feeRate: Int, outputScriptType: ScriptType, changeType: ScriptType, senderPay: Bool, dust: Int, pluginDataOutputSize: Int) throws -> SelectedUnspentOutputInfo
}

public protocol ITransactionSizeCalculator {
    func transactionSize(previousOutputs: [Output], outputScriptTypes: [ScriptType]) -> Int
    func transactionSize(previousOutputs: [Output], outputScriptTypes: [ScriptType], pluginDataOutputSize: Int) -> Int
    func outputSize(type: ScriptType) -> Int
    func inputSize(type: ScriptType) -> Int
    func witnessSize(type: ScriptType) -> Int
    func toBytes(fee: Int) -> Int
}

protocol IDustCalculator {
    func dust(type: ScriptType) -> Int
}

protocol IHDWallet {
    var gapLimit: Int { get }
    func publicKey(account: Int, index: Int, external: Bool) throws -> PublicKey
    func privateKeyData(account: Int, index: Int, external: Bool) throws -> Data
}

protocol ILockTimeSetter {
    func setLockTime(to mutableTransaction: MutableTransaction, lastBlockHeight: Int?)
}

protocol IInputSigner {
    func sigScriptData(transaction: Transaction, inputsToSign: [InputToSign], outputs: [Output], index: Int) throws -> [Data]
}

protocol ITransactionSigner {
    func sign(mutableTransaction: MutableTransaction) throws
}
