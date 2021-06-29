Pod::Spec.new do |spec|
  spec.name         = "JumpShot"
  spec.version      = "1.0.0"
  spec.summary      = "A framework for accessing the NBA API for iOS written in Swift."
  spec.description  = <<-DESC
                    A framework for accessing the NBA API for iOS written in Swift. Quickly add NBA data to your app including: player, team, game and league leaders.
                   DESC
  spec.homepage     = "https://github.com/JerelRocktaschel/JumpShot"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "jerel_rocktaschel" => "jerel.rocktaschel@gmail.com" }
  spec.ios.deployment_target     = "10.0"
  spec.source       = { :git => "https://github.com/JerelRocktaschel/JumpShot.git", :tag => "#{spec.version}" }
  spec.source_files = "JumpShot/**/*.swift"
  spec.swift_version = "5.0"
end