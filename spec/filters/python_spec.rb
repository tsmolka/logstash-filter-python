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
            
            if event.getField('action') == 'parse_json':
              import json
              event.setField('data',json.loads(event.getField('data')))
          "
        }
      }
    CONFIG

    sample("data"=>"A") do
      insist { subject.get("data") } == "B"
    end
    
    sample("data"=>{"a"=>"b"}) do
      insist { subject.get("data") } == {"a"=>"b"}
    end
    
    sample("action"=>"parse_json", "data"=>"{\"a\": \"b\"}") do
      insist { subject.get("data") } == {"a"=>"b"}
    end
  end

end
