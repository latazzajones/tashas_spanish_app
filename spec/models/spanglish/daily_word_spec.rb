require 'rails_helper'

describe Spanglish::DailyWord do

  it 'returns a word!' do
    expect(Spanglish::DailyWord.new.get).to eq ""
  end
end
