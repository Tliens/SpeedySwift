#
# Be sure to run `pod lib lint SpeedySwift.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SpeedySwift'
  s.version          = '0.2.2'
  s.summary          = '这是一个app开发的加速库。This is an accelerated library for app'
  s.description      = <<-DESC
这是一个app开发的加速库。This is an accelerated library for app.
                       DESC
  s.homepage         = 'https://github.com/tliens/SpeedySwift'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'tliens' => 'maninios@163.com' }
  s.source           = { :git => 'https://github.com/tliens/SpeedySwift.git', :tag => s.version.to_s }
  s.social_media_url = 'https://github.com/Tliens'
  s.swift_version    = '5.0'
  s.ios.deployment_target = '12.0'
  s.source_files     = 'SpeedySwift/Classes/**/*'
  # dependency
  s.dependency 'SnapKit'
  s.dependency 'Toast-Swift'
  
end
