# frozen_string_literal: true

class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user

  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to edit_account_path, notice: t(".notice")
    else
      flash.now[:alert] = t(".alert")

      render :edit
    end
  end

  private
    def user_params
      params.require(:user).permit(policy(current_user).permitted_attributes)
    end

    def authorize_user
      authorize(current_user)
    end
end
