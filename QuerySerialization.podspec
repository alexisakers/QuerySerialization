Pod::Spec.new do |s|
  s.name         = "QuerySerialization"
  s.version      = "0.1"
  s.summary      = "Encode and Decode Query Strings in Swift"
  s.description  = <<-DESC
    QuerySerialization allows you to encode dictionaries into query strings, and to decode query strings to dictionaries. It also supports automatic percent encoding/decoding.
  DESC
  s.homepage     = "https://github.com/alexaubry/QuerySerialization"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Alexis Aubry Radanovic" => "aleks@alexis-aubry-radanovic.me" }
  s.social_media_url   = "https://twitter.com/leksantoine"
  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.9"
  s.watchos.deployment_target = "2.0"
  s.tvos.deployment_target = "9.0"
  s.source       = { :git => "https://github.com/alexaubry/QuerySerialization.git", :tag => s.version.to_s }
  s.source_files  = "Sources/**/*"
  s.frameworks  = "Foundation"
end
