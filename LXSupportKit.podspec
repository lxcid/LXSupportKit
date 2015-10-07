Pod::Spec.new do |s|
  s.name             = "LXSupportKit"
  s.version          = "0.1.1"
  s.summary          = "A collection of codes to support my iOS development."
  s.description      = <<-DESC
                       A collection of codes to support my iOS development.

                       - LXDeltaCalculation have been absorb by LXSupportKit.
                       DESC
  s.homepage         = "https://github.com/lxcid/LXSupportKit"
  s.license          = 'MIT'
  s.author           = { "Stan Chang Khin Boon" => "me@lxcid.com" }
  s.source           = { :git => "https://github.com/lxcid/LXSupportKit.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/lxcid'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'LXSupportKit/**/*.{m,h}'
  s.public_header_files = 'LXSupportKit/**/*.h'
  s.frameworks = 'Foundation'
end
