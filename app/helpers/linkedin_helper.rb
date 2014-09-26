module LinkedinHelper
  class ToLinkedin

    def login
      "https://www.linkedin.com/uas/oauth2/authorization?response_type=code&client_id=#{ENV["LINKEDIN_API_KEY"]}&scope=r_fullprofile%20r_emailaddress%20r_network%20r_basicprofile%20r_contactinfo&state=#{ENV["STATE"]}&redirect_uri=#{ENV["REDIRECT_URI"]}"
    end

    def get_access_token(auth_code)
      response = HTTParty.get("https://www.linkedin.com/uas/oauth2/accessToken?"+
      "grant_type=authorization_code&code=#{auth_code}"+
      "&redirect_uri=#{ENV['REDIRECT_URI']}"+
      "&client_id=#{ENV['LINKEDIN_API_KEY']}&client_secret=#{ENV['LINKEDIN_SECRET_KEY']}")
    access_token = response['access_token']
    access_token
    end
  end
end