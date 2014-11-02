
class Settings; end

module SettingsWorker
  def method_missing(name, *args)
    Rails.application.secrets.send(name)
  end

  def respond_to?(name, *args)
    super || !method_missing(name, *args).nil?
  end
end

class << Settings
  include SettingsWorker
end
