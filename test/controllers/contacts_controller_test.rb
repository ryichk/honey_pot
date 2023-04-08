require "test_helper"

class ContactsControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get new_contact_path
    assert_response :success
  end

  test 'should create contact' do
    assert_difference('Contact.count') do
      post contacts_path, params: {
        contact: {
          name: 'Test User',
          email: 'test@example.com',
          message: 'Hello, World!'
        }
      }
    end

    assert_redirected_to thanks_contacts_path
  end

  test 'should not create contact with honeypot field' do
    assert_no_difference('Contact.count') do
      post contacts_path, params: {
        contact: {
          name: 'Test User',
          email: 'test@example.com',
          message: 'Hello, World!',
          address: 'spam'
        }
      }
    end

    assert_redirected_to root_path
  end

  test 'should get thanks' do
    get thanks_contacts_path
    assert_response :success
  end
end
