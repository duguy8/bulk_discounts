class GitService
  extend GetUrl

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
end
