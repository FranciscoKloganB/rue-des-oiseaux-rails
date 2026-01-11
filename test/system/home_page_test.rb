require "application_system_test_case"

class HomePageTest < ApplicationSystemTestCase
  test "visiting the home page" do
    visit root_url

    assert_selector "h1", text: "Data to enrich your business"
    assert_text "Anim aute id magna aliqua ad ad non deserunt sunt"
  end

  test "home page displays logo" do
    visit root_url

    assert_selector "img[alt='Rue Des Oiseaux']"
  end

  test "home page displays hero image" do
    visit root_url

    assert_selector "picture"
  end

  test "hamburger menu button is visible" do
    visit root_url

    assert_selector "button[aria-label='Open main menu']"
  end

  test "drawer sidebar navigation" do
    visit root_url

    # Drawer sidebar should be hidden by default (actually checking if the link is NOT visible)
    # We implicitly test it's hidden because we can't see the links
    refute_text "Register", wait: 0.1 # fast fail if it's there

    # Open the drawer
    find("button[aria-label='Open main menu']").click

    # Check navigation links become visible
    within "[data-testid='drawer-sidebar']" do
      assert_link "Register"
      assert_link "Login"
    end
  end

  test "clicking drawer overlay closes the drawer" do
    visit root_url

    find("button[aria-label='Open main menu']").click
    assert_link "Register"

    find("[data-testid='drawer-overlay']").click

    refute_text "Register"
  end

  test "clicking close button in drawer closes the drawer" do
    visit root_url

    find("button[aria-label='Open main menu']").click
    assert_link "Register"

    within "[data-testid='drawer-sidebar']" do
      find("[data-testid='drawer-close-button']").click
    end

    refute_text "Register"
  end

  test "drawer menu items are clickable" do
    visit root_url

    find("button[aria-label='Open main menu']").click

    within "[data-testid='drawer-sidebar']" do
      assert_link "Register"
      assert_link "Login"
    end
  end
end
