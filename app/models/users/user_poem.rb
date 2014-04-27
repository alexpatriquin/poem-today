class UserPoem < ActiveRecord::Base
  belongs_to :poem
  belongs_to :user

  def create_summary_past_tense
    self.summary = "On #{self.created_at.strftime("%B %d")}, "

    if self.match_type == "random"
      self.summary << "with a random word."
    else

      self.summary << "with the word \"#{self.keyword_text}\" "
      case self.keyword_source
      when :first_name
        self.summary << "because that's your name ;)"
      when :birthday
        self.summary << "because it was your birthday :)"
      when :holiday
        holiday_summary
      when :forecast
        forecast_summary
      when :news
        news_summary
      when :twitter
        twitter_summary
      end
    end
    self.save
    self.summary
  end

  def holiday_summary
    self.summary << "because #{self.keyword_text.titleize} was a holiday!"
  end

  def forecast_summary
    self.summary << "which was in the weather forecast for #{self.keyword_source_id}."
  end

  def news_summary
    self.summary << "which was in"
  end

  def twitter_summary
    self.summary << "which was in"
  end

end
