# frozen_string_literal: true

class Entry < ApplicationRecord
  belongs_to :user
  belongs_to :room

  def self.find_another_entry_user(room, current_user_id)
    entries = room.entries
    entries.find { |entry| entry.user_id != current_user_id } # MEMO 別のエントリーユーザー
  end
end
