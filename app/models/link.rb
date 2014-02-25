class Link < ActiveRecord::Base
  mount_uploader :snapshot, SnapshotUploader

  after_create :generate_slug, :screenshot_scrape#, :scrape_title

  def generate_slug
    self.slug = self.id.to_s(36)
    self.save
  end

  def display_slug
    ENV['BASE_URL'] + self.slug
  end

  # def get_screenshot
  #   kit = IMGKit.new(self.given_url)
  #   file = kit.to_file('public/file.png')

  #   # hsh = Phantoshot.make_screenshot(self.homepage_url, width: w, height: h)
  #   # open("public/images/homepages/#{self.id}.png", "wb"){ |f| f.write(hsh.image_data) }
  #   # self.homepage_screenshot = "/images/homepages/#{self.id}.png"
  #   # file = "public/images/homepages/#{self.id}.png"
  #   # AWS::S3::S3Object.store(file, open(file), 'data-testing.skift.com', :access => :public_read)
  # end

  #   after_create :take_snapshot

    # private

  def screenshot_scrape
    Screenshot.perform_async(self.id)
    Scrape.perform_async(self.id)
  end

  # def take_snapshot
  #   file = Tempfile.new(["template_#{self.id.to_s}", '.jpg'], 'tmp', :encoding => 'ascii-8bit')
  #   file.write(IMGKit.new(self.given_url, quality: 50, width: 600).to_jpg)
  #   file.flush
  #   self.snapshot = file
  #   self.save
  #   file.unlink
  # end

end
