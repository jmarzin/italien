Kaminari.configure do |config|
  config.default_per_page = 20
  # config.max_per_page = nil
  config.window = 5
  config.outer_window = 10
  config.left = 5
  config.right = 5
  # config.page_method_name = :page
  # config.param_name = :page
end
