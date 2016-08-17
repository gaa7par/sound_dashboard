class AdminsController < ApplicationController
  before_action :authenticate_admin!

  expose :admins, -> { Admin.all }
  expose :admin

  def create
    if admin.save
      redirect_to admin_path(admin)
    else
      render :new
    end
  end

  def update
    if admin.update(admin_params)
      redirect_to admin_path(admin)
    else
      render :edit
    end
  end

  def destroy
    admin.destroy
    redirect_to admins_path
  end

  private

  def admin_params
    params.require(:admin).permit(:email, :password, :password_confirmation)
  end
end
