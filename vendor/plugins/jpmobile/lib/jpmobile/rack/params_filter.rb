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

module ActionDispatch
  module Http
    module Parameters
      def parameters
requrie 'pp'
pp "--------------"
pp request_parameters
pp query_parameters
pp path_parameters
pp "--------------"
        @env["action_dispatch.request.parameters"] ||= request_parameters.merge(query_parameters).update(path_parameters).with_indifferent_access
      end
    end
  end
end
