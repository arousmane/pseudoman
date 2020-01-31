class IdsController < ApplicationController
  respond_to :json

  def create
    id = Id.new(id_params)

    if id.save
      render json: { data: 'OK' }, status: :ok
    else
      render json: { errors: id.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def id_params
    params.permit(:value)
  end
end
