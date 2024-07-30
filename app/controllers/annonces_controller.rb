class AnnoncesController < ApplicationController
  def index
    @annonces = AnnonceService.call_annonce
    @annonces = Annonce.all
  end

  def show
    @annonce = Annonce.find(params[:id])
  end

  private

  def annonce_params
    params.permit(:annonceId,
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
