# UX — Landing Page Reis Bistrô

Documento de especificação de UX/UI para a construção da página pública do **Reis Bistrô**.

**Para quem é este documento:** designer/front-end responsável por entregar o layout e o HTML/CSS da página.
**Idioma do site:** apenas PT-BR. Nenhum seletor de idioma.
**Objetivo único da página:** levar o visitante a iniciar uma reserva de mesa. Todo o resto é suporte a essa decisão.

**Escopo desta entrega:** a landing page (item 5) **e** as telas do fluxo de reserva (item 6). Somente layout e HTML/CSS — nenhuma lógica de backend.

> Todos os dados de negócio, textos, preços e nomes deste documento foram validados pelo dono do produto e podem ser usados como versão final.

---

## 1. Contexto do negócio

| Item | Valor |
| --- | --- |
| Nome | Reis Bistrô |
| Chef e fundador | Dener Reis |
| Posicionamento | Duas estrelas Michelin — pizza de autor em menu degustação |
| Cidade / bairro | Jundiaí – SP, bairro Castanho |
| Endereço | Rua do Castanho, 412 — Castanho, Jundiaí/SP |
| Telefone / WhatsApp | (11) 3456-7890 |
| E-mail | contato@reisbistro.exemplo |
| Instagram | [@reisbistro](https://instagram.com/reisbistro) |
| Funcionamento | Quinta a domingo, 18h à meia-noite |
| Serviço | Somente jantar. Sem almoço, sem à la carte |
| Oferta gastronômica | Menu degustação único (6 etapas) |
| Bebida da casa | Reis Beer — cervejaria própria, harmonização opcional |
| Limite de reserva | Uma mesa por reserva, no máximo 4 pessoas |

### Conceito da cozinha

O Reis Bistrô é uma casa de **pizza de autor servida como menu degustação**. Não existe cardápio à la carte nem pizza por fatia: o convidado senta e percorre seis etapas, cada uma com um disco de massa diferente, do salgado ao doce.

A tese técnica da casa é a **fermentação cruzada**: o mesmo levain que levanta a massa é alimentado com o mosto da Reis Beer, a cervejaria que Dener mantém no fundo da casa. Massa e cerveja nascem do mesmo fermento — é isso que justifica a harmonização não ser um acessório, e sim a continuação do prato.

### História (para uso na seção do chef)

Dener Reis cresceu diante do forno a lenha da padaria do avô, no Castanho, e passou dez anos estudando fermentação natural antes de perceber que o fermento do pão da família e o da cerveja que ele fabricava no quintal eram o mesmo organismo. Em 2019 transformou a casa onde nasceu em um bistrô de doze lugares, com um só caminho possível: seis etapas de pizza autoral, cada uma harmonizada com um rótulo da Reis Beer.

---

## 2. Referências visuais (benchmarks)

Analisar as quatro, na ordem de prioridade:

1. **[Pepe in Grani](https://pepeingrani.it/)** — a referência mais próxima do nosso caso: pizza tratada como alta gastronomia. Observar como a tipografia gigante ("Experimentation / Craftsmanship / Territory") carrega a narrativa sem poluir a tela.
2. **[Oteque](https://oteque.com/)** — dois estrelas Michelin no Brasil. Referência de **radicalidade na contenção**: pouquíssimo texto, muito respiro, zero decoração. Observar o tom de voz em caixa baixa.
3. **[Noma](https://noma.dk/)** — referência de hierarquia e de como uma foto ocupando a tela inteira sustenta o valor percebido.
4. **[A Casa do Porco](https://acasadoporco.com.br/)** — referência de brasilidade sem perder sofisticação; útil para calibrar o tom para o público de Jundiaí.

**O que queremos herdar:** silêncio visual, muito espaço em branco (aqui, espaço em preto), tipografia serifada com presença, fotografia como protagonista.
**O que NÃO queremos:** carrossel de banners, ícones decorativos, gradientes, sombras fortes, badges de "melhor pizza", contadores de avaliação, pop-up de newsletter.

---

## 3. Design System

> **Fonte única de verdade: `app/assets/tailwind/application.css`.** Os tokens vivem no bloco `@theme static` desse arquivo, e é de lá que o CSS é gerado. A tabela abaixo documenta a intenção de cada token; em caso de divergência, **o arquivo vence**. Não duplicar esses valores em outro lugar.

A identidade foi herdada da primeira versão da home que já estava no ar, e não inventada aqui.

### Paleta

| Token | Classe Tailwind | Hex | Uso |
| --- | --- | --- | --- |
| `carvao` | `bg-carvao` | `#1A1410` | Fundo padrão do site |
| `carvao-claro` | `bg-carvao-claro` | `#241C16` | Seções alternadas, cards, campos de formulário |
| `creme` | `text-creme` | `#F3EBE0` | Texto principal sobre fundo escuro |
| `latao` | `text-latao` | `#E0B87A` | Cor de marca: CTA, filetes, numeração das etapas |
| `cobre` | `text-cobre` | `#C47A4A` | Acento secundário, ligado ao forno e à Reis Beer |
| `cinza-texto` | `text-cinza-texto` | `#A79C8C` | Texto secundário, legendas, rodapé |
| `tijolo` | `text-tijolo` | `#E0705A` | **Somente estados de erro** |

- Para texto esmaecido, usar o modificador de opacidade do Tailwind (`text-creme/70`) em vez de criar um token novo.
- O site é **dark por padrão**. Não há tema claro nem alternância de tema.
- O `tijolo` foi clareado em relação ao tom de tijolo queimado original: sobre o fundo `#1A1410`, o tom escuro rendia contraste de 1,6:1 e tornava a mensagem de erro ilegível. O valor atual entrega 5,9:1 e passa em AA.

### Tipografia

- **Display (títulos e itálicos):** **Fraunces** — pesos 400 e 600, mais o itálico 400.
- **Corpo e interface:** **Outfit** — pesos 300, 400 e 500.
- Ambas são Google Fonts com licença OFL: custo zero e sem risco de licenciamento.
- **Outfit não possui itálico.** Todo texto em itálico usa Fraunces; o CSS base já força isso em `em` e `i`, para o navegador nunca sintetizar uma inclinação falsa.

| Token | Classe | Mobile | Desktop (≥1024px) |
| --- | --- | --- | --- |
| `text-h1` | `text-h1` | 40px | 72px |
| `text-h2` | `text-h2` | 32px | 48px |
| `text-h3` | `text-h3` | 22px | 28px |
| `text-corpo` | `text-corpo` | 16px | 18px |
| `text-legenda` | `text-legenda` | 13px | 14px |
| `text-rotulo` | `.rotulo` | 12px | 12px |

- Entrelinha: 1.05 a 1.2 em títulos, 1.6 em corpo — já embutida nos tokens.
- Rótulos curtos em caixa alta usam a classe `.rotulo`, que aplica o `letter-spacing` de +0.18em e o peso 500.
- Linha de texto corrido nunca acima de 65 caracteres: usar `max-w-leitura` (34rem).

### Grid e espaçamento

- 12 colunas, largura máxima de conteúdo **1280px** (`max-w-conteudo`), centralizado.
- Gutter 24px. Margem lateral 80px no desktop, 24px no mobile.
- Espaçamento vertical entre seções: `py-secao` (88px) no mobile e `lg:py-secao-lg` (160px) no desktop.
- Escala de espaçamento em múltiplos de 8px, que é o padrão do Tailwind.

### Componentes

Já implementados como classes na camada `components` do arquivo de tokens:

| Classe | O que é |
| --- | --- |
| `.botao .botao--primario` | Fundo `latao`, texto `carvao`, raio 2px, caixa alta com tracking. Hover escurece 12% e sobe 2px |
| `.botao .botao--secundario` | Apenas contorno 1px `creme` a 40%, fundo transparente |
| `.rotulo` | Rótulo curto em caixa alta na cor `latao` |
| `.filete` | Linha divisora de 1px `latao` a 24% |

- Estado desabilitado do botão: `disabled` ou `aria-disabled="true"` reduz a 40% de opacidade e bloqueia o ponteiro. Usado no `CONTINUAR` do passo 1 da reserva.
- Foco por teclado: contorno 2px `latao` com 3px de deslocamento, aplicado globalmente via `:focus-visible`.
- **Motion:** apenas `fade-in` + `translateY(16px)` na entrada das seções, 400ms, com a curva `--ease-suave`. Nada de parallax, nada de animação em loop. O hover dos botões é desligado sob `prefers-reduced-motion`.

---

## 4. Estrutura da página

Ordem final das seções:

1. Navbar fixa
2. Hero
3. Manifesto
4. O Chef
5. O Menu Degustação
6. Harmonização Reis Beer
7. A Casa (galeria)
8. Informações práticas
9. Bloco final de reserva
10. Footer

São **9 blocos de conteúdo**. Não adicionar seções (sem depoimentos, sem imprensa, sem FAQ, sem newsletter).

### Onde ficam os CTAs de reserva

Quatro pontos, nesta hierarquia:

| # | Local | Tipo | Rótulo |
| --- | --- | --- | --- |
| 1 | Navbar (sempre visível) | Botão primário pequeno | `RESERVAR` |
| 2 | Hero | Botão primário grande | `RESERVAR MESA` |
| 3 | Fim da seção Harmonização | Botão secundário | `Reservar com harmonização` |
| 4 | Bloco final de reserva | Botão primário grande | `RESERVAR MESA` |

Todos apontam para o mesmo destino: `/reservas`. No mobile, o CTA da navbar vira uma **barra fixa no rodapé da viewport** (altura 64px, fundo `latao`), visível a partir do momento em que o Hero sai da tela.

---

## 5. Especificação seção por seção

### 5.1 Navbar fixa

**Objetivo:** manter a reserva a um clique de distância em qualquer ponto da página.

- Altura 88px. Inicia **transparente sobre o Hero**; ao rolar 80px, ganha fundo `carvao` com 92% de opacidade e blur leve.
- Proporção: logotipo à esquerda (20%), navegação centralizada (55%), CTA à direita (25%).
- Itens de navegação: `Menu` · `O Chef` · `A Casa` · `Contato` — âncoras internas, scroll suave.
- Mobile: logotipo centralizado + menu hambúrguer que abre em tela cheia sobre fundo `carvao`.

**Copy do logotipo:** `REIS BISTRÔ` em display, com o subtítulo `JUNDIAÍ` em 11px, caixa alta, tracking largo, embaixo.

---

### 5.2 Hero

**Objetivo:** comunicar em 3 segundos que isto é alta gastronomia, não pizzaria — e abrir o caminho da reserva.

- **Altura:** 100vh no desktop, 90vh no mobile.
- **Composição:** imagem única em tela cheia (100% da seção) com overlay escuro em gradiente vertical, do `carvao` a 25% de opacidade no topo ao `carvao` a 85% na base. Texto sobreposto, alinhado à esquerda, ancorado no terço inferior.
- **Proporção do bloco de texto:** ocupa 55% da largura no desktop, 100% no mobile.
- **Nada de rolagem indicada por seta animada.**

**Copy:**

- Selo superior (12px, caixa alta, `latao`): `DUAS ESTRELAS MICHELIN · JUNDIAÍ, SP`
- **H1:** `A pizza como ela nunca foi servida.`
- Subtítulo (20px, `creme` a 80%): `Seis etapas de massa autoral, harmonizadas com a cerveja que fermenta na casa. Doze lugares, quatro noites por semana.`
- Botão primário: `RESERVAR MESA`
- Linha de apoio abaixo do botão (14px, `cinza-texto`): `Quinta a domingo, das 18h à meia-noite`

---

### 5.3 Manifesto

**Objetivo:** enunciar a tese da casa. É a seção que transforma "pizza" em "experiência".

- **Layout:** somente texto, centralizado, sem imagem. Fundo `carvao`.
- **Proporção:** bloco de texto ocupa 66% da largura (8 de 12 colunas), centralizado. Sobra deliberada nas laterais.
- Acima do título, três palavras separadas por filetes `latao`, em display 24px: `FERMENTO` · `FORNO` · `TERRITÓRIO`.

**Copy:**

- **H2:** `Um só caminho, servido devagar.`
- Parágrafo: `No Reis Bistrô não existe cardápio para escolher. Existe um percurso: seis discos de massa que atravessam a noite, do pão de lúpulo ao doce de trigo. O mesmo fermento que levanta a massa alimenta a cerveja que servimos ao lado dela — e é por isso que uma não faz sentido sem a outra.`
- Assinatura (14px, itálico, `cinza-texto`): `Dener Reis, chef e fundador`

---

### 5.4 O Chef

**Objetivo:** dar rosto e legitimidade à casa. É aqui que a estrela Michelin ganha uma história.

- **Layout:** duas colunas.
- **Proporção desktop:** imagem 50% / texto 50%. Imagem à **esquerda**, sangrando até a borda esquerda da tela (full-bleed de um lado só). Texto à direita, com padding interno de 80px.
- **Proporção mobile:** empilhado — imagem 100% da largura em proporção 4:5, texto abaixo.
- Alinhamento vertical do texto: centralizado em relação à imagem.

**Copy:**

- Rótulo (12px, caixa alta, `latao`): `O CHEF`
- **H2:** `Dener Reis`
- Parágrafo 1: `Dener cresceu diante do forno a lenha da padaria do avô, no Castanho. Passou dez anos estudando fermentação natural antes de entender que o fermento do pão da família e o da cerveja que fabricava no quintal eram, no fundo, o mesmo organismo.`
- Parágrafo 2: `Em 2019 ele transformou a casa onde nasceu em um bistrô de doze lugares. A cozinha é aberta: quem senta assiste cada disco ser aberto à mão e entrar no forno.`
- Citação destacada (display 28px, itálico, `creme`): `"Massa boa não se faz com pressa. Se faz com tempo e com atenção."`

---

### 5.5 O Menu Degustação

**Objetivo:** provar que o valor cobrado se sustenta. É a seção mais longa e a mais importante depois do Hero.

- **Layout:** lista vertical de 6 etapas, fundo `carvao-claro`.
- **Cada etapa é uma linha** com a seguinte proporção interna: numeração 8% · nome e descrição 62% · miniatura de foto 30%.
- No desktop, as linhas **alternam o lado da miniatura** (etapa 1 à direita, etapa 2 à esquerda, e assim por diante) para criar ritmo.
- Filete `latao` a 24% separando cada etapa. Numeração em display 48px na cor `latao`.
- No mobile: miniatura 100% da largura (proporção 3:2) acima do texto de cada etapa.
- Acima da lista, cabeçalho da seção centralizado. Abaixo da lista, o bloco de preço.

**Copy do cabeçalho:**

- Rótulo: `O MENU`
- **H2:** `Seis etapas`
- Linha de apoio: `O menu muda com o que a estação entrega. Este é o percurso de hoje.`

**Copy das etapas** (nome · descrição):

1. **Fermento Zero** · `Pão de lúpulo assado na hora, manteiga de bacon defumado e sal de brasa.`
2. **Margherita do Castanho** · `Tomate de horta de Jundiaí, búfala fresca, basílico queimado. A etapa que mede a casa.`
3. **Niágara & Ricota** · `Uva niágara passada no forno, ricota defumada, mel de bugre e pimenta rosa.`
4. **Fritta de Rabada** · `Disco frito, rabada desfiada por seis horas, agrião do rio e limão-cravo.`
5. **Lúpulo & Funghi** · `Creme de lúpulo fresco, cogumelos da serra, gema curada e avelã.`
6. **Doce de Trigo** · `Massa doce ao forno, doce de leite de cabra e sorvete de malte torrado.`

**Bloco de preço** (centralizado, com filete acima e abaixo):

- `MENU DEGUSTAÇÃO — R$ 390 por pessoa`
- Linha secundária (14px, `cinza-texto`): `Serviço não incluso. Restrições alimentares podem ser informadas na reserva.`

---

### 5.6 Harmonização Reis Beer

**Objetivo:** vender a harmonização como parte da experiência, não como adicional. É o principal alavancador de ticket médio.

- **Layout:** duas colunas, fundo `carvao`.
- **Proporção desktop:** texto 40% à esquerda / imagem 60% à direita. A imagem sangra até a borda direita da tela.
- **Proporção mobile:** imagem 100% (proporção 4:5) acima, texto abaixo.
- Dentro da coluna de texto, os 5 rótulos aparecem como lista compacta: nome em display 20px, estilo e etapa harmonizada em 14px `cinza-texto`.
- Ao final do bloco de texto, o **CTA secundário** `Reservar com harmonização`.

**Copy:**

- Rótulo: `A CERVEJARIA`
- **H2:** `Reis Beer`
- Parágrafo: `A cervejaria ocupa o fundo da casa e existe por um motivo só: alimentar o fermento da massa e acompanhar cada etapa do menu. Cinco rótulos, produzidos aqui, servidos apenas aqui.`
- Lista de rótulos:
  - **Coroa** — pilsen de trigo · etapa 1
  - **Castanho** — amber ale · etapa 2
  - **Niágara** — sour de uva · etapa 3
  - **Meia-Noite** — stout de café · etapas 4 e 5
  - **Forno** — saison defumada · etapa 6
- Preço: `HARMONIZAÇÃO COMPLETA — R$ 180 por pessoa`
- CTA secundário: `Reservar com harmonização`

---

### 5.7 A Casa (galeria)

**Objetivo:** mostrar o ambiente para quem precisa imaginar a noite antes de reservar.

- **Layout:** grade assimétrica de **4 imagens**, sem legendas, sem carrossel, sem lightbox.
- **Proporção desktop:** uma imagem grande ocupando 8 colunas (66%) e altura 720px à esquerda; à direita, coluna de 4 colunas (33%) com três imagens empilhadas de 240px cada, separadas por 8px.
- **Proporção mobile:** rolagem horizontal única, imagens em 85% da largura da viewport, proporção 3:4.
- Título da seção posicionado **acima e à esquerda** da grade, sem centralizar.

**Copy:**

- Rótulo: `A CASA`
- **H2:** `Doze lugares, cozinha aberta.`
- Linha única de apoio: `Uma casa de 1948 no Castanho, com o forno no centro da sala.`

---

### 5.8 Informações práticas

**Objetivo:** eliminar toda dúvida logística que impeça a reserva.

- **Layout:** duas colunas, fundo `carvao-claro`.
- **Proporção desktop:** informações em texto 45% à esquerda / mapa 55% à direita.
- **Proporção mobile:** texto 100% acima, mapa 100% abaixo com altura de 280px.
- Mapa: incorporação estática, **sem interatividade e sem carregar scripts de terceiros no primeiro paint**. Preferir imagem do mapa clicável que abre o Google Maps em nova aba. Isso protege performance e evita cookies de terceiros.
- As informações são organizadas em 4 grupos com filete entre eles: Horário · Endereço · Contato · Como funciona a reserva.

**Copy:**

- Rótulo: `VISITE`
- **H2:** `Quinta a domingo`
- **Horário:** `Quinta, sexta, sábado e domingo, das 18h à meia-noite. Fechamos de segunda a quarta.`
- **Endereço:** `Rua do Castanho, 412 — Castanho, Jundiaí/SP` + link `Ver no mapa`
- **Contato:** `(11) 3456-7890` (link `tel:` e `WhatsApp`) · `contato@reisbistro.exemplo` · `@reisbistro`
- **Como funciona a reserva:** `A reserva é feita pelo site, para uma mesa de até quatro pessoas. O menu degustação é servido para toda a mesa. Avise-nos de restrições alimentares no momento da reserva.`

---

### 5.9 Bloco final de reserva

**Objetivo:** último ponto de conversão. Quem chegou até aqui está decidido — não colocar nada depois dele além do rodapé.

- **Layout:** faixa de altura 520px com **imagem de fundo em tela cheia** (100% da seção) e overlay `carvao` a 70% de opacidade. Conteúdo centralizado.
- **Proporção do bloco de conteúdo:** 50% da largura, centralizado.

**Copy:**

- **H2 (display 56px):** `Quatro noites por semana. Doze lugares.`
- Parágrafo curto: `As mesas de sexta e sábado costumam fechar com antecedência.`
- Botão primário: `RESERVAR MESA`
- Linha de apoio (14px): `Ou fale com a gente pelo WhatsApp: (11) 3456-7890`

---

### 5.10 Footer

**Objetivo:** fechar a página com sobriedade e dar os dados legais e de contato.

- **Layout:** três colunas, fundo `carvao`, texto `cinza-texto` 14px, altura aproximada 240px.
- **Proporção:** logotipo e frase 40% · navegação 30% · contato e social 30%.
- Filete `latao` a 24% no topo do rodapé.
- Linha inferior de largura total: crédito e ano.

**Copy:**

- Coluna 1: `REIS BISTRÔ` + `Pizza de autor e cerveja da casa. Jundiaí, São Paulo.`
- Coluna 2: `Menu` · `O Chef` · `A Casa` · `Reservar`
- Coluna 3: `(11) 3456-7890` · `contato@reisbistro.exemplo` · `@reisbistro`
- Linha inferior: `© 2026 Reis Bistrô. Todos os direitos reservados.`

---

## 6. Telas de reserva (`/reservas`)

Fluxo completo de reserva, **somente layout e marcação**. Nada de calendário em JavaScript, validação, cálculo de disponibilidade ou envio — o comportamento será implementado por nós em Rails.

### 6.0 Premissas de negócio que o layout precisa refletir

| Regra | Valor |
| --- | --- |
| Noites de funcionamento | Quinta, sexta, sábado e domingo |
| Turnos por noite | Dois: **18h30** e **21h00** |
| Duração da experiência | Cerca de 2h30 |
| Capacidade | 12 mesas por turno, 24 por noite |
| Tamanho da mesa | 1 a 4 pessoas. Uma reserva ocupa uma mesa, independente do número de pessoas |
| Antecedência mínima | 2 horas antes do turno |
| Janela de reserva | 90 dias à frente |
| Grupos acima de 4 | Não são atendidos pelo site — direcionar ao WhatsApp |
| Menu | Único, servido para toda a mesa. Não há escolha de pratos |
| Harmonização | Opcional, escolhida por pessoa |
| Cancelamento | Até 24h antes do horário, pelo WhatsApp |
| Pagamento | Não há pagamento nem pré-pagamento no site |

Os números de disponibilidade vêm do banco (ver item 6.8). Os três estados de noite — disponível, últimas mesas, esgotado — todos ocorrem.

### 6.1 Estrutura do fluxo

Quatro telas, sempre na mesma ordem:

| Passo | Tela | Pergunta que responde |
| --- | --- | --- |
| 1 | Data, horário e pessoas | Quando e para quantos |
| 2 | Harmonização Reis Beer | Vai beber a cerveja da casa |
| 3 | Seus dados | Quem é você e como te avisamos |
| — | Confirmação | Deu certo, e o que acontece agora |

**Regras do fluxo:**

- Uma tela por vez, sem acordeão e sem tudo na mesma página. Reduz a sensação de formulário longo.
- Indicador de progresso no topo: `1 Data · 2 Harmonização · 3 Seus dados`, com o passo atual em `latao` e os anteriores clicáveis para voltar.
- **Nunca perder a seleção ao voltar.** O passo anterior reabre com a escolha marcada.
- Cada tela tem um único botão primário de avanço, alinhado à direita no desktop e em largura total no mobile.

### 6.2 Layout base das telas de reserva

- Mesmo Design System do item 3. Fundo `carvao`. **Sem fotografia de fundo** nessas telas: aqui o trabalho é decidir, não sonhar.
- **Navbar reduzida:** logotipo centralizado + link discreto `← Voltar ao site` à esquerda. Sem menu de âncoras, sem CTA de reserva.
- **Sem footer completo.** Apenas uma linha com telefone, e-mail e link para a política de cancelamento.
- **Proporção desktop:** conteúdo do passo 60% à esquerda (7 de 12 colunas) · **resumo da reserva 33% à direita** (4 colunas), em `position: sticky`, começando 120px do topo.
- **Proporção mobile:** conteúdo 100%. O resumo vira uma **barra fixa no rodapé** com 72px de altura, mostrando `data · horário · pessoas` de um lado e o valor total do outro, com um toque para expandir.
- Largura máxima do conteúdo: 1120px, centralizado.

**Card de resumo da reserva** (presente nos passos 1, 2 e 3):

- Título `SUA RESERVA` em 12px, caixa alta, `latao`.
- Linhas preenchidas progressivamente; o que ainda não foi escolhido aparece como `—` em `cinza-texto`, nunca oculto: `Data` · `Horário` · `Pessoas` · `Menu degustação` · `Harmonização`.
- Filete `latao` e, abaixo, `Total` em display 28px.
- Nota final em 12px: `Serviço não incluso. O pagamento é feito no restaurante.`

### 6.3 Passo 1 — Data, horário e pessoas

**Objetivo:** mostrar em uma tela só quando é possível vir, sem obrigar o visitante a tentar datas no escuro.

**Título:** `Quando você vem?`
**Linha de apoio:** `Servimos de quinta a domingo, em dois turnos. A experiência dura cerca de 2h30.`

**a) Calendário**

- Um mês por vez, semana começando no **domingo**, cabeçalho `D S T Q Q S S`.
- Proporção: o calendário ocupa 100% da coluna de conteúdo. Células quadradas, no mínimo 48×48px.
- Navegação por setas `‹ ›` ao lado do nome do mês. Limite de **90 dias** à frente; seta desabilitada ao chegar no limite.
- Estados obrigatórios de cada dia:

| Estado | Aparência |
| --- | --- |
| Disponível | Texto `creme`, borda 1px `latao` a 40%. Hover: fundo `latao` a 12% |
| Últimas mesas | Igual a disponível, com ponto `cobre` de 4px abaixo do número |
| Esgotado | Texto `cinza-texto`, sem borda, número riscado. Não clicável |
| Fechado (seg a qua) | Texto `cinza-texto` a 40%, sem borda, sem cursor. Não clicável |
| Selecionado | Fundo `latao`, texto `carvao`, peso maior |
| Passado | Idêntico a fechado |

- Legenda abaixo do calendário, em 12px: `Disponível` · `Últimas mesas` · `Esgotado` · `Fechamos de segunda a quarta`.

**b) Turnos** — aparecem abaixo do calendário **depois** que uma data é escolhida.

- Dois cards lado a lado, 50% cada no desktop, empilhados no mobile.
- Cada card: horário em display 32px (`18h30`), e abaixo, em 13px, a disponibilidade (`4 mesas`, `últimas 2 mesas` em `cobre`, ou `esgotado` em `cinza-texto`).
- Card esgotado: opacidade 40%, não clicável, sem hover.
- Card selecionado: borda 1px `latao` cheia e fundo `latao` a 10%.

**c) Número de pessoas**

- Quatro botões quadrados: `1` `2` `3` `4`. Selecionado com fundo `latao`.
- Abaixo, em 13px `cinza-texto`: `Mesas de até quatro pessoas. Para grupos maiores, fale com a gente pelo WhatsApp (11) 3456-7890.` — com o número como link.
- **Não existe campo numérico livre nem seletor com mais de 4.** A regra de negócio é comunicada pela ausência da opção, não por mensagem de erro.

**Botão primário:** `CONTINUAR` — visualmente desabilitado até que data, turno e número de pessoas estejam escolhidos.

### 6.4 Passo 2 — Harmonização Reis Beer

**Objetivo:** é a tela de maior impacto no ticket médio. Ela precisa parecer parte da experiência, não uma tentativa de venda.

**Título:** `Vai de Reis Beer?`
**Linha de apoio:** `Os cinco rótulos são produzidos na casa e acompanham as seis etapas do menu. R$ 180 por pessoa.`

- **Proporção desktop:** as duas opções ocupam 100% da coluna de conteúdo, empilhadas verticalmente. A lista dos cinco rótulos entra **dentro** do card da opção com harmonização.
- **Opção A (em destaque, listada primeiro):** `Com harmonização` — borda 1px `latao`, selo `RECOMENDADO` em 11px no canto superior. Dentro, a lista dos rótulos em duas colunas: nome em 16px, estilo e etapa em 13px `cinza-texto`.
- **Opção B:** `Sem harmonização` — apenas contorno 1px `creme` a 30%. Linha de apoio: `Água, café e sucos seguem disponíveis à parte.`
- **Nenhuma das duas vem pré-selecionada.** Pré-marcar o upsell é escolha do restaurante, não do cliente — além de gerar cancelamento na chegada.
- **Se a mesa tiver 2, 3 ou 4 pessoas**, a opção A abre um seletor: `Para quantas pessoas?` com botões de `1` até o número de pessoas da mesa, com o total pré-selecionado. Serve para mesa com quem não bebe, e evita que o cliente recuse a harmonização inteira por causa de uma pessoa.
- O card de resumo atualiza o `Total` na hora.

**Botões:** primário `CONTINUAR` e, ao lado, secundário `← Voltar`.

### 6.5 Passo 3 — Seus dados

**Objetivo:** coletar o mínimo necessário sem assustar quem já decidiu.

**Título:** `Só faltam seus dados`

- **Proporção:** formulário em coluna única, largura máxima de 560px. Campos em 100% dessa largura, exceto telefone e e-mail, que podem dividir a linha em 50%/50% no desktop.
- **Label sempre visível acima do campo.** Nunca usar apenas `placeholder` como rótulo.
- Campos:

| Campo | Tipo | Obrigatório | Observação |
| --- | --- | --- | --- |
| Nome completo | texto | Sim | |
| E-mail | e-mail | Sim | Linha de ajuda: `É para onde enviamos a confirmação.` |
| Telefone / WhatsApp | telefone | Sim | Máscara `(00) 00000-0000` |
| Restrições alimentares ou alergias | textarea, 3 linhas | Não | Ajuda: `O menu é único, mas adaptamos as etapas quando possível.` |
| Ocasião especial | seleção | Não | Opções: `Nenhuma` · `Aniversário` · `Comemoração` · `Primeira visita` |
| Aceite | caixa de seleção | Sim | `Li e aceito a política de cancelamento: até 24h antes do horário reservado, pelo WhatsApp.` |

- Estilo de campo: fundo `carvao-claro`, borda inferior 1px `creme` a 25%, sem cantos arredondados. Em foco: borda `latao` de 2px.
- **Erro de campo:** borda `tijolo`, mensagem em 13px `tijolo` **abaixo** do campo, e ícone de alerta. A mensagem diz o que fazer (`Informe um e-mail válido`), nunca só `Campo inválido`.
- Acima do formulário, repetir o resumo em uma linha compacta no mobile, já que a barra inferior fica coberta pelo teclado.

**Botão primário:** `CONFIRMAR RESERVA`. Precisa de estado de carregamento: texto vira `CONFIRMANDO…`, botão desabilitado. Sem isso o cliente clica duas vezes e gera reserva duplicada.

### 6.6 Tela de confirmação

**Objetivo:** dar segurança de que a mesa está garantida e reduzir o no-show.

- **Proporção:** bloco centralizado de 640px, sem coluna de resumo lateral (o resumo passa a ser o conteúdo principal).
- Marca de sucesso discreta: filete `latao` e um símbolo simples. **Sem confete, sem ilustração, sem animação.**

**Copy:**

- **H1:** `Mesa reservada.`
- Parágrafo: `Enviamos a confirmação para o seu e-mail. Se precisar mudar algo, fale com a gente pelo WhatsApp.`
- Bloco de resumo com filetes: `Data e horário` · `Pessoas` · `Harmonização` · `Total estimado` · `Código da reserva`.
- Bloco `Como chegar`: endereço + link `Abrir no mapa`.
- Três avisos curtos em lista, 14px: `Chegue com 10 minutos de antecedência — o menu começa no horário.` · `A experiência dura cerca de 2h30.` · `Cancelamento sem custo até 24h antes.`
- Ações: botão secundário `Falar no WhatsApp` e link `Voltar ao site`.

### 6.7 Estados que também precisam ser desenhados

Estas telas existem na prática e, se não vierem no design, a gente improvisa mal na integração:

1. **Mês sem nenhuma data disponível:** calendário com todos os dias apagados e um bloco central: `Não há mesas disponíveis em [mês]. Tente o mês seguinte ou entre na lista de espera pelo WhatsApp.`
2. **Data esgotou enquanto o cliente decidia:** faixa `tijolo` no topo do passo 1: `Esta data acabou de esgotar. Escolha outra data ou turno.`
3. **Falha ao confirmar:** faixa `tijolo` acima do botão no passo 3: `Não conseguimos confirmar sua reserva. Nada foi cobrado e nenhuma mesa foi reservada. Tente novamente ou fale pelo WhatsApp.` O formulário **mantém tudo que foi preenchido**.
4. **Carregando disponibilidade:** o calendário e os cards de turno em estado *skeleton* (blocos `carvao-claro` pulsando levemente), preservando a mesma altura para o layout não saltar.
5. **Foco e teclado:** o calendário navegável por `Tab` e setas. Cada dia é um `<button>` dentro de `<table>`, nunca uma `<div>` clicável.

### 6.8 Estado da implementação

**Decisão do produto:** não houve etapa de designer externo. As quatro telas foram construídas direto em Rails, seguindo a copy e a estrutura descritas acima.

Arquivos:

| Tela | Rota | Arquivo |
| --- | --- | --- |
| Passo 1 | `/reservas` | `app/views/reservations/new.html.erb` |
| Passo 2 | `/reservas/harmonizacao` | `app/views/reservations/harmonizacao.html.erb` |
| Passo 3 | `/reservas/dados` | `app/views/reservations/dados.html.erb` |
| Confirmação | `/reservas/confirmada/:token` | `app/views/reservations/confirmada.html.erb` |

Compartilhados: `_navbar_reduzida`, `_progresso`, `_resumo`, `_rodape_minimo`, `_calendario`, `_erro_do_campo`. Classes de componente em `app/assets/tailwind/application.css`: `.dia` (+ `--selecionado`, `--ultimas`, `--esgotado`, `--fechado`), `.escolha` (+ `--numero`, `--upsell`, `--indisponivel`), `.campo` (+ `--erro`), `.caixa`, `.faixa-erro`, `.skeleton`, `.botao--travado`.

**Como as telas funcionam sem JavaScript:**

- Toda opção é `<input type="radio">` real, escondido, com o estado visual vindo de `:has(:checked)`.
- Clicar num dia do calendário envia um formulário `GET` e recarrega o passo 1, o que recalcula as mesas restantes de cada turno. Vira um Turbo Frame quando valer a pena.
- O `CONTINUAR` fica visualmente travado até as escolhas do passo estarem feitas (`.botao--travado`), e os radios têm `required`, que é o que realmente barra o envio.
- As escolhas dos passos 1 e 2 viajam pela query string. Só o passo 3 grava, num `POST`.

### 6.9 Backend das reservas

**Onde as regras moram:** `app/models/reservation.rb`. Nada de regra de negócio em helper ou view.

| Peça | Arquivo | Papel |
| --- | --- | --- |
| Modelo | `app/models/reservation.rb` | Constantes de negócio, validações, ocupação de mesa, código e token |
| Disponibilidade | `app/models/disponibilidade.rb` | Responde o mês inteiro do calendário em **uma** consulta, evitando N+1 |
| Controller | `app/controllers/reservations_controller.rb` | Passos por `GET`, gravação no `POST`, erros de volta na tela certa |
| Helper | `app/helpers/reservations_helper.rb` | Só formatação: datas em português, reais, rótulos de turno |
| Tabela | `reservations` | `data`, `turno`, `mesa`, `pessoas`, `harmonizacoes`, contato, `codigo`, `token`, `status` |

**Trava de overbooking.** Cada reserva ocupa a primeira mesa livre de 1 a 12. O índice único parcial `index_reservations_on_mesa_ocupada` sobre `(data, turno, mesa)` restrito a `status = 'confirmada'` é a garantia real: se dois pedidos simultâneos escolherem a mesma mesa, o banco recusa o segundo e `Reservation#salvar_ocupando_mesa` tenta a mesa seguinte. Cancelar libera a mesa, porque o índice ignora reservas canceladas.

**Duas identificações, de propósito.** `codigo` (`RB-M5BY`, alfabeto sem `0/O/1/I`) é o que se lê em voz alta na recepção. `token` (22 caracteres aleatórios) é o que vai na URL da confirmação — um código de 4 caracteres na URL seria adivinhável por tentativa e exporia o nome e o telefone de outras reservas.

**Fuso.** `config.time_zone = "America/Sao_Paulo"`. O banco guarda em UTC; o corte de 2 horas é calculado no horário da casa.

**Validações que barram prejuízo:** noite de funcionamento, janela de 90 dias, 1 a 4 pessoas, harmonizações ≤ pessoas, antecedência de 2 horas, turno com mesa livre e aceite da política de cancelamento (com `allow_nil: false`, senão um `POST` que omite o campo passaria).

**Sem envio de nada.** Não há e-mail nem WhatsApp automático nesta fase. O cliente sai com o código na tela, um botão que abre o WhatsApp com a mensagem da reserva pronta e um botão de adicionar à agenda. O campo de e-mail virou **opcional**, porque não há para onde enviar.

**Dados de exemplo:** `bin/rails db:seed` preenche as próximas noites em ciclos de lotação para que os três estados apareçam no calendário. Não roda em produção.

**Testes:** `bin/rails test` — 23 testes cobrindo capacidade por turno, liberação por cancelamento, recusa da décima terceira mesa, corte de antecedência, aceite da política, o fluxo dos quatro passos, erro de preenchimento que volta ao passo 3 sem perder o que foi digitado e turno esgotado que volta ao passo 1.

**Pré-visualização de dois estados sem gatilho real**, para revisão de design: `/reservas?estado=vazio` e `/reservas?estado=carregando`. Os estados de erro e de esgotado saíram da chave porque agora acontecem de verdade.

**O que ainda depende de JavaScript:**

1. `Total` do card de resumo atualizando na hora, sem recarregar (item 6.4).
2. Botão `CONFIRMANDO…` desabilitado durante o envio (item 6.5).
3. Máscara de telefone `(00) 00000-0000` (item 6.5).
4. Barra de resumo do mobile expansível ao toque (item 6.2) — hoje ela é fixa e, no passo 3, é substituída por uma linha compacta no topo, já que o teclado cobre o rodapé.
5. Navegação do calendário por setas do teclado (item 6.7). `Tab` já funciona, porque cada dia é um `<button>` dentro de `<table>`.

**Pendências abertas:**

- **A casa não vê as reservas.** Elas estão gravadas, mas não há tela para o restaurante consultar a noite. Hoje só dá pelo console. É o próximo buraco operacional a fechar.
- Não há como cancelar pelo site: `Reservation#cancelar!` existe, mas só pelo console.
- O rodapé cita a política de cancelamento como texto, não como link — ainda não existe uma página de política para apontar.
- Nada impede a mesma pessoa de reservar duas mesas na mesma noite.

---

## 7. Imagens: placeholder + direção de arte

**Decisão do produto:** a casa ainda não tem ensaio fotográfico. O designer entrega o layout com **imagens temporárias de banco (placeholders)**, escolhidas para respeitar a direção de arte descrita abaixo. As fotos reais entram depois, sem que ninguém precise mexer no layout.

### 7.1 Direção de arte por posição

Cada linha é um "slot" de imagem. A coluna `Arquivo` define o nome que o designer **deve** usar — é o que garante a troca futura sem refatorar.

As 14 imagens **já existem** em `app/assets/images/`, em WebP. A coluna `Proporção do contêiner` é a que o CSS aplica; a coluna `Arquivo real` mostra o que o arquivo tem hoje. Onde as duas divergem, o `object-fit: cover` corta o excedente — é o comportamento desejado, não um defeito.

| # | Posição | Arquivo | Proporção do contêiner | Arquivo real | O que a imagem mostra |
| --- | --- | --- | --- | --- | --- |
| 1 | Hero | `hero.webp` | 16:9 | 1536×1024 (3:2) | Disco de massa entrando no forno a lenha, brasa visível, metade esquerda do quadro escura. |
| 2 | O Chef | `chef.webp` | 4:5 | 1024×1536 (2:3) | Homem de perfil abrindo massa à mão, rosto na sombra e não identificável, foco na massa e na farinha. |
| 3 | Menu, etapas 1 a 6 | `menu-01.webp` … `menu-06.webp` | 3:2 | 1536×1024 (3:2) | Close curto de um prato sobre louça escura, fundo neutro, luz única. |
| 4 | Reis Beer | `cervejaria.webp` | 4:5 | 1024×1536 (2:3) | Copo de cerveja em contraluz diante dos tanques da cervejaria. |
| 5 | A Casa, imagem grande | `casa-principal.webp` | 3:2 | 1536×1024 (3:2) | Salão à noite, mesas postas, forno aceso ao fundo. |
| 6 | A Casa, miniatura A | `casa-mesa.webp` | 1:1 | 1024×1024 | Mesa posta: louça escura, taça de cerveja, cutelaria de latão, vela. |
| 7 | A Casa, miniatura B | `casa-servico.webp` | 1:1 | 1024×1024 | Garçom de costas servindo um prato, sem rosto visível. |
| 8 | A Casa, miniatura C | `casa-fachada.webp` | 1:1 | 1024×1024 | Fachada de casa antiga à noite, luz quente saindo pela porta, sem placa. |
| 9 | Bloco final de reserva | `reserva.webp` | 16:9 | 1536×1024 (3:2) | Salão cheio visto de longe, luz baixa, pessoas em movimento suave. |

**Total: 14 imagens, 1,1MB somadas.** Nenhuma passa de 123KB.

**Limite conhecido:** a maior dimensão gerada é 1536px. Nos dois slots de tela cheia (`hero` e `reserva`) isso fica abaixo do ideal para telas de 2560px, e a imagem vai parecer levemente suave em monitor grande. Aceitável para captação; é o primeiro item a melhorar quando houver ensaio fotográfico.

### 7.2 Regras gerais de imagem

- Paleta quente e escura, coerente com o fundo `carvao`. Sem filtro saturado, sem HDR.
- Ninguém olhando para a câmera. Sem imagem com texto embutido. Sem watermark.
- Nenhuma imagem acima de **300KB**. Formato **WebP**.
- Todas com `alt` descritivo em PT-BR (ex.: `alt="Massa de pizza sendo colocada no forno a lenha"`).
- Nos slots 1 e 9 (texto sobre imagem), escolher placeholder com **área escura e de baixo detalhe** na região onde o texto entra, para o contraste não quebrar.

### 7.3 De onde vêm as imagens

**As 14 imagens foram geradas por IA e já estão em `app/assets/images/`**, com os nomes de arquivo do item 7.1. Os prompts, o estilo base e o critério de aceitação estão em `imagens-prompts.md`.

Ninguém precisa buscar nem escolher imagem: basta referenciar os nomes definidos. Se alguma precisar ser trocada, regerar pelo prompt correspondente e sobrescrever o arquivo — nunca substituir por imagem de outra fonte, para não quebrar a coerência visual do conjunto.

**Proibido em qualquer hipótese:** baixar imagem de Google Imagens, de site de concorrente ou dos benchmarks do item 2. É risco jurídico direto de direito autoral em site comercial.

**Restrição de conteúdo herdada da geração por IA**, que o designer precisa conhecer ao montar as telas: nenhuma imagem tem texto, rótulo legível, rosto reconhecível ou mão em primeiro plano. Portanto, não planejar composição que dependa desses elementos.

### 7.4 Como o código deve tratar o placeholder

Isto é o que faz a troca futura custar minutos em vez de dias:

- Cada slot é uma `<img>` dentro de um contêiner com **proporção fixa em CSS** (`aspect-ratio`) e `object-fit: cover; object-position: center`. **A altura nunca vem da imagem** — vem do contêiner.
- Os nomes de arquivo do item 7.1 são contratuais. Substituir a foto real significa sobrescrever o arquivo com o mesmo nome; nada de `hero-final-v2.webp`.
- Todas as imagens ficam em `/images`, sem subpastas.
- `loading="lazy"` em tudo, **exceto** `hero.webp`, que leva `loading="eager"` e `fetchpriority="high"`.
- Todo contêiner de imagem recebe uma cor de fundo sólida (`carvao-claro`) para o layout não piscar em branco enquanto carrega.
- As imagens são fornecidas pelo dono do produto, geradas por IA (ver `imagens-prompts.md`). O designer não substitui nem recorta por conta própria: se o enquadramento não servir, avisar para regerarmos.

### 7.5 Plano de substituição pelas fotos reais

1. Contratar o ensaio com este documento em mãos: são 14 fotos, e o item 7.1 já é o roteiro do fotógrafo (posição, proporção e conteúdo de cada uma).
2. Exportar cada foto real na proporção e no tamanho da tabela, converter para WebP abaixo de 300KB.
3. Sobrescrever os arquivos em `/images` mantendo os nomes. Revisar os `alt`.
4. Conferir apenas os slots 1 e 9, onde há texto sobre a imagem.
5. Prioridade da troca, se o ensaio for feito em etapas: primeiro as 6 imagens de menu (é onde a IA convence menos e onde o cliente decide se vale R$ 390), depois o retrato do chef, e por último o ambiente.

**Decisão do produto:** a página **entra no ar com as imagens ilustrativas**, para começar a captar reservas antes do ensaio fotográfico. A troca pelas fotos reais acontece depois, sem alterar o layout.

**Salvaguarda obrigatória enquanto durar o placeholder:** incluir a nota `Imagens ilustrativas` em duas posições — como legenda de 12px em `cinza-texto` ao pé da galeria (item 5.7) e no rodapé. É uma linha de texto que remove o risco de leitura como propaganda enganosa (CDC, art. 37) e custa nada. Ao subir as fotos reais, apagar as duas notas.

---

## 8. Responsividade e acessibilidade

- Breakpoints: `mobile < 768px` · `tablet 768–1279px` · `desktop ≥ 1280px`. Mobile é o caso de uso dominante — projetar a partir dele.
- No tablet, todas as seções de duas colunas passam a empilhar, exceto o rodapé.
- Contraste mínimo AA: texto `creme` sobre `carvao` já atende; **atenção ao texto sobre imagem** — o overlay é obrigatório, não opcional.
- Área de toque mínima de 44×44px em qualquer elemento clicável.
- Foco visível por teclado em todos os links e botões (contorno 2px `latao`).
- Toda imagem de fundo com texto sobreposto precisa de fallback de cor sólida, caso a imagem não carregue.
- Respeitar `prefers-reduced-motion`: desligar os fade-ins.
- **Nas telas de reserva:** o mobile é onde a maior parte das reservas vai acontecer. Garantir que o botão primário nunca fique atrás do teclado virtual, que as células do calendário respeitem os 44×44px de área de toque, e que a barra de resumo fixa não cubra o último campo do formulário.

---

## 9. Entrega esperada do designer

Esta seção é uma restrição técnica, não uma preferência. A página será integrada a uma aplicação **Ruby on Rails com Tailwind CSS**.

**O que precisamos receber:**

1. Arquivo de design (Figma) com desktop e mobile das 9 seções da landing (item 5), das 4 telas de reserva (item 6) e dos estados do item 6.7, com os tokens do item 3 publicados como estilos.
2. `index.html` semântico com a landing, mais os 4 arquivos de reserva do item 6.8, todos compartilhando um único `style.css`, com as imagens em uma pasta `/images`.
3. Fontes carregadas via Google Fonts, com `preconnect`.
4. O HTML apontando para as 14 imagens com os nomes de arquivo exatos do item 7.1. As imagens são entregues **pelo dono do produto** ao designer, já geradas.

**O que NÃO podemos receber:**

- Projeto em React, Vue, Next, Astro ou qualquer framework com etapa de build própria.
- Bootstrap, jQuery, ou biblioteca de animação (GSAP, AOS, Lottie).
- HTML exportado por ferramenta visual (Webflow, Framer, Wix, Figma-to-code) com classes geradas automaticamente e CSS absoluto posicionado por coordenadas.
- Imagens acima de 300KB. Entregar em WebP.

**Motivo:** qualquer um desses itens obriga a reescrever o layout de zero dentro do Rails, dobrando o custo e o prazo da integração.

**Marcação exigida:** usar `<header>`, `<main>`, `<section>` com `id` correspondente à âncora da navbar, `<footer>`. Cada seção do item 5 e cada passo do item 6 deve ser uma `<section>` independente e autocontida, para que possa ser convertida em um partial ERB isolado.

**Os quatro CTAs da landing devem ser links `<a href="/reservas">`.**

**Fronteira entre design e backend, nas telas de reserva:** o designer entrega a aparência de todos os estados; nós entregamos o comportamento. Concretamente, o designer **não** implementa: cálculo ou consulta de disponibilidade, lógica de qual dia está esgotado, validação de campo, máscara de telefone funcional, envio do formulário, navegação entre passos, ou persistência das escolhas. Tudo isso é nosso.

---

## 10. Fora de escopo desta entrega

- **Todo o backend de reservas:** modelagem de banco, disponibilidade real, regras de capacidade, controle de concorrência entre reservas simultâneas, e-mails de confirmação. As telas do item 6 são apenas a camada visual.
- Área administrativa e autenticação (visão do restaurante para ver as reservas da noite).
- Pagamento online ou pré-pagamento de reserva.
- Lista de espera automatizada — por ora ela acontece pelo WhatsApp.
- Blog, cardápio dinâmico, newsletter.
- Versão em inglês.
