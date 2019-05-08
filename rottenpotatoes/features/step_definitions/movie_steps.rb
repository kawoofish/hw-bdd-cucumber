# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create(movie)
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  test1 = page.body.index(e1)
  test2 = page.body.index(e2)
  if e2 < e1 && e1 && e2
    fail "didn't appear in correct order"
  end
end

Then /I should see "(.*)" after "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  test1 = page.body.index(e1)
  test2 = page.body.index(e2)
  if e2 > e1 && e1 && e2
    fail "didn't appear in correct order"
  end
end

Then /see the movie title column header change color/ do
  expect(page).to have_css('th.hilite')
end

Then /see the movie release date column header change color/ do
  expect(page).to have_css('th.hilite')
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I check the following ratings: (.*)/ do |rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(',').each do |rating|
    y = rating.strip.to_s
    find(:css, "#ratings_#{y}").set(true)
  end
end

When /I uncheck the following ratings: (.*)/ do |rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(',').each do |rating|
    y = rating.strip.to_s
    find(:css, "#ratings_#{y}").set(false)
  end
end

Then /I should see all of the movies/ do
  # Make sure that all the movies in the app are visible in the table
  movie_hash = Movie.group(:id).count
  movie_counter = movie_hash.keys.count
  page.all('table#movies tr').count.should == movie_counter + 1
end
