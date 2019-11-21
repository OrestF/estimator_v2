module FeaturesHelper
  def feature_form_class(et, css_class = '')
    "feature_form feature_#{et.id} #{css_class}"
  end
end
