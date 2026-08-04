# Prompts de imagem — Reis Bistrô

Arquivo para gerar as **14 imagens ilustrativas** da landing page do Reis Bistrô em uma LLM de imagem (Midjourney, DALL·E, Nano Banana, Ideogram, Flux ou equivalente).

Documento de referência do layout: `ux.md`, item 7.

---

## Como usar este arquivo

1. Gere as imagens na ordem em que aparecem aqui (item 4).
2. **Sempre cole o `ESTILO BASE` (item 2) no final de cada prompt.** É o que mantém as 14 imagens parecendo do mesmo restaurante, e não de 14 lugares diferentes.
3. Use os prompts em **inglês**. Os modelos de imagem respondem muito melhor em inglês; a descrição em português está ao lado apenas para você conferir o que foi pedido.
4. Gere 3 a 4 variações de cada e escolha a melhor pelo checklist do item 6.
5. Renomeie o arquivo escolhido **exatamente** com o nome indicado e siga o item 5 (conversão).

**Por que o nome do arquivo importa tanto:** o `ux.md` já entregou esses mesmos 14 nomes ao designer, que vai construir o HTML apontando para eles. Se você salvar as imagens com estes nomes, o designer só solta a pasta `/images` no projeto e tudo aparece no lugar certo, sem ninguém precisar mapear nada. Nome errado significa imagem quebrada ou foto de cerveja no lugar da sobremesa.

---

## 1. Regras que valem para todas as imagens

- **Proporção é obrigatória.** Cada imagem tem uma proporção definida porque o contêiner no site tem altura fixa. Gerar em 1:1 uma imagem que devia ser 16:9 vai cortar a cabeça da composição.
- **Nenhum texto na imagem.** Modelos de imagem escrevem errado. Nada de rótulo de cerveja legível, placa, menu escrito ou letreiro na fachada.
- **Nenhum rosto identificável.** Explicação no item 3.
- **Sem mão em close.** Mãos e dedos são o principal artefato visível de imagem gerada. Quando a mão for necessária, peça enquadramento distante ou parcialmente na sombra.
- **Ambiente escuro e quente**, sempre. A página tem fundo quase preto: uma foto clara e saturada vai parecer um adesivo colado.
- **Sem pizza redonda inteira vista de cima.** Esse é o enquadramento de rodízio e de aplicativo de delivery. Ele derruba sozinho o posicionamento de duas estrelas Michelin.

---

## 2. ESTILO BASE

Cole este bloco no fim de **todos** os prompts:

```
Style: cinematic editorial food photography for a two-Michelin-star restaurant, shot on 85mm lens, shallow depth of field, single warm tungsten and firelight source from the side, deep black shadows, dark charcoal background, muted palette of amber, brass and burnt umber, subtle film grain, natural texture, photorealistic, high detail, no text, no letters, no logos, no watermark, no people looking at camera
```

**Prompt negativo** (se a ferramenta tiver campo separado; senão, os `no ...` acima já cobrem):

```
text, letters, watermark, logo, bright daylight, oversaturated colors, HDR, plastic look, cartoon, illustration, 3d render, hands in close-up, deformed fingers, full round pizza from above, pizza slices, delivery box, checkered tablecloth, red and green italian flag decor, neon sign, crowded restaurant
```

---

## 3. Uma decisão que preciso que você tome

O slot `chef.webp` é o retrato do chef fictício da marca. Em um projeto de demonstração o retrato ilustrativo é aceitável; se o site virar produção com uma pessoa real, troque por foto autorizada.

Por isso, o prompt do item 4.2 pede uma figura **sem rosto identificável** — de costas, de perfil na sombra, foco na massa e no antebraço. Fica bonito, funciona como ilustração e sai fácil quando você tiver uma foto real sua.

**Se você preferir um retrato de rosto inteiro gerado por IA**, me diga e eu reescrevo o prompt. Mas registro que, na minha leitura, é o único slot dos 14 em que a imagem ilustrativa pode gerar desconfiança em vez de desejo.

---

## 4. Os 14 prompts

### 4.1 `hero.webp` — Abertura da página

**Proporção: 16:9** · Usada em tela cheia atrás do título principal.
**Atenção:** o texto do site entra sobre o **terço inferior esquerdo**. Escolha a variação que tenha essa área escura e sem detalhe.

> Em português: disco de massa de pizza entrando em forno a lenha, visto de baixo, brasa viva ao fundo, pá de forno, fumaça leve, muito escuro.

```
A raw hand-stretched pizza dough disc being slid into a glowing wood-fired brick oven, seen from a low angle, live orange embers and flames deep inside the oven mouth, thin wisps of smoke, long wooden peel, flour dust caught in the firelight, surrounding room almost completely dark, the bottom-left area of the frame in deep shadow with no detail
```

---

### 4.2 `chef.webp` — Seção "O Chef"

**Proporção: 4:5** · Coluna vertical ao lado do texto sobre Dener Reis.

> Em português: cozinheiro de perfil abrindo massa sobre bancada de mármore, rosto fora de foco e na sombra, foco na massa e na farinha.

```
A chef in a dark linen apron stretching pizza dough by hand on a worn marble counter, seen from the side, his face turned away and hidden in deep shadow, unrecognizable and out of focus, sharp focus on the dough and the flour dust in the air, dark kitchen behind him, one warm light from the left
```

---

### 4.3 `menu-01.webp` — Etapa 1, Fermento Zero

**Proporção: 3:2** · Miniatura da primeira etapa do menu.

> Em português: pão de lúpulo pequeno recém-assado, manteiga escura de bacon defumado, sal grosso, louça escura.

```
A small freshly baked artisan hop bread roll on a dark matte ceramic plate, cracked crust, torn open slightly, a quenelle of dark smoked bacon butter beside it, coarse smoked salt flakes scattered, steam barely visible, dark stone table, single side light
```

---

### 4.4 `menu-02.webp` — Etapa 2, Margherita do Castanho

**Proporção: 3:2**

> Em português: pequena pizza artesanal com tomate, búfala e basílico queimado, vista em ângulo baixo, jamais de cima.

```
A small rustic personal pizza with blistered charred crust, fresh cherry tomatoes, torn buffalo mozzarella and single charred basil leaves, photographed from a low three-quarter angle very close, only two thirds of the pizza visible in frame, dark matte ceramic plate, dark stone table, single warm side light
```

---

### 4.5 `menu-03.webp` — Etapa 3, Niágara & Ricota

**Proporção: 3:2**

> Em português: pizza branca com uvas verdes assadas, ricota defumada, fio de mel e pimenta rosa.

```
An elegant white pizza slice with roasted green grapes, smoked ricotta cream, a thin drizzle of dark honey and pink peppercorns, close three-quarter angle, only part of the dish in frame, dark ceramic plate, dark stone surface, single warm side light
```

---

### 4.6 `menu-04.webp` — Etapa 4, Fritta de Rabada

**Proporção: 3:2**

> Em português: massa frita dourada recheada com carne desfiada, agrião, gota de limão, louça escura.

```
A golden deep-fried folded pizza dough parcel, torn open to reveal slow-braised shredded beef, topped with fresh watercress leaves and a wedge of green lime, glistening crisp blistered surface, dark ceramic plate, dark stone table, single warm side light
```

---

### 4.7 `menu-05.webp` — Etapa 5, Lúpulo & Funghi

**Proporção: 3:2**

> Em português: pizza com creme claro, cogumelos variados, gema curada laranja intensa, avelã ralada.

```
A pizza with pale green herb cream base, assorted wild mushrooms, a deep orange cured egg yolk in the centre broken and running, grated hazelnut, close three-quarter angle, dark ceramic plate, dark stone surface, single warm side light
```

---

### 4.8 `menu-06.webp` — Etapa 6, Doce de Trigo

**Proporção: 3:2**

> Em português: sobremesa de massa doce assada com doce de leite e uma bola de sorvete de malte.

```
A dessert of baked sweet dough with dark dulce de leche, a single scoop of pale malt ice cream slowly melting on top, toasted wheat crumbs, dark ceramic plate, dark stone table, single warm side light, intimate and minimal
```

---

### 4.9 `cervejaria.webp` — Seção "Reis Beer"

**Proporção: 4:5** · Coluna vertical ao lado do texto da cervejaria.
**Atenção:** garrafa com rótulo é onde a IA erra mais. Peça **copo**, nunca rótulo.

```
A tall glass of amber craft beer in backlight, thick creamy foam head, condensation on the glass, standing on a dark steel surface in front of out-of-focus stainless steel brewery fermentation tanks, very dark room, single warm rim light from behind, no labels, no bottles, no text anywhere
```

---

### 4.10 `casa-principal.webp` — Galeria, imagem grande

**Proporção: 3:2**

> Em português: salão pequeno e escuro à noite, doze lugares postos, forno a lenha aceso ao fundo.

```
Interior of a small intimate restaurant at night, only about twelve seats, dark exposed brick and old plaster walls, tables set with dark linen and glassware, a lit wood-fired oven glowing warm orange at the back of the room, low pendant lights, empty room, warm and moody, wide shot
```

---

### 4.11 `casa-mesa.webp` — Galeria, miniatura A

**Proporção: 1:1**

```
Close detail of a set table in a fine dining restaurant, dark linen napkin, matte black ceramic plate, a single beer glass and a water glass, aged brass cutlery, one small candle out of focus behind, very dark surroundings, warm low light
```

---

### 4.12 `casa-servico.webp` — Galeria, miniatura B

**Proporção: 1:1**
**Atenção:** peça o braço distante e parcialmente cortado pelo quadro, para evitar dedos deformados.

```
A waiter in dark clothing placing a plate on a table, seen from a distance and from behind, arm partially cropped by the frame edge, motion slightly blurred, focus on the plate and the table, dark restaurant interior, warm low light, no visible face, no close-up hands
```

---

### 4.13 `casa-fachada.webp` — Galeria, miniatura C

**Proporção: 1:1**

> Em português: fachada discreta de casa antiga à noite, luz quente saindo pela porta, sem placa e sem nome.

```
The discreet facade of a small old 1940s house converted into a restaurant, at night, plain painted walls, a single open wooden door with warm golden light spilling onto the sidewalk, one small plant beside the entrance, quiet empty residential street, no signage, no lettering, no house number
```

---

### 4.14 `reserva.webp` — Bloco final de reserva

**Proporção: 16:9** · Fundo do último bloco da página.
**Atenção:** o texto entra **centralizado**. Escolha a variação com o centro do quadro escuro e sem detalhe.

```
A small intimate restaurant dining room full of guests at night, seen from far away across the room, people seated at tables in soft motion blur, no recognizable faces, warm low pendant lighting, glowing wood-fired oven in the background, the centre of the frame darker and low in detail, cinematic wide shot
```

---

## 5. Depois de gerar: preparar os arquivos

> **Status: concluído.** As 14 imagens já foram geradas e estão em `app/assets/images/`, em WebP, somando 1,1MB. A maior tem 123KB. Esta seção fica como receita para quando alguma imagem precisar ser regerada.

Sem esta etapa a página fica lenta e o layout salta.

1. **Não redimensione para cima.** Use a imagem na resolução em que foi gerada; ampliar só adiciona peso sem detalhe. Se a proporção não bater com o contêiner, o CSS corta pelo `object-fit: cover` — nunca deforme a imagem para caber.
2. Converta para **WebP** com qualidade 80 e confirme que cada arquivo ficou **abaixo de 300KB**. Ferramenta gratuita no navegador: [Squoosh](https://squoosh.app/).
3. Salve em `app/assets/images/`, sem subpastas, com os nomes exatos deste documento. Sem `v2`, sem `final`, sem espaço no nome.
4. O Propshaft serve automaticamente o que estiver nessa pasta, com digest no nome. Não precisa registrar a imagem em lugar nenhum.

**Como a conversão foi feita**, se precisar repetir: `sharp` (Node) instalado numa pasta temporária fora do repositório, convertendo em lote com qualidade 82 e queda progressiva até caber em 300KB. Alternativa sem Node: Squoosh, uma imagem por vez.

**Os PNGs originais** ficam fora do repositório, em `.cursor/projects/.../assets/`. São os masters: se precisar de outro corte, converta de novo a partir deles em vez de reprocessar o WebP.

---

## 6. Checklist antes de aceitar cada imagem

Rejeite e gere de novo se qualquer item falhar:

- [ ] A proporção está correta.
- [ ] Não há nenhuma letra, número, rótulo ou placa visível.
- [ ] Nenhum rosto reconhecível.
- [ ] Nenhuma mão em primeiro plano com dedos estranhos.
- [ ] A imagem é escura e quente, e combinaria com fundo quase preto.
- [ ] Nos slots `hero.webp` e `reserva.webp`: a área onde o texto entra está escura e sem detalhe.
- [ ] Nos slots de menu: a comida parece comida, sem brilho plástico e sem textura derretida.
- [ ] Nenhuma pizza redonda inteira vista de cima.
- [ ] Colocando as 14 lado a lado, parecem o mesmo restaurante na mesma noite.

O último item é o mais importante e o mais fácil de esquecer: coerência entre as imagens vale mais do que a qualidade de qualquer uma delas isolada.
