require 'spec_helper'

describe ForecastPoem do
  describe 'matches forecast keywords to poems' do
    it 'matches forecast keywords to poems' do
      @keywords = ["cloudy", "meatballs"]
      poem = Poem.create(:title => "A cloudy day")
      # binding.pry
      expect(ForecastPoem.match_forecast_keywords_to_poems).to match_array([poem])
    end
  end
end
