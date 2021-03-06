class Movie < ActiveRecord::Base

	validates :title, :released_on, :duration, presence: true

	validates :description, length: {minimum: 25}

	validates :total_gross, numericality: {greater_than_or_equal_to: 0}

	RATINGS = %w(G PG PG-13 R NC-17)

	validates :rating, inclusion: {in: RATINGS}

	has_many :reviews, dependent: :destroy


	has_attached_file :image, styles: {medium: "300x300>", thumb: "100x100>"}, default_url: "/images/:style/placeholder.png"
	validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
	def flop?
		total_gross.blank? || total_gross < 50000000
	end

	def unrated?
		rating.blank?		
	end

	def self.released
		where("released_on <= ?",Time.now).order("released_on desc")
	end

	def self.hit
		where("total_gross >= 3000000000").order("total_gross desc")
	end

	def self.flop
		where("total_gross <= 50000000").order("total_gross")
	end

	def self.recently
		order('created_at').limit(5)
	end

	def validate_title(movie)
		movie.errors[:title]
	end

	def average_stars
	  reviews.average(:stars)
	end

end
