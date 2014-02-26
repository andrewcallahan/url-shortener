class Screenshot
  include Sidekiq::Worker

  def perform(link_id)
    link = Link.find(link_id)
    file = Tempfile.new(["template_#{link.id.to_s}", '.jpg'], 'tmp', :encoding => 'ascii-8bit')
    file.write(IMGKit.new(link.given_url, quality: 50, width: 600).to_jpg)
    file.flush
    link.snapshot = file
    link.save
    file.unlink
  end

end
