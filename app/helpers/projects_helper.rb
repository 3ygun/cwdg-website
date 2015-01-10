module ProjectsHelper
  def short_description(description)
    description.slice(0..100) + "..."
  end
end
