# Gerenciador de Workshops

## O que é?

Este é um projeto open source criado durante a Hacktoberfest 2020 e focado no evento 
Ruby Summit Brasil. A aplicação permite que administradores criem workshops e que visitantes
se inscrevam nestes workshops para garantir sua participação e receber atualizações de conteúdo
relacionados ao workshop.

## Tecnologias

#ToDo

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