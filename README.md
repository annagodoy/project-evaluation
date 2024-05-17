# DESAFIO TÉCNICO
# project-evaluation
## instruçoes:

#### dependencias:
ruby `-v 3.2.2`

#### executar os seguintes comandos:
```console
% git clone https://github.com/annagodoy/project-evaluation.git
% gem install bundler
% cd project-evaluation
% bundle install
% rake db:setup
% rails s -p 3000
```

Após os comandos acima a aplicação deverá estar rodando em ``http://localhost:3000/``

#### Para rodar os testes, executar seguintes comandos no terminal:

##### INTERACTORS:
```console
% bundle exec rspec spec/interactors
```

##### MODELS:
```console
% bundle exec rspec spec/models
```