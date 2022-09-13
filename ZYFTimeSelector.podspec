#
# Be sure to run `pod lib lint ZYFTimeSelector.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ZYFTimeSelector'
  s.version          = '0.0.4'
  s.summary          = '时间选择 5分钟一个跨度,支持无线循环,支持显示传入时间，样式和时间 等可看代码自行修改或者联系我 13534070946'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/Zyf893549897/ZYFTimeSelector'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '张云飞' => '893549897@qq.com' }
  s.source           = { :git => 'https://github.com/Zyf893549897/ZYFTimeSelector.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'ZYFTimeSelector/Classes/**/*.{h,m,xib}'
  
  # s.resource_bundles = {
  #   'ZYFTimeSelector' => ['ZYFTimeSelector/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
