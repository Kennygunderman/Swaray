
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'

project 'Swaray', {
  'Mock' => :debug
}

target 'Swaray' do
  use_frameworks!

  # Pods for Swaray
  pod 'SnapKit', '~> 4.0.0'
  pod 'Firebase/Analytics'
  pod 'Firebase/Auth'
  pod 'Bond'

  target 'SwarayTests' do
    inherit! :search_paths
    # Pods for testing
  end
end

target 'SwarayUITests' do
  inherit! :search_paths
  # Pods for testing
end
