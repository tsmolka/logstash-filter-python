# encoding: utf-8
require "logstash/filters/base"
require "logstash/namespace"
require "jython"

# Execute python code.
class LogStash::Filters::Python < LogStash::Filters::Base
  config_name "python"

  # Any code to execute at logstash startup-time
  config :init, :validate => :string

  # The code to execute for every event.
  # You will have an `event` variable available that is the event itself.
  config :code, :validate => :string, :required => true

  def register
    @interpreter = Jython::Interpreter.new()
    @interpreter.eval(@init) if @init
    @codeblock = @interpreter.compile(remove_indent(@code))
  end # def register

  def filter(event,&block)
    begin
      @interpreter.set('event', event.to_java)
      event = @interpreter.exec(@codeblock, 'event')
      filter_matched(event)
    rescue Exception => e
      @logger.error("Python exception occurred: #{e}")
      event.tag("_pythonexception")
    end
  end
  
  private
  def remove_indent(code)
    prefix = nil
    code.gsub(/^[ \t]+$/, '').scan(/^[ \t]+/).each do |indent|
      if !prefix or indent.length < prefix.length
        prefix = indent
      end
    end
    if !prefix.nil?
      code = code.gsub(/^[ \t]{#{prefix.length}}/, '') 
    end
    code
  end
end