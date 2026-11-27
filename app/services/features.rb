require "yaml"

class Features
  def self.config
    features = YAML.load_file(Rails.root.join("config/features.yml"))
    return [] unless features.is_a?(Hash)

    features.map do |feat, availability|
      [feat, availability.to_s.chars.map { |a| a == "1" }]
    end
  end
end
