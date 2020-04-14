# BitFreezer-BitcoinKit

[![CI Status](https://img.shields.io/travis/OleksiiShulzhenko/BitFreezer-BitcoinKit.svg?style=flat)](https://travis-ci.org/OleksiiShulzhenko/BitFreezer-BitcoinKit)
[![Version](https://img.shields.io/cocoapods/v/BitFreezer-BitcoinKit.svg?style=flat)](https://cocoapods.org/pods/BitFreezer-BitcoinKit)
[![License](https://img.shields.io/cocoapods/l/BitFreezer-BitcoinKit.svg?style=flat)](https://cocoapods.org/pods/BitFreezer-BitcoinKit)
[![Platform](https://img.shields.io/cocoapods/p/BitFreezer-BitcoinKit.svg?style=flat)](https://cocoapods.org/pods/BitFreezer-BitcoinKit)

Bitcoin, BitcoinCash(ABC) and Dash wallet toolkit for Swift. This is a full implementation of wallet creation/restore, send/receive transactions, and more.

## Features

- Send/Receive Legacy transactions (*P2PKH*, *P2PK*, *P2SH*)
- [BIP32](https://github.com/bitcoin/bips/blob/master/bip-0032.mediawiki) hierarchical deterministic wallets implementation.
- [BIP39](https://github.com/bitcoin/bips/blob/master/bip-0039.mediawiki) mnemonic code for generating deterministic keys.
- [BIP44](https://github.com/bitcoin/bips/blob/master/bip-0044.mediawiki) multi-account hierarchy for deterministic wallets.
- [BIP21](https://github.com/bitcoin/bips/blob/master/bip-0021.mediawiki) URI schemes, which include payment address, amount, label and other params

### BitcoinKit.swift
- Send/Receive Segwit transactions (*P2WPKH*)
- Send/Receive Segwit transactions compatible with legacy wallets (*P2WPKH-SH*)
- base58, bech32

### BitcoinCashKit.swift
- bech32 cashaddr addresses

### DashKit.swift
- Instant send
- LLMQ lock, Masternodes validation

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

BitFreezer-BitcoinKit is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'BitFreezer-BitcoinKit'
```

## Dependencies

* [OpenSslKit.swift](https://github.com/horizontalsystems/open-ssl-kit-ios) - Crypto functions required for working with blockchain.
* [Secp256k1Kit.swift](https://github.com/horizontalsystems/secp256k1-kit-ios) - Crypto functions required for working with blockchain.

## Author

OleksiiShulzhenko, shulalexex@gmail.com
Horizontal Systems, hsdao@protonmail.ch

## License

BitFreezer-BitcoinKit is available under the MIT license. See the LICENSE file for more info.
