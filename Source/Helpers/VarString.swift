//
//  VarString.swift
//  BitFreezer-BitcoinKit
//
//  Created by Oleksii Shulzhenko on 25.03.2020.
//

import OpenSslKit

public struct VarString : ExpressibleByStringLiteral {
    public typealias StringLiteralType = String
    let length: VarInt
    let value: String

    public init(stringLiteral value: String) {
        self.init(value)
    }

    init(_ value: String) {
        self.value = value
        length = VarInt(value.data(using: .ascii)!.count)
    }

    func serialized() -> Data {
        var data = Data()
        data += length.serialized()
        data += value
        return data
    }
}

extension VarString : CustomStringConvertible {
    public var description: String {
        return "\(value)"
    }
}
