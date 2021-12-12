$customerio = Customerio::Client.new(Rails.application.credentials.customerio[:site_id], Rails.application.credentials.customerio[:secret_key], region: Customerio::Regions::US)
