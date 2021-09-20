class Link < ApplicationRecord
  belongs_to :linkable, polymorphic: true
  validates :name, :url, presence: true
  validates :url, format: URI::regexp(%w[http https])

  def gist?
    URI.parse(url).host.include?('gist.')
  end
end
