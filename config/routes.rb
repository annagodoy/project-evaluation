Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do 
        post  'projetos',   to: 'projects#projects'
        get   'projetos',   to: 'projects#index'
        
        post  'criterios',  to: 'criterions#criterions'
    end
  end
end
