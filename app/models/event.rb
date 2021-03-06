class Event < ApplicationRecord
 
  belongs_to :creator, class_name: 'User'

  has_many :attendances, foreign_key: 'attended_event_id', dependent: :destroy
  has_many :attendees, through: 'attendances', source: 'attendee'

  # user_id validation
  validates :creator_id, presence: true

  # title validation
  validates :title, presence: true, 
                    length: {maximum: 255},
                    uniqueness: {case_sensitive: false}
  
  # description validation
  validates :description, presence: true


  scope :past, -> { where("date < ?", Date.today) }
  scope :future, -> { where("date >= ?", Date.today) }
  
  # location validation
  validates :location, presence: true,
                       length: {maximum: 255}
  
  validates :date, not_in_past: true
  

  private

end
