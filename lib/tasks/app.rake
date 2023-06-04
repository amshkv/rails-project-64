# frozen_string_literal: true

namespace :app do
  desc 'fix counters in DB'
  task fix_counters: :environment do
    Post.find_each do |post|
      Post.reset_counters(post.id, :likes)
    end
  end
end
