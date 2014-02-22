class Link < ActiveRecord::Base

  after_create :generate_slug

  def generate_slug
    self.slug = self.id.to_s(36)
    self.save
  end

end
