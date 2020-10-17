class Workshop < ApplicationRecord
  validates :name, :short_description, :full_description, :duration,
            :attendees, :workshop_date, :start_time, presence: true

	enum status: { draft: 0, active: 1, inactive: 2 }

  def human_status
    I18n.t("activerecord.attributes.#{model_name.i18n_key}.status.#{status}")
  end
end
