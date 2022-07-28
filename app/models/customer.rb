class Customer < ActiveRecord::Base
    has_many :reviews
    has_many :restaurants, through: :reviews

    def full_name
        "#{first_name} #{last_name}"
    end

    def favorite_restaurant
        self.reviews.all.order("star_rating").last.restaurant

    end

    def add_review(restaurant, rating)
        Review.create(star_rating: rating, restaurant: restaurant, customer: self)
    end

    def delete_reviews(restaurant)
        reviews = Review.where(restaurant_id: restaurant.id, customer_id: self.id)
        reviews.destroy_all
    end

end