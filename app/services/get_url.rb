module GetUrl

  def get_data(url)
    response = Faraday.get(url) do |req|
      req.headers['Authorization'] = "token #{ENV['github_token']}"
    end
    data = response.body
    JSON.parse(data, symbolize_names: true)
  end
end
