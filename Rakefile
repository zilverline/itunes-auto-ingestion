require 'rake'

begin
  require 'jeweler'

  Jeweler::Tasks.new do |s|
    s.name = "itunes_ingestion"
    s.description = "A simple port of Apple itunes Autoingestion tool to ruby."
    s.summary = "A simple port of Apple itunes Autoingestion tool to ruby."
    s.authors = ["Francis Chong", "Michael Franken"]
    s.email = "mfranken@zilverline.com"
    s.homepage = "http://github.com/zilverline/itunes-auto-ingestion"
    s.files = FileList["[A-Z]*", "{bin,lib,spec}/**/*"]
    s.test_files = FileList["{spec}/**/*"]
    s.extra_rdoc_files = [ 'README.rdoc' ]
  end

  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end
