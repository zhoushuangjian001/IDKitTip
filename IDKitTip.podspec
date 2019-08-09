#
# Be sure to run `pod lib lint IDKitTip.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'IDKitTip'
  s.version          = '0.1.0'
  s.summary          = 'App 应用中的各种提示'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
                        这是一个可以自定义的 App 各种提示的库,有文字提示、活动指示器提示、可自定义的提示等。
                       DESC

  s.homepage         = 'https://github.com/zhoushuangjian001/IDKitTip'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zhoushuangjian001' => 'zhoushuangjian511@163.com' }
  s.source           = { :git => 'https://github.com/zhoushuangjian001/IDKitTip.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'
  s.swift_version = '4'
  s.source_files = 'IDKitTip/Classes/**/*'
  
  # s.resource_bundles = {
  #   'IDKitTip' => ['IDKitTip/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
