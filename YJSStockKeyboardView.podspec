#
# Be sure to run `pod lib lint YJSStockKeyboardView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'YJSStockKeyboardView'
  s.version          = '1.0.0'
  s.summary          = '一款适用于股票应用的键盘框架，一行代码接入，方便使用'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/YuanJiaShuai/YJSStockKeyboardView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'YuanJiaShuai' => '1361253662@qq.com' }
  s.source           = { :git => 'https://github.com/YuanJiaShuai/YJSStockKeyboardView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.subspec 'Core' do |core|
    core.source_files = 'YJSStockKeyboardView/*.{h,m}'
    core.resources = 'YJSStockKeyboardView/YJSStockKeyboardView.bundle'
  end

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
