

guard :minitest , all_on_start: false do
  sys_tests = "test/integration"
  # with Minitest::Unit
  watch(%r{^test/(.*)\/?(.*)_test\.rb$})
  watch(%r{^app/controllers/merged/([^/]+)_([^/]+)\.rb$})     { |m| Dir["test/integration/#{m[1]}*_test.rb"] }
  watch(%r{^app/models/merged/([^/]+)\.rb$})     { |m| Dir["test/models/#{m[1]}*_test.rb"] }
  watch(%r{^app/views/merged/([^/]+)\/([^/]+)\.haml$}){ |m| Dir["test/integration/#{m[1]}_#{m[2]}_test.rb"] }
  watch(%r{^test/test_helper\.rb$})      { 'test' }
end
