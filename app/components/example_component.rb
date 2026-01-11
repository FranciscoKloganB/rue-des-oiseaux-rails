# app/components/example_component.rb
class ExampleComponent < ViewComponent::Base
  def call
    "Hello, ViewComponent!"
  end
end
