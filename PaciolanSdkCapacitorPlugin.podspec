
  Pod::Spec.new do |s|
    s.name = 'PaciolanSdkCapacitorPlugin'
    s.version = '2.0.1'
    s.summary = 'A capacitor plugin for the Paciolan ticketing SDK.'
    s.license = { type: 'No License' }
    s.homepage = 'https://github.com/Paciolan/mSDK-capacitor-plugin'
    s.author = { 'Paciolan Mobile Team' => 'pacmobile@paciolan.com' }
    s.source = { :git => 'https://github.com/Paciolan/mSDK-capacitor-plugin', :tag => s.version.to_s }
    s.source_files = 'ios/Plugin/**/*.{swift,h,m,c,cc,mm,cpp}'
    s.ios.deployment_target  = '11.0'
    s.dependency 'Capacitor'
    s.dependency 'PaciolanSDK', '4.5.0'
  end
