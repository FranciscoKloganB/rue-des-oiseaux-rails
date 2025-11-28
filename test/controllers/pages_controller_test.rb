require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get root_url
    assert_response :success
  end

  test "home page contains main heading" do
    get root_url
    assert_select "h1", text: "Data to enrich your business"
  end

  test "home page contains description text" do
    get root_url
    assert_select "p", text: /Anim aute id magna aliqua/
  end

  test "home page contains navbar with logo" do
    get root_url
    assert_select "header div.navbar"
    assert_select "img[alt='Rue Des Oiseaux']"
  end

  test "home page contains hamburger menu button" do
    get root_url
    assert_select "button[aria-label='Open main menu']"
  end

  test "home page contains drawer sidebar" do
    get root_url
    assert_select "input#mobile-drawer[type='checkbox']"
    assert_select ".drawer-side"
  end

  test "sidebar contains navigation links" do
    get root_url
    assert_select ".drawer-side ul.menu li a", text: "Register"
    assert_select ".drawer-side ul.menu li a", text: "Login"
  end

  test "sidebar contains close button" do
    get root_url
    assert_select ".drawer-side button#drawer-close-button[aria-label='Close menu']"
  end

  test "home page contains hero image" do
    get root_url
    assert_select "picture"
    assert_select "img[alt='Rue Des Oiseaux']", count: 2 # logo + hero image
  end
end
