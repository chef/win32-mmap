# This will run ruby test on windows platform

Write-Output "--- Bundle install"

bundle config --local path vendor/bundle
bundle install --jobs=7 --retry=3

Write-Output "--- Bundle Execute"

bundle exec rake 
