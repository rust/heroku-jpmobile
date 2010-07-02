# Be sure to restart your server when you modify this file.

#Rails.application.config.session_store :cookie_store, :key => '_jpmobile-test_session'
#Rails.application.config.session_store :cookie_store

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
#Rails.application.config.session_store :active_record_store, :key => '_sess_id'
Rails.application.config.session_store :active_record_store
Rails.application.config.session_options = {:cookie_only => false}
