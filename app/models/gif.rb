class Gif < ApplicationRecord
    validates :link, presence: true, uniqueness: true
    has_many :rankings, dependent: :destroy

    def recalculate_global_rank
        total_ratings = rankings_array.each_with_index.sum { |count, index| count * (index * 0.5) }
        total_count = rankings_array.sum
        self.global_rank = total_count.zero? ? 0 : (total_ratings / total_count).round(2)
        save
    end

    def add_rating(rating)
        index = (rating * 2).to_i
        rankings_array[index] += 1
        recalculate_global_rank
        self.rank_count+=1;
    end

    def remove_rating(rating)
        index = (rating * 2).to_i
        rankings_array[index] -= 1
        recalculate_global_rank
        self.rank_count-=1;
    end

    def switch_rating(old_rating, new_rating)
        index = (old_rating * 2).to_i
        rankings_array[index] -= 1
        index = (new_rating * 2).to_i
        rankings_array[index] += 1
        recalculate_global_rank
    end
end
