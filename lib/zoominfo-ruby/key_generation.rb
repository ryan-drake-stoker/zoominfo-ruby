# As noted in the people_search_query input parameters table, the key is made up of a string consisting of 5 parameters concatenated together, and then encrypted with MD5. Parameters are:
#
# The first 2 characters of each search term with a "yes" in the "Key" column, in the order listed in the input parameters table for the given query (below). If the value for a search term has only 1 character, then the key generation should use that single character.
# Your partner password
# Today's day of the month (not padded with zero)
# Today's month (not padded with zero)
# Today's year (4 digit)
module KeyGeneration
  def generate_key(search_terms, password)
    search_term_prefaces = ""
    date_formatted = Time.now.strftime("%-d%-m%-Y")
    search_terms.each do |search_term|
      search_term_prefaces << search_term[0..1]
    end

    return Digest::MD5.hexdigest(search_term_prefaces + password + date_formatted)
  end
end
