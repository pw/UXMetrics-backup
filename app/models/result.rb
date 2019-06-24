class Result < ApplicationRecord
  belongs_to :cardtest
  serialize :data, JSON
end
