//
//  LockTimeSetter.swift
//  BitFreezer-BitcoinKit
//
//  Created by Oleksii Shulzhenko on 26.03.2020.
//

import Foundation

class LockTimeSetter {

}

extension LockTimeSetter: ILockTimeSetter {

    func setLockTime(to mutableTransaction: MutableTransaction, lastBlockHeight: Int?) {
        mutableTransaction.transaction.lockTime = lastBlockHeight ?? 0
    }

}
