require 'faraday'

class AnnonceService
  def self.call_annonce
    url = 'https://labonnealternance-recette.apprentissage.beta.gouv.fr/api/v1/jobs?romes=D1101&caller=contact%40domaine%20nom_de_societe&latitude=48.1113387&longitude=-1.6800198&radius=50&insee=35238'
    params = nil
    headers = {'Content-Type' => 'application/json' 'charset=utf-8'}
    response = Faraday.get(url, params, headers)
    parsed_response = JSON.parse(response.body)
    parsed_response['peJobs']['results'].each do |data|
      # si l'id de dataId n'existe pas dans la base de donnée alors on crée une nouvelle annonce
      Annonce.find_or_create_by(
        annonceId: data['id'],
        title: data['title'],
        description: data['job']['description'],
        distance: data['place']['distance'],
        fullAddress: data['place']['fullAddress'],
        url: data['url'],
        creationDate: data['job']['creationDate'],
        contractType: data['job']['contactType'],
        contractDescription: data ['job']['contractDescription'],
      )
    end
  end
end
