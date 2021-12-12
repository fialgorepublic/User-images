module Response
  def json_response(object, message = "", status)
    if status.eql?(:not_found)
      status = status
    else
      status = :ok
    end
    response = {
          "status": Rack::Utils.status_code(status),
        "message": message,
        "data": object
      }
    render json: response, status: status

  end

  def json_error_response(errors, message, status)
      response = {
          "status": Rack::Utils.status_code(status),
        "message": message,
        "errors": errors
      }

    render json: response, status: status
  end
end