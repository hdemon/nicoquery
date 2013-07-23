watch( 'app/(.*)\.rb' ) {|md| system("bundle exec rspec spec/#{md[1]}_spec.rb") }
watch( 'spec/(.*)\.rb' ) {|md| system("bundle exec rspec spec/#{md[1]}.rb") }



