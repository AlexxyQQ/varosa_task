Pod::Spec.new do |s|
  s.name             = 'device_info_channel'
  s.version          = '0.0.1'
  s.summary          = 'A Flutter package that provides device information using MethodChannel.'
  s.description      = <<-DESC
A Flutter package that provides device information using MethodChannel.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '9.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end 