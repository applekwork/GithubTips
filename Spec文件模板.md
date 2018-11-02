#
# Be sure to run `pod lib lint OperationalActivity.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'OperationalActivity'
  s.version          = '0.2.2'
  s.summary          = '运营活动模块'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  运营活动广告获取和上传
                       DESC

  s.homepage         = 'git@dev.xx.com:iOS_librarys/OperationalActivity.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'guolijun' => 'xx@xx.com' }
  s.source           = { :git => 'git@dev.xx.com:iOS_librarys/OperationalActivity.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'OperationalActivity/Classes/**/*'
  
  s.resource_bundles = {
     'OperationalActivity' => ['OperationalActivity/Assets/*.png']
   }

  s.public_header_files = 'OperationalActivity/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
   s.dependency 'AFNetworking', '= 3.2.1'
   s.dependency 'MJExtension', '= 3.0.15.1'
   s.dependency 'SDWebImage', '=4.2.2'
   s.dependency 'Masonry', '~> 1.1.0'
   s.dependency 'YYModel', '= 1.0.4'
end


