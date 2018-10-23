module TagImportable
  def self.included base
    base.has_and_belongs_to_many :tags, inverse_of: nil
    base.extend ClassMethod
  end

  module ClassMethod

    def set_importable_tag_sources(*sources)
      @importable_sources = importable_sources | sources
    end

    def importable_sources
      @importable_sources ||= []
    end
  end

  def tag_sources(results = [])
    self.class.importable_sources.inject(results) do |results, sym|
      ret = *self.send(sym)
      ret.inject(results) do |recursive_results, recursive_target|
        if !recursive_results.include?(recursive_target)
          recursive_results << recursive_target
          if recursive_target.respond_to? :tag_sources
            recursive_target.tag_sources(recursive_results)
          end
        end
        recursive_results
      end
    end
    results << self
    results.uniq!
    results
  end

  def related_tags
    tag_list = tag_sources.inject([]) do |tag_results, tag_source|
      ret = *tag_source[:tag_ids]
      tag_results | ret
    end.uniq
    Tag.where(:id.in => tag_list).all
  end
end
