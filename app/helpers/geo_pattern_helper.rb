module GeoPatternHelper
  def geo_pattern(text, options={})
    GeoPattern.generate(text, options)
  end

  def geo_pattern_image(text, options={})
    GeoPattern.generate(text, options).uri_image
  end
end
