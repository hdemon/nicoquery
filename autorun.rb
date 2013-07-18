# watch( './app/*\.rb' ) {|md| system("ruby #{md[0]}") }
# watch( './app/*\.rb' ) {|md| system("echo #{md[0]}") }
watch( 'app/(.*)\.rb' ) {|md| system("bundle exec rspec spec/#{md[1]}_spec.rb") }



