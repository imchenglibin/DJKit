platform :ios, '8.0'
inhibit_all_warnings!
target 'DJKit' do
pod 'MMPopupView'
pod 'Masonry'
pod 'AFNetworking', '~> 3.0'
pod 'Aspects'
pod 'MBProgressHUD', '~> 1.0.0'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '8.0'
    end
  end
end

