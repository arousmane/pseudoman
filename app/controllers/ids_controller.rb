class IdsController < ApplicationController
  def create
    if Id.exists?(id_params)
      id = AddNewIdService.call
      render(json: { data: id }, status: :ok) and return
    end

    if (id = Id.new(id_params)).save
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
