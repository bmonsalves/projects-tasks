module ResponseManager
  extend ActiveSupport::Concern

  def make_response(data)

    status = 'success'
    code = 200
    status = 'error' if data.respond_to?(:error) && data.error
    code = data.code if data.respond_to?(:code)
    json = {
      status: status,
      response: JSON.parse(Oj.dump(data, {})),
      code: code
    }

    render json: json, status: code
  end


  def catch_404
    render json: { status: 'error', data: 'url no encontrada' }, status: :not_found
  end
end
