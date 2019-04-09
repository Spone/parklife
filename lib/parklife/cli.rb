require 'thor'

module Parklife
  class CLI < Thor
    desc 'build', 'create a production build'
    def build
      application.build
    end

    desc 'routes', 'list all defined routes'
    def routes
      application.routes.to_a.sort.each do |route|
        puts route
      end
    end

    private
      def application
        @application ||= begin
          # Reach inside the consuming app's directory to load Parklife and
          # apply its config. It's only at this point that the
          # Parklife::Application is defined.
          require discover_parklife_rb(Dir.pwd)

          Parklife.application
        end
      end

      def discover_parklife_rb(dir)
        File.expand_path('parklife.rb', dir)
      end
  end
end