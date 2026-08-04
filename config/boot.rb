# Windows workaround: MSYS2/make is broken (Win32 error 5), so Bundler cannot
# rebuild default gems (json, prism, etc.). Use system gems directly for now.
# Set USE_BUNDLER=1 after fixing MSYS2 (`ridk install`) to restore normal Bundler.

if ENV["USE_BUNDLER"] == "1"
  ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../Gemfile", __dir__)
  require "bundler/setup"
else
  ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../Gemfile", __dir__)
end
