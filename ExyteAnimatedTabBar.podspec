Pod::Spec.new do |s|
  s.name             = "ExyteAnimatedTabBar"
  s.version          = "0.1.1"
  s.summary          = "AnimatedTabBar is a tabbar with number of preset animations written in pure SwiftUI"

  s.homepage         = 'https://github.com/exyte/AnimatedTabBar.git'
  s.license          = 'MIT'
  s.author           = { 'Exyte' => 'info@exyte.com' }
  s.source           = { :git => 'https://github.com/exyte/AnimatedTabBar.git', :tag => s.version.to_s }
  s.social_media_url = 'http://exyte.com'

  s.ios.deployment_target = '16.0'
  
  s.requires_arc = true
  s.swift_version = "5.7"

  s.source_files = [
     'Sources/*.h',
     'Sources/*.swift',
     'Sources/**/*.swift'
  ]

end
