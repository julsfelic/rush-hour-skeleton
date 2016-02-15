require_relative '../test_helper'

class ClientSeesALandingPageWithSignupLinkTest < FeatureTest
  include TestHelpers

  def test_shows_company_title_and_sign_up_button
    visit '/'

    assert_equal '/', current_path

    within 'h1' do
      assert page.has_content? 'HAMALYTICS'
    end

    within 'p' do
      assert page.has_content? 'Going H.A.M for all your analytical needs!'
    end

    assert page.has_link? 'Sign up'
  end

  def test_sends_client_to_sign_up_page_when_they_click_sign_up
    visit '/'
    click_link 'Sign up'

    assert_equal '/signup', current_path

    within 'h1' do
      assert page.has_content? 'Sign up'
    end

    fill_in 'identifier', with: "humpstartlabs"
    fill_in 'rootUrl',    with: "http://www.humpstartlabs.com"
    click_button 'Create Account'
    visit '/sources/humpstartlabs'

    assert_equal '/sources/humpstartlabs', current_path

    within 'h1' do
      assert page.has_content? "Welcome, Humpstartlabs!"
    end
  end
end
