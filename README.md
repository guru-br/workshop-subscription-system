# Gerenciador de Workshops

## O que é?

Este é um projeto open source criado durante a Hacktoberfest 2020 e focado no evento
Ruby Summit Brasil. A aplicação permite que administradores criem workshops e que visitantes
se inscrevam nestes workshops para garantir sua participação e receber atualizações de conteúdo
relacionados ao workshop.

## Tecnologias

#ToDo

## Como colaborar

Depois de criar seu `fork`, Escolha uma [issue](https://github.com/guru-br/workshop-subscription-system/issues), abra uma nova `branch` em seu computador e codifique o que julgar necessário para encerrar a `issue`. Em seguida crie um `pull request` informando o número da `issue` que está encerrando.

Referência: https://docs.github.com/en/enterprise/2.16/user/github/managing-your-work-on-github/closing-issues-using-keywords


### Draft Pull Requests

Ao começar o trabalho em uma [issue](https://github.com/guru-br/workshop-subscription-system/issues), assim que tiver algo para enviar um `commit`, aproveite e abra um novo pull request como `draft`. Desta forma os demais colaboradores saberão que aquela `issue` já está sendo tratada.

## Models

### User

Model criado com Devise para autenticação dos papéis: administrador e instrutor do workshop.

### Workshop

Dados relacioandos ao workshop como nome, descrição completa, duração etc.

### Attendee

Participante que deve ter uma conta e pode se inscrever em N workshops.

### Enrollment

Representa a inscrição de um participante em um workshop.

### WorkshopContent

Conteúdos vinculados a um workshop e disponíveis somente para os participantes inscritos.

## Desenvolvimento no projeto usando Docker

## Pré-requisitos:

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)
- Criar o arquivo `.env` para incluir as variaveis de ambientes necessárias
  - O conteudo do arquivo pode ser igual ao `.env.sample` presente na raiz do
    projeto

### Instalação via Docker

Na pasta do projeto execute:

```
docker-compose build
```

Essa instalação ira instalar todas as dependencias requeridas para o projeto
dentro de um volume do Docker

### Preparar o projeto via docker

Na pasta do projeto, após a instalação, execute:

```
docker-compose run --rm web bin/setup
```

A opção `--rm` ira remover o container quando ele for terminado de ser usado,
porém não ira remover o volume

### Subir o aplicativo via docker

Na pasta do projeto execute:

```
docker-compose up
```

A versão web estara disponível em localhost:3000

### Executar os testes dentro do Docker

Na pasta do projeto, após a instalação, execute:

```
docker-compose run --rm web rspec
```

### Entrar dentro do container do Docker

Na pasta do projeto, após a instalação, execute:

```
docker-compose run --service-ports --rm web bash
```

O docker não disponibiliza as portas utilizadas por ele mesmo durante a
execução, então utilizamos a opção `--service-ports` para disponibiliza-las
