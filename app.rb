# frozen_string_literal: true

require 'gosu'
Dir['modules/**/*.rb'].sort.each do |f|
  require_relative f
end

class MirrorWindow < Gosu::Window
  def initialize(language)
    # TODO: Make this url configurable
    # ie. by using a config file or user input
    @server_url = 'localhost:4567'
    temp = Screen.screen_resolution
    @window_width = temp[0].to_i
    @window_height = temp[1].to_i
    super(@window_width, @window_height)
    @font = Gosu::Font.new(self, Gosu.default_font_name, 20)
    Translation.new(language, @server_url)

    @margin = 20

    @scale_x = 1.4
    @scale_y = 1.4
    
    @width_offsets = []
    @width_offsets << (@font.text_width("<b>#{TimeComponent.new.time}</b>")*@scale_x)
    @width_offsets << (@font.text_width("#{TimeComponent.new.date.reverse[0]}"\
      " #{TimeComponent.new.date.reverse[1]} #{TimeComponent.new.date.reverse[2]}")*@scale_x)
    p @width_offsets

  end
  
  def update; end
  
  def draw
    @font.draw_markup("<b>#{TimeComponent.new.time}</b>", (@window_width - @width_offsets[0] - @margin), @margin, 1, scale_x = @scale_x, scale_y = @scale_y)
    @font.draw_markup("#{TimeComponent.new.date.reverse[0]}"\
      " #{TimeComponent.new.date.reverse[1]} #{TimeComponent.new.date.reverse[2]}",
      (@window_width - @width_offsets[1] - @margin), 60, 1, scale_x = @scale_x, scale_y = @scale_y)
    end
  end
  
  window = MirrorWindow.new('en')
  window.show
  