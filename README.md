# Reis Bistrô

App de reserva de mesas para um restaurante fictício — projeto de estudo (vibecoding) em Ruby on Rails.

## O que tem

- Landing page (Tailwind + Hotwire)
- Fluxo de reserva em 4 passos (data/turno/pessoas → harmonização → dados → confirmação)
- Disponibilidade real no SQLite (12 mesas por turno, corte de 2 horas)
- Trava de overbooking no banco

## Aviso

Contato, endereço e reservas de seed são **fictícios**. Não use este repositório como site real sem política de privacidade, painel da casa e troca dos dados de demonstração.

## Rodar local

```bash
bundle install
bin/rails db:prepare
bin/rails db:seed
bin/dev
```

Abra http://127.0.0.1:3000

## Testes

```bash
bin/rails test
```

## Stack

Ruby on Rails 8 · SQLite · Tailwind CSS · Stimulus · Importmap
