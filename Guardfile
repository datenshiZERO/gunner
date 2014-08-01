guard 'puma', :port => 3000 do
  watch('Gemfile.lock')
  watch('app.rb')
end

guard 'livereload' do
  watch(%r{views/.+\.(erb|haml|slim)$})
  watch(%r{assets/javascripts/.+\.(js|coffee|erb)$})
  watch(%r{assets/stylesheets/.+\.(css|scss)$})
end
