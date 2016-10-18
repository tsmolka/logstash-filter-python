# encoding: utf-8

require "logstash/devutils/rspec/spec_helper"
require "logstash/filters/python"

describe LogStash::Filters::Python do

  describe "set single field" do
    config <<-CONFIG
      filter {
        python {
          code => "
            if event.getField('data') == 'A':
              event.setField('data','B')
          "
        }
      }
    CONFIG

    sample("data"=>"A") do
      insist { subject.get("data") } == "B"
    end
  end

end
