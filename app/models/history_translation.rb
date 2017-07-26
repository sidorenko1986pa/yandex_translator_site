class HistoryTranslation < ApplicationRecord
  belongs_to :user

  validates :text_from, presence: true
  validates :text_to, presence: true
  validates :lang_from, presence: true
  validates :lang_to, presence: true
  validates :user_id, presence: true
end
