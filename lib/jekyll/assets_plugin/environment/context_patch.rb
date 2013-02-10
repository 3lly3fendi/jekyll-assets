module Jekyll
  module AssetsPlugin
    class Environment
      module ContextPatch

        def site
          self.class.instance_variable_get :@site
        end


        def asset_path *args
          site.asset_path(*args)
        end

      end
    end
  end
end
