# Generate debug command for javascript
def debug(msg, param = nil)
  if Rails.env.development?
    if param && msg
      return "debug(\"#{msg}\" + #{param});"
    elsif msg
      return "debug(\"#{msg}\");"
    elsif param
      return "debug(#{param});"
    end
  end
  return nil
end

# Generate debug function for javascript
def debug_js_function
  Rails.env.development? ?
  "var debug = function(obj){\n\
    if (typeof(obj) == 'string')\n\
      console.debug('Spymaster: ' + obj);\n\
    else\n\
      console.debug(obj);\n\
  };" : nil
end

# Render a javascript file
def render_part(name, assigns = {})
  fpath = Dir.glob(Rails.root.join("client-api/js/components/_#{name}.*")).first
  return nil if not fpath
  template = File.new(fpath).read
  result = ERB.new(template).result(OpenStruct.new(assigns).instance_eval { binding })
  return result
end

def domain
  'http://localhost:3000'
end
