class UserGroup < ActiveRecord::Base
  validates :name, presence: true, length: {minimum: 10, maximum: 100}
  validates :color, presence: true, format: { with: %r{\A(#[0-9A-Fa-f]{6})\z}}
  validates :logo, length: {maximum: 200}
  validates :website, length: {maximum: 200}
  validates :description, length: {maximum: 400}   # html is allowed
  validates :facebook_page, length: {maximum: 200}
  validates :googleplus_page, length: {maximum: 200}

  scope :with_twitter, -> { where('twitter_account is not null') }
  has_many :events, -> { order('happens_at asc') }, foreign_key: :user_group_id

  validates :twitter_account, length: {maximum: 200},
            format: { with: %r{\A(\@\w+|)\z} }, if: ->(r) { r.twitter_account.present? }

  belongs_to :user
end