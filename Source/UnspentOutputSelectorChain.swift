//
//  UnspentOutputSelectorChain.swift
//  BitFreezer-BitcoinKit
//
//  Created by Oleksii Shulzhenko on 26.03.2020.
//

import Foundation

class UnspentOutputSelectorChain: IUnspentOutputSelector {
    var concreteSelectors = [IUnspentOutputSelector]()

    func select(value: Int, feeRate: Int, outputScriptType: ScriptType, changeType: ScriptType, senderPay: Bool, dust: Int, pluginDataOutputSize: Int) throws -> SelectedUnspentOutputInfo {
        var lastError: Error = BitcoinCoreErrors.Unexpected.unkown

        for selector in concreteSelectors {
            do {
                return try selector.select(value: value, feeRate: feeRate, outputScriptType: outputScriptType, changeType: changeType, senderPay: senderPay, dust: dust, pluginDataOutputSize: pluginDataOutputSize)
            } catch {
                lastError = error
            }
        }

        throw lastError
    }

    func prepend(unspentOutputSelector: IUnspentOutputSelector) {
        concreteSelectors.insert(unspentOutputSelector, at: 0)
    }
}
