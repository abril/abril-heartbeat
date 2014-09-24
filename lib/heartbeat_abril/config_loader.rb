module HeartbeatAbril
  class ConfigLoader
    def self.load
      @file ||= load_file
    end

    def self.set_file(file_path)
      @file_path = file_path
    end

    def self.load_file
      return {} unless @file_path

      ::YAML.load_file(@file_path)
    end
  end
end
