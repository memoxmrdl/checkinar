# frozen_string_literal: true

class OrganizationsController < ApplicationController
  def create
    @organization = Organization.new(organization_params)
    if @organization.save
      flash[:notice] = "Organización creada correctamente"
      redirect_to root_path
    else
      flash[:alert] = "Error creando organización"
      render "new"
    end
  end

  def edit
    @organization = Organization.find(params[:id])
  end

  def index
    @organizations = Organization.all
  end

  def new
    @organization = Organization.new
  end

  def show
    @organization = Organization.find(params[:id])
  end

  def update
    @organization = Organization.find(params[:id])
    if @organization.update(organization_params)
      flash[:notice] = "Organización actualizada correctamente"
      redirect_to root_path
    else
      flash[:alert] = "Error actualizando la organización"
      render "edit"
    end
  end

  private
    def organization_params
      params.require(:organization).permit(:name, :logo)
    end
end
