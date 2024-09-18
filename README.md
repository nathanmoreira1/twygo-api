# Twygo API

Twygo API é uma aplicação backend desenvolvida em Ruby on Rails para fornecer uma API RESTful para gerenciar cursos e vídeos. Este projeto é configurado para rodar com Docker, facilitando o ambiente de desenvolvimento e a implantação.

## Funcionalidades

- Gerenciamento de cursos
- Upload e streaming de vídeos

## Requisitos

- Docker
- Docker Compose

## Configuração Local

Para rodar a aplicação localmente, siga as instruções abaixo:

1. **Clone o repositório**

   ```bash
   git clone https://github.com/nathanmoreira1/twygo-api.git
   cd twygo-api

   ```

2. **Defina as variáveis de ambiente**
   Verifique seu arquivo ".env.example", que possui as variáveis de ambiente que você precisará definir.

   ```bash
   POSTGRES_USER=
   POSTGRES_PASSWORD=
   POSTGRES_DB=
   DATABASE_HOST=db
   RAILS_ENV=development
   SECRET_KEY_BASE=
   ```

   Quanto as variáveis de ambiente referentes ao banco de dados que não estão definidas, você pode colocar as credenciais que preferir. Já quanto a SECRET_KEY_BASE, você pode inserir alguma chave aleatória.

   Caso você possua o rails instalado, pode gerar uma facilmente usando o comando abaixo

   ```bash
   rails secret
   ```

   Com isso concluido, renomeie o arquivo para ".env".

3. **Construa e inicie os containers**

   Execute o comando abaixo para construir a imagem Docker e iniciar os containers:

   ```bash
   docker-compose up --build

   ```

4. **Rodar Migrations**

   Atenção: Para conseguir rodar os comandos abaixo, você precisa manter o terminal que rodou a etapa anterior aberto!

   Acesse o terminal do Docker com o seguinte comando:

   ```bash
   docker-compose exec rails /bin/bash
   ```

   Rode as migrações:

   ```bash
   bundle exec rake db:migrate
   ```

## Scripts de Docker

Aqui estão alguns comandos úteis para gerenciar a aplicação:

1. **Parar os containers**

   ```bash
   docker-compose down
   ```

2. **Acessar o console Rails**

   ```bash
   docker-compose exec rails /bin/bash
   bundle exec rails console
   ```
