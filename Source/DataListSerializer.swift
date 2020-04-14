//
//  DataListSerializer.swift
//  BitFreezer-BitcoinKit
//
//  Created by Oleksii Shulzhenko on 25.03.2020.
//

import Foundation

public class DataListSerializer {

    static func serialize(dataList: [Data]) -> Data {
        var data = Data()
        data += VarInt(dataList.count).serialized()
        for witness in dataList {
            data += VarInt(witness.count).serialized() + witness
        }
        return data
    }

    static func deserialize(byteStream: ByteStream) -> [Data] {
        var data = [Data]()
        let count = byteStream.read(VarInt.self)
        for _ in 0..<Int(count.underlyingValue) {
            let dataSize = byteStream.read(VarInt.self)
            data.append(byteStream.read(Data.self, count: Int(dataSize.underlyingValue)))
        }

        return data
    }

    static func deserialize(data: Data) -> [Data] {
        return deserialize(byteStream: ByteStream(data))
    }
}
