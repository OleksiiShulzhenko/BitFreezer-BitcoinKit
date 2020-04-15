#
# Be sure to run `pod lib lint BitFreezer-BitcoinKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'BitFreezer-BitcoinKit'
  s.version          = '0.1.1'
  s.summary          = 'Bitcoin derivatives Library for Swift.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
'Bitcoin, BitcoinCash(ABC) and Dash wallet toolkit for Swift. This is a full implementation of wallet creation, restore, send, receive transactions, and more.'
                       DESC

  s.homepage         = 'https://github.com/OleksiiShulzhenko/BitFreezer-BitcoinKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'OleksiiShulzhenko' => 'shulalexex@gmail.com' }
  s.source           = { :git => 'https://github.com/OleksiiShulzhenko/BitFreezer-BitcoinKit.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'

  s.source_files = 'Source/**/*.swift'
  
  s.swift_version = '5'
  
  s.dependency 'OpenSslKit.swift', '~> 1.0'
  s.dependency 'Secp256k1Kit.swift', '~> 1.0'
end
