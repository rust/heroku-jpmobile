# -*- coding: utf-8 -*-
# リクエストパラメータの変換
module Jpmobile
  module Rack
    class ParamsFilter
      def initialize(app)
        @app = app
      end

      def call(env)
        # 入力
        if env['rack.jpmobile']
          # フォームのパラメータ
          if env['REQUEST_METHOD'] == 'POST'
puts "jpmobile - filter"
            form_params = env['rack.jpmobile'].to_internal(URI.decode(env['rack.input'].read))
            env['rack.input'] = StringIO.new(URI.encode(form_params))
          end

          # URI Query
          query_string = URI.decode(env['QUERY_STRING'])
          unless query_string == env['QUERY_STRING']
            env['QUERY_STRING'] = URI.encode(env['rack.jpmobile'].to_internal(query_string))
          end
        end

        status, env, body = @app.call(env)

        [status, env, body]
      end
    end
  end
end

module Rack
  class Request
    def POST
      if @env["rack.input"].nil?
        raise "Missing rack.input"
      elsif @env["rack.request.form_input"].eql? @env["rack.input"]
        @env["rack.request.form_hash"]
      elsif form_data? || parseable_data?
        @env["rack.request.form_input"] = @env["rack.input"]
        unless @env["rack.request.form_hash"] = parse_multipart(env)
          form_vars = @env["rack.input"].read

          # Fix for Safari Ajax postings that always append \0
          form_vars.sub!(/\0\z/, '')

          @env["rack.request.form_vars"] = form_vars
          @env["rack.request.form_hash"] = parse_query(form_vars)

          @env["rack.input"].rewind
        end
comment = @env["rack.request.form_hash"]["guestbook"]["comment"]
str = ""
comment.each_byte{|s| str << "%x " % s}
puts str

        @env["rack.request.form_hash"]
      else
        {}
      end
    end
  end
end
