Pod::Spec.new do |s|
  s.name         = "DJKit"
  s.version      = "1.0.0"
  s.summary      = "iOS Kit"
  s.homepage     = "https://github.com/imchenglibin/DJKit"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { 'ziteng' => 'ziteng@dianjia.io' }
  s.source       = { :git => "https://github.com/imchenglibin/DJKit.git", :tag => s.version.to_s }
  s.source_files = 'DJKit/Extensions/**/*.{h,m}, DJKit/Defines/**/*.{h,m}, DJKit/Util/**/*.{h,m}, DJKit/UIKit/**/*.{h,m}'
  s.resources = 'DJKit/**/*.png'
  s.requires_arc = true
end
