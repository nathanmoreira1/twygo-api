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

2. **Construa e inicie os containers**

   Execute o comando abaixo para construir a imagem Docker e iniciar os containers:

   ```bash
   docker-compose up --build

   ```

3. **Rodar Migrations**

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
