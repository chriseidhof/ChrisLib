Pod::Spec.new do |s|
  s.name         = "ChrisLib"
  s.version      = "0.0.1"
  s.summary      = "Yet another project with utility stuff."
  # s.description  = <<-DESC
  #                   An optional longer description of ChrisLib
  #
  #                   * Markdown format.
  #                   * Don't worry about the indent, we strip it!
  #                  DESC
  s.homepage     = "https://github.com/chriseidhof/ChrisLib"

  s.license      = 'MIT'

  s.author       = { "Chris Eidhof" => "chris@eidhof.nl" }
  s.source       = { :git => "https://github.com/chriseidhof/ChrisLib.git", :commit => "b8c4362315620a0c8847ecd6ddbede63eff1b716" }

  s.ios.deployment_target = '5.0'
  s.osx.deployment_target = '10.7'

  s.source_files = 'ChrisLib', 'ChrisLib/**/*.{h,m}'

  s.framework  = 'CoreData'

  s.requires_arc = true
end
