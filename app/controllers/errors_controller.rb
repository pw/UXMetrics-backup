class ErrorsController < UnauthenticatedController
 
  def not_found
    render(status: 404)
  end

  def server_error
    render(status: 500)
  end

  def unacceptable
    render(status: 403)
  end
end

