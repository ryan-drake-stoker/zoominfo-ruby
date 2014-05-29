require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

# As noted in the people_search_query input parameters table, the key is made up of a string consisting of 5 parameters concatenated together, and then encrypted with MD5. Parameters are:
#
# The first 2 characters of each search term with a "yes" in the "Key" column, in the order listed in the input parameters table for the given query (below). If the value for a search term has only 1 character, then the key generation should use that single character.
# Your partner password
# Today's day of the month (not padded with zero)
# Today's month (not padded with zero)
# Today's year (4 digit)

include KeyGeneration

describe "API key generation" do
  before do
    Timecop.freeze(Time.local(2012, 5, 15))
  end

  after do
    Timecop.return
  end

  # Using the People Search Query to search the following criteria:
  # "Vice President" for PersonTitle
  # "200714" for IndustryClassification
  # "California" for State
  # The query is run on May 15th, 2012
  # Your assigned partner code is "example"
  # Your assigned password is "testtest"

  it "generates the correct MD5 key" do
    puts Time.now.inspect
    generate_key(['Vice President', '200714', 'California'], "testtest").should eq "60dee80b3c634c2709dbe102c6fe60ea"
  end

end
