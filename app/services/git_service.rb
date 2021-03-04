# require "json"
# require "faraday"

class GitService
  def self.repo_name
    get_data('https://api.github.com/repos/duguy8/little-esty-shop')[:name]
  end

  def self.contributors
    get_data('https://api.github.com/repos/duguy8/little-esty-shop/contributors')
  end

  def self.screen_contributors
    contributors.reduce([]) do |acc, contributor|
      if ['duguy8', 'Trevor-Robinson', 'Wil-McC'].include?(contributor[:login])
        acc << contributor
      end
      acc
    end
  end

  def self.prs
    get_data("https://api.github.com/repos/duguy8/little-esty-shop/pulls?state=all").length
  end

  def self.get_data(url)
    response = Faraday.get(url) do |req|
      req.headers['Authorization'] = "token #{ENV['github_token']}"
    end
    data = response.body
    JSON.parse(data, symbolize_names: true)
  end
end
