class GaleriesController < ApplicationController

  layout 'blog'
  before_action :get_galery, only: [:show, :edit, :update, :destroy]
  before_action :require_user, only: [:new, :create, :destroy]

  def index
    @galeries = Galery.all
  end

  def new
    @galery = Galery.new
  end

  def create
    @galery = Galery.new(galery_params)
    if @galery.save
      redirect_to @galery, notice: "Stworzyłaś nową galerię"
    else
      render 'new' and return
    end
  end

  def show
    @photos = @galery.photos.all
  end


  def destroy
    @galery.destroy
    redirect_to galeries_path, notice: "Usunęłaś galerię #{@galery.name}"
  end

  private
  def galery_params
    params.require(:galery).permit(:name)
  end
  def get_galery
    @galery = Galery.find(params[:id])
  end
end
