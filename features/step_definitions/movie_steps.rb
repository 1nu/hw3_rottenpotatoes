# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    #Movie.create!({:title => 'Aladdin', :rating => 'G', :release_date => '25-Nov-1992'})
    #puts movie
    existing_movie = Movie.find_by_title_and_rating(movie["title"], movie["rating"])
    if existing_movie.nil?
      existing_movie = Movie.create!({:title => movie["title"], :rating => movie["rating"], :release_date => movie["release_date"]})
      #puts existing_movie.title
    end
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
  end
  #flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #puts page.body
  (page.body =~ /#{e1}.*?#{e2}/m).should be_true
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

Given /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(/,\s*/).each do |rating|
    if uncheck == 'un'
      step %Q{I uncheck "ratings_#{rating}"} 
    else
      step %Q{I check "ratings_#{rating}"} 
    end
  end
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
end

Then /I should see (all|none) of the movies/ do |what|
  case(what)
    when "all"
      all("tbody#movielist tr").count.should == Movie.count
    when "none"
      all("tbody#movielist tr").count.should == 0
  end
  puts 
end
