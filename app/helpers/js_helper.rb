module JsHelper

  def renderBindClicks(tags)
    click_tags = tags.inject([]) do |click_tags, tag|
      if tag&.trigger[:value] == 'click'
        event_type = tag&.selector[:dom]
        selector = if event_type == "classes element"
         ".#{tag&.selector[:value]}"
       elsif event_type == "id element"
         "\##{tag&.selector[:value]}"
        end
        if selector.present?
          click_tags << "'#{selector}'"
        end
      end
      click_tags
    end
    if click_tags.present?
      return "[#{click_tags.uniq.join(', ')}].forEach(bindClick);".html_safe
    end
  end

def renderBindClickExtend(tags)
  selector = nil
  attribute = nil
  click_tags = []
  tags.each do |tag|
    obj_temp = {}
    if tag&.trigger[:value] == 'click'
      if tag&.handle[:value] == 'other' && !tag&.handle[:other_handle].blank?
        attribute = tag&.handle[:other_handle].chomp
        event_type = tag&.selector[:dom]
        if event_type == "classes element"
          selector = ".#{tag&.selector[:value]}"
        elsif event_type == "id element"
          selector = "\##{tag&.selector[:value]}"
        end
        obj_temp["attr"] = attribute
        obj_temp["selector"] = selector
        click_tags.push(obj_temp)
      else
        event_type = tag&.selector[:dom]
        if event_type == "classes element"
          selector = ".#{tag&.selector[:value]}"
        elsif event_type == "id element"
          selector = "\##{tag&.selector[:value]}"
        end
        obj_temp["selector"] = selector
        click_tags.push(obj_temp)
      end
    end
  end
  return "#{click_tags.to_json}.forEach(bindClickExtend);".html_safe
end


  def renderImport(tags)
    import_tag = tags.inject([]) do |import_tags, tag|
      trigger_other_value = if tag&.trigger[:value] == 'other'
         "#{tag&.trigger[:other_value]}"
      end
      if trigger_other_value.present?
        import_tags.push(trigger_other_value)
      end
      import_tags
    end
    if import_tag.present?
      return "#{import_tag.uniq.join("\n")}".html_safe
    end
  end

  def renderBindFocus(tags)
    focus_tags = tags.inject([]) do |focus_tags, tag|
      if tag&.trigger[:value] == 'focus'
        event_type = tag&.selector[:dom]
        selector = if event_type == "classes element"
         ".#{tag&.selector[:value]}"
       elsif event_type == "id element"
         "\##{tag&.selector[:value]}"
        end
        if selector.present?
          focus_tags << "'#{selector}'"
        end
      end
      focus_tags
    end
    if focus_tags.present?
      return "bindFocus([#{focus_tags.uniq.join(', ')}]);".html_safe
    end
  end
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
    # fpath = Dir.glob(Rails.root.join("client-api/js/components/_#{name}.*")).first
    # return nil if not fpath
    # template = File.new(fpath).read
    # result = ERB.new(template).result(OpenStruct.new(assigns).instance_eval { binding })
    # return result
    render partial: name, locals: assigns
  end

  def domain
    Rails.env.development? ? 'http://localhost:3000' : 'https://tracking.pedia.vn'
  end



end
