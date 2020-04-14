//
//  MutableTransaction.swift
//  BitFreezer-BitcoinKit
//
//  Created by Oleksii Shulzhenko on 25.03.2020.
//

import Foundation

public class MutableTransaction {
    var transaction = Transaction(version: 2, lockTime: 0)
    var inputsToSign = [InputToSign]()

    public var recipientAddress: Address!
    public var recipientValue = 0
    var changeAddress: Address? = nil
    var changeValue = 0

    private var pluginData = [UInt8: Data]()

    var outputs: [Output] {
        var outputs = [Output]()

        var index = 0

        if let address = recipientAddress {
            outputs.append(Output(withValue: recipientValue, index: index, lockingScript: address.lockingScript, type: address.scriptType, address: address.stringValue, keyHash: address.keyHash))
            index += 1
        }

        if let address = changeAddress {
            outputs.append(Output(withValue: changeValue, index: index, lockingScript: address.lockingScript, type: address.scriptType, address: address.stringValue, keyHash: address.keyHash))
            index += 1
        }

        if !pluginData.isEmpty {
            var data = Data([OpCode.op_return])

            pluginData.forEach { key, value in
                data += Data([key]) + value
            }

            outputs.append(Output(withValue: 0, index: index, lockingScript: data, type: .nullData))
        }

        return outputs.sorted(by: Bip69.outputComparator)
    }

    var pluginDataOutputSize: Int {
        pluginData.count > 0 ? 1 + pluginData.reduce(into: 0) { $0 += 1 + $1.value.count } : 0                // OP_RETURN (PLUGIN_ID PLUGIN_DATA)
    }

    public init(outgoing: Bool = true) {
        transaction.status = .new
        transaction.isMine = true
        transaction.isOutgoing = outgoing
    }

    public func add(pluginData: Data, pluginId: UInt8) {
        self.pluginData[pluginId] = pluginData
    }

    func add(inputToSign: InputToSign) {
        inputsToSign.append(inputToSign)
    }

    public func build() -> FullTransaction {
        FullTransaction(header: transaction, inputs: inputsToSign.map{ $0.input }, outputs: outputs)
    }

}
