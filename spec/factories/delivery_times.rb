FactoryBot.define do
  factory :delivery_time do
    delivery_time_details_attributes [
                                       { time: '8時〜12時' },
                                       { time: '12時〜14時' },
                                       { time: '14時〜16時' },
                                       { time: '16時〜18時' },
                                       { time: '18時〜20時' },
                                       { time: '20時〜21時' }
                                     ]
  end
end
