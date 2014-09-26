class ListController
  def initialize(list)
    @list = list
  end

  # This is only a helper method to access
  # the object's (private) binding method
  def get_binding
    binding
  end
end
