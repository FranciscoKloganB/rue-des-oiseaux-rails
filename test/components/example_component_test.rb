# test/components/example_component_test.rb
require "test_helper"

class ExampleComponentTest < ActionDispatch::IntegrationTest
  include ViewComponent::TestHelpers
  def test_component_renders_something_useful
    render_inline(ExampleComponent.new)
    assert_text "Hello, ViewComponent!"
  end
end
