require 'faraday'

class AnnonceService
  def self.call_annonce
    url = 'https://labonnealternance-recette.apprentissage.beta.gouv.fr/api/v1/jobs'
    params = {
      romes: 'D1101',
      caller: 'contact@domaine nom_de_societe',
      latitude: 48.1113387,
      longitude: -1.6800198,
      radius: 50,
      insee: '35238'
    }
    headers = {'Content-Type' => 'application/json' 'charset=utf-8'}
    response = Faraday.get(url, params, headers)
    parsed_response = JSON.parse(response.body)
    parsed_response['peJobs']['results'].each do |data|

      if Annonce.find_by(annonceId: data['id']).present?
        if data['place']['distance'] < params[:radius]
          Annonce.find_by(annonceId: data['id']).update(
            title: data['title'],
            description: data['job']['description'],
            distance: data['place']['distance'],
            fullAddress: data['place']['fullAddress'],
            url: data['url'],
            contractType: data['job']['contactType'],
            contractDescription: data['job']['contractDescription'],
          )
        else
          Annonce.find_by(annonceId: data['id']).destroy
        end
      end

      if data['place']['distance'] < params[:radius]
        Annonce.find_or_create_by(
          annonceId: data['id'],
          title: data['title'],
          description: data['job']['description'],
          distance: data['place']['distance'],
          fullAddress: data['place']['fullAddress'],
          url: data['url'],
          contractType: data['job']['contactType'],
          contractDescription: data ['job']['contractDescription'],
        )
      end
    end
  end
end
