require_relative '../test_helper'

class ClientSeesALandingPageWithSignupLinkTest < FeatureTest
  include TestHelpers

  def test_shows_company_title_and_sign_up_button
    visit '/'

    assert_equal '/', current_path

    within 'h1' do
      assert page.has_content? 'HAMALITICS'
    end

    within 'p' do
      assert page.has_content? 'Going H.A.M for all your analytical needs!'
    end

    assert page.has_link? 'Sign up'
  end
end
