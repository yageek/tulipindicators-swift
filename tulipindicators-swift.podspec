Pod::Spec.new do |spec|
  spec.name         = "tulipindicators-swift"
  spec.version      = "1.0.1"
  spec.summary      = "A technical analysis library around tulip"
  spec.description  = <<-DESC
  This swift package offers a technical analysis
  function by wrapping the tulip C library.
                   DESC
  spec.homepage     = "https://github.com/yageek/tulipindicators-swift"
  spec.license      = "LGPLv3"
  spec.author             = { "Yannick Heinrich" => "yannick.heinrich@gmail.com" }
  spec.social_media_url   = "https://twitter.com/yageek"
  spec.source       = { :git => "https://github.com/yageek/tulipindicators-swift.git", :tag => "#{spec.version}" }
  spec.source_files  = "Sources/**/*.{h,m,c}"
  spec.ios.deployment_target = '8.0'
  spec.osx.deployment_target = '10.8'
  spec.tvos.deployment_target = '9.0'
  spec.watchos.deployment_target = '2.0'
end
