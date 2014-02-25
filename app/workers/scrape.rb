class Scrape
  include Sidekiq::Worker
  # OPTIONAL sidekiq_options retry: false
  # OPTIONAL sidekiq_options queue: "high"

  def perform(link_id)
    link = Link.find(link_id)
    agent = Mechanize.new
    page = agent.get(link.given_url)
    link.title = page.title
    link.save
  end

end
