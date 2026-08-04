# Reis Bistrô

Conceito e objetivo de Projeto: Pode ser uma página de um restaurante com duas estrelas Michelin em que os usuários vão poder fazer uma reserva

- Passo N: a página do restaurante, com a feature de escolher uma data e horário para reservar uma mesa para x pessoas
	- Inputs:
		- Input 1: precisa do site em si, do site design
		- Input 2: Sistema de reservas
- Passo N -1: funcionalidade de reserva
	- Direcionamento:
		- Aqui nesse sistema de reservas o usuário vai conseguir verificar as datas disponíveis para reserva e poder escolher reservar somente uma mesa para no máximo quatro pessoas.
		- Aqui o usuário também pode escolher a harmonização das cervejas, que vai junto com o menu degustação, que é a única oferta gastronômica do restaurante
	- Inputs:
		- Precisa do UX das telas de reserva
	- Output: estar pronta com a possibilidade de realizar reserva e atualizar no banco de dados as disponibilidades das próximas datas.
- Passo N -2: página do restaurante
	- Direcionamento: Nessa landing page do restaurante tenham campos e botões disponíveis para o usuário ir lá e fazer essa reserva.
	- Inputs:
		- Primeiro a gente precisa de um Design System do site do restaurante
		- A gente precisa dar inspirações de sites de restaurante para o Claude Design
		- Um arquivo [UX.MD](http://UX.MD) com detalhamento de como a página tem que ser
	- Outpu: é a página do restaurante em HTML/CSS, já pronta ali, pra estar no ar, na verdade
- Passo N-3: é um arquivo [ux.md](http://ux.md) para detalhar como que tem que ser a página do restaurante.
	- Direcionamento:
		- Quero uma página que seja visualmente muito elegante, que é um restaurante com duas estrelas Michelin e muito simples de navegar. São poucas seções, um visual bem em linha com sites de referência que nós vamos passar.
		- Inputs:
			- Das URLs dos sites de behcmark
			- Vai pedir para o Claude me perguntar o que ele precisa saber para gerar esse arquivo
			- Contexto: Todos os detalhes possíveis:
				- Noma do fundador, horário de abertura, cardápoi, localização e conceito
			- Output: Um arquivo.md
				- Detalha todas as seções: Hero, H1, H2, então tudo onde vai ficar o botão de reserva
				- É o objetivo de cada sessão
				- Quais elementos deveriam conter em cada seção: se é imagem + texto ou só a imagem
				- A proporção que cada elemento deveria ocupar na sessão, por exemplo: imagem 50% da sessão e o texto os outros 50%, só texto, só imagem
				- E aqui hoje também vou pedir pra ele já fazer uma ideia dos textos que deveriam estar na sessão
