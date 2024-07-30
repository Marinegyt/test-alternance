class AnnoncesController < ApplicationController
  def index
    @annonces = Annonce.all
  end

  def new
    @annonce = Annonce.new
  end

  def create
    @annonce = Annonce.new(annonce_params)
    if @annonce.save
      redirect_to @annonce
    else
      render 'new'
    end
  end

  private

  def annonce_params
    params.require(:annonce).permit(:annonceId,
                                    :title,
                                    :description,
                                    :distance,
                                    :fullAddress,
                                    :url,
                                    :creationDate,
                                    :contractType,
                                    :contractDescription,
                                    :type)
  end
end
