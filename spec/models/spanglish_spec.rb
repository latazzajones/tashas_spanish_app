require 'rails_helper'

describe Spanglish::DailyWord, type: :model do

  it "returns JSON" do
    expect(Spanglish::DailyWord.new.get).to
  end

end
