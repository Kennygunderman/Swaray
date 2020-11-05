
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '14.1'

project 'Swaray', {
  'Mock' => :debug
}

target 'Swaray' do
  use_frameworks!

  # Pods for Swaray
  pod 'SnapKit', '~> 5.0.0'
  pod 'Firebase/Analytics'
  pod 'Firebase/Auth'
  pod 'Firebase/Core'
  pod 'Firebase/Firestore'
  pod 'GoogleSignIn'
  pod 'FBSDKLoginKit'
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
