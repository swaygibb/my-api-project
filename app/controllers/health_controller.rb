require 'net/http'
require 'uri'

class HealthController < ApplicationController
  def check_health
    db_status = check_database
    external_service_status = check_external_service

    health_status = {
      status: db_status && external_service_status ? 'ok' : 'partial',
      database: db_status ? 'connected' : 'error',
      external_service: external_service_status ? 'reachable' : 'unreachable',
      timestamp: Time.now
    }

    Rails.logger.info("\nHealth Status: #{health_status}")

    status = health_status[:status] == 'ok' ? :ok : :service_unavailable
    render json: health_status, status: status
  end

  private

  def check_database
    ActiveRecord::Base.connection.select_value('SELECT 1')
    Rails.logger.info("Database connection is active.")
    true
  rescue StandardError => e
    Rails.logger.error("Error checking database connection: #{e.message}")
    false
  end

  def check_external_service
    base_uri = URI(ENV['EXTERNAL_SERVICE_URL'])
    full_uri = URI.join(base_uri.to_s, 'todos/1')
    response = Net::HTTP.get_response(full_uri)

    if response.is_a?(Net::HTTPSuccess)
      Rails.logger.info("External service is reachable.")
      true
    else
      Rails.logger.error("External service is unreachable. Response: #{response.code}")
      false
    end
  rescue StandardError => e
    Rails.logger.error("Error checking external service: #{e.message}")
    false
  end
end
