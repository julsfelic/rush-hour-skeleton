require_relative '../test_helper'

class ClientTest < Minitest::Test
  include TestHelpers

  def test_it_has_an_identifier_attribute
    client = Client.new

    assert_respond_to client, :identifier
  end

  def test_it_has_a_root_url_attribute
    client = Client.new

    assert_respond_to client, :root_url
  end

  def test_attribute_must_be_present_when_saving
    client = Client.new

    refute client.save
    refute_equal 1, Client.all.size
  end

  def test_has_payload_requests
    client = Client.create(identifier: "jumpstartlabs", root_url: "http://www.jumpstartlabs.com")

    client.payload_requests.create(requested_at: "today",
                                   responded_in: 35,
                                   event_name:   "event")

    assert_equal 1, client.payload_requests.count
    assert_equal "today", client.payload_requests.last.requested_at
    assert_equal 35,      client.payload_requests.last.responded_in
    assert_equal "event", client.payload_requests.last.event_name
  end

  def test_has_ips
    client = Client.create(identifier: "jumpstartlabs", root_url: "http://www.jumpstartlabs.com")


    client.payload_requests.create(requested_at: "first_req",
                                   responded_in: 30,
                                   event_name:   "first_event",
                                   ip_address_id: IpAddress.create(ip: "127.0.0.1").id)

    client.payload_requests.create(requested_at: "second_req",
                                   responded_in: 35,
                                   event_name:   "second_event",
                                   ip_address_id: IpAddress.create(ip: "127.0.0.9").id)

    assert_equal 2, client.ip_addresses.size
    assert client.ip_addresses.pluck(:ip).include?("127.0.0.1")
    assert client.ip_addresses.pluck(:ip).include?("127.0.0.9")
  end

  def test_has_referrrers
    client = Client.create(identifier: "jumpstartlabs", root_url: "http://www.jumpstartlabs.com")


    client.payload_requests.create(requested_at: "first_req",
                                   responded_in: 30,
                                   event_name:   "first_event",
                                   referrer_id: Referrer.create(referred_by: "google.com/1").id)

    client.payload_requests.create(requested_at: "second_req",
                                   responded_in: 35,
                                   event_name:   "second_event",
                                   referrer_id: Referrer.create(referred_by: "google.com/9").id)

    assert_equal 2, client.referrers.size
    assert          client.referrers.pluck(:referred_by).include?("google.com/1")
    assert          client.referrers.pluck(:referred_by).include?("google.com/9")
  end

end