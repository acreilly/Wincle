class SearchAlgorithm

  def initialize (listing, collection)
    @listing = listing
    @collection = collection
  end

  def search
    @collection.sort_by { |match| score(match) }.reverse
  end

  def score(match)
    score = 100
    score -= 50 if @listing.industry != match.industry
    score -= 30 if @listing.job_title != match.job_title
    score -= 20 if @listing.location != match.location
    # points = ((distance_between(@listing.latitude, @listing.longitude, match) - 1) * 5).floor
    # score -= points if points > 0

    # # points = (days_apart(@listing.event_date, match.event_date) * 30).floor
    # score -= points if points > 0
    score
  end

  def distance_between(target_lat, target_lng, match)
    match_lat = match.latitude
    match_lng = match.longitude

    r = 6371
    pi_const = Math::PI / 180

    theta1 = target_lat * pi_const
    theta2 = match_lat * pi_const

    deltaTheta = (match_lat - target_lat) * pi_const
    deltaLambda = (match_lng - target_lng) * pi_const

    a = Math.sin(deltaTheta/2) ** 2
    a += Math.cos(theta1) * Math.cos(theta2) * Math.sin(deltaLambda/2) ** 2
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))
    distance = r * c
  end

  def days_apart(target_date, match_date)
    ((target_date - match_date)/86400).abs
  end

end

