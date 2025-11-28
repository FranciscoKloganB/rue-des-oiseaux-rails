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
    # Check for responsive image sources (they are hidden by default in picture elements)
    assert_selector "source[media='(min-width: 1280px)']", visible: :all
    assert_selector "source[media='(min-width: 1024px)']", visible: :all
    assert_selector "source[media='(min-width: 320px)']", visible: :all
  end

  test "hamburger menu button is visible" do
    visit root_url

    assert_selector "button[aria-label='Open main menu']"
    assert_selector "button[aria-label='Open main menu'] svg"
  end

  test "drawer sidebar is hidden by default" do
    visit root_url

    # Drawer checkbox should be unchecked by default
    assert_selector "input#mobile-drawer[type='checkbox']:not(:checked)", visible: :hidden
  end

  test "clicking hamburger menu opens drawer sidebar" do
    visit root_url

    # Initially, sidebar menu items should not be visible
    refute_selector ".drawer-side ul.menu li a", text: "Register", visible: :visible

    # Wait for drawer to open and check if menu items are visible
    find("button[aria-label='Open main menu']").click
    assert_selector ".drawer-side ul.menu li a", text: "Register", visible: :visible
    assert_selector ".drawer-side ul.menu li a", text: "Login", visible: :visible
  end

  test "drawer sidebar contains correct navigation links" do
    visit root_url

    # Open the drawer
    find("button[aria-label='Open main menu']").click

    # Check navigation links
    within ".drawer-side ul.menu" do
      assert_selector "li a", text: "Register"
      assert_selector "li a", text: "Login"
    end
  end

  test "clicking drawer overlay closes the drawer" do
    visit root_url

    # Open the drawer
    find("button[aria-label='Open main menu']").click
    assert_selector ".drawer-side ul.menu li a", text: "Register", visible: :visible

    # Click the overlay to close
    find(".drawer-overlay").click

    # Menu items should no longer be visible
    refute_selector ".drawer-side ul.menu li a", text: "Register", visible: :visible
  end

  test "clicking close button in drawer closes the drawer" do
    visit root_url

    # Open the drawer
    find("button[aria-label='Open main menu']").click
    assert_selector ".drawer-side ul.menu li a", text: "Register", visible: :visible

    # Click the close button inside the drawer
    within ".drawer-side" do
      find("button#drawer-close-button").click
    end

    # Menu items should no longer be visible
    refute_selector ".drawer-side ul.menu li a", text: "Register", visible: :visible
  end

  test "drawer menu items are clickable" do
    visit root_url

    # Open the drawer
    find("button[aria-label='Open main menu']").click

    # Verify menu items are present and clickable
    within ".drawer-side ul.menu" do
      assert_selector "li a[href='#']", text: "Register"
      assert_selector "li a[href='#']", text: "Login"
    end
  end

  test "navbar has proper z-index positioning" do
    visit root_url

    # Navbar should have z-50 class for proper stacking
    assert_selector "header.z-50"
  end

  test "drawer has proper z-index positioning" do
    visit root_url

    # Open drawer to check its styling
    find("button[aria-label='Open main menu']").click

    # Drawer side should have z-50 class
    assert_selector ".drawer-side.z-50"
  end
end
