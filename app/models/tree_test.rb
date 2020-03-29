class TreeTest < ApplicationRecord
  belongs_to :user
  has_many :tree_test_tasks, dependent: :destroy

  has_secure_token :auth_token

  accepts_nested_attributes_for :tree_test_tasks, allow_destroy: true

  def as_json(*)
    super.tap do |hash|
      hash[:created_at_day] = created_at.strftime('%-m/%-d/%Y')
      hash[:collect_url] = Rails.application.routes.url_helpers.tree_test_collect_url(auth_token: auth_token)
    end
  end
end
