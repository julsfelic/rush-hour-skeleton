require_relative '../test_helper'

class PayloadRequestTest < Minitest::Test
  include TestHelpers

  def test_payload_has_the_attributes
    payload_request = PayloadRequest.new

    assert_respond_to payload_request, :requestedAt
    assert_respond_to payload_request, :respondedIn
    assert_respond_to payload_request, :resolution_id
    assert_respond_to payload_request, :referrer_id
    assert_respond_to payload_request, :url_request_id
    assert_respond_to payload_request, :user_agent_id
    assert_respond_to payload_request, :eventName
  end

  def test_attributes_must_be_present_when_saving
    payload_request = PayloadRequest.new

    payload_request.save

    assert_equal 0, PayloadRequest.all.count
  end

  def test_payload_request_has_attribute_values
    payload_request = PayloadRequest.new(respondedIn: payload[:respondedIn],
                           requestedAt: payload[:requestedAt],
                           eventName:   payload[:eventName])

    assert_equal "2013-02-16 21:38:28 -0700", payload_request.requestedAt
    assert_equal 37, payload_request.respondedIn
    assert_equal "socialLogin", payload_request.eventName
  end

  def test_creates_relationships
    referrer = Referrer.create(referredBy: payload[:referredBy])
    url_request = UrlRequest.create(url: "something", requestType: "stuff", parameters: "array")
    user_agent = UserAgent.create(browser: "dkfjsdfj", os: "kdjfj")
    test_payload = PayloadRequest.create(requestedAt: payload[:requestedAt],
                                    respondedIn: payload[:respondedIn])

    test_payload.update(referrer_id: referrer.id)
    test_payload.update(url_request_id: url_request.id)
    test_payload.update(user_agent_id: user_agent.id)

    assert_equal referrer.id, test_payload.referrer.id
    assert_equal url_request.id, test_payload.url_request.id
    assert_equal user_agent.id, test_payload.user_agent.id
  end
end