# 🎮 Galaga Arcade

Um jogo espacial retrô completo projetado especialmente para dispositivos móveis Android e navegadores desktop.

![Galaga Arcade](https://img.shields.io/badge/Game%20Type-Arcade%20Shooter-ff69b4)
![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20Desktop-brightgreen)
![License](https://img.shields.io/badge/License-MIT-blue)

## 🚀 Características

- ✈️ **Controle Suave** - Movimento fluido da nave com tiro contínuo
- 👾 **Inimigos Inteligentes** - Padrões de ataque em formação estilo Galaga clássico
- 💣 **Sistema de Colisão** - Detecção precisa de impactos
- 🎯 **Pontuação Dinâmica** - Ganhe pontos destruindo inimigos
- ⭐ **Múltiplas Fases** - Dificuldade progressiva com 10 níveis
- 📱 **Responsivo** - Otimizado para móvel (touch) e desktop (teclado/mouse)
- 🏆 **Sistema de Recordes** - Salva pontuação máxima em localStorage
- 🎨 **Gráficos Retrô** - Estilo pixelado autêntico
- 🔊 **Efeitos Sonoros** - Áudio arcade imersivo
- ⚡ **Performance** - 60 FPS em todos os dispositivos

## 📋 Requisitos

- Navegador moderno com suporte a HTML5 Canvas
- JavaScript habilitado
- Tela sensível ao toque (para dispositivos móveis)

## 🎮 Como Jogar

### Desktop 🖥️
- **Seta Esquerda/Direita** - Mover nave
- **Espaço** - Atirar
- **P** - Pausar/Retomar
- **R** - Reiniciar jogo

### Móvel 📱 (Touch)
- **Deslizar para esquerda/direita** - Mover nave
- **Toque na tela inferior** - Atirar
- **Duplo toque** - Pausar/Retomar

## 📂 Estrutura do Projeto

```
Wegah-Galaga-Arcade/
├── index.html              # Página principal
├── styles/
│   └── main.css           # Estilos do jogo
├── js/
│   ├── game.js            # Lógica principal do jogo
│   ├── player.js          # Controle da nave do jogador
│   ├── enemies.js         # Sistema de inimigos
│   ├── bullets.js         # Sistema de projéteis
│   ├── particles.js       # Sistema de partículas
│   ├── gamestate.js       # Gerenciador de estado
│   ├── audio.js           # Sistema de áudio
│   └── utils.js           # Funções utilitárias
├── LICENSE                # Licença MIT
├── README.md              # Este arquivo
└── CONTRIBUTING.md        # Guia de contribuição
```

## 🏗️ Arquitetura

### Componentes Principais

1. **Game Engine** - Gerencia o loop de jogo, renderização e atualização de 60 FPS
2. **Player** - Controla a nave do jogador, movimentação e disparo de projéteis
3. **Enemies** - Sistema de inimigos com IA e padrões de ataque em formação
4. **Bullets** - Gerencia projéteis do jogador e projéteis dos inimigos
5. **Particles** - Sistema de efeitos visuais (explosões, centelhas)
6. **GameState** - Controla estado do jogo (ativo, pausado, game over)
7. **Audio** - Gerencia efeitos sonoros e música de fundo

## 🎯 Mecânicas do Jogo

### Fases
- Cada fase aumenta a velocidade e quantidade de inimigos
- Boss aparece a cada 5 fases
- Multiplicador de pontos aumenta com cada fase
- Total de 10 fases progressivas

### Pontuação
- Inimigo normal: 10 pontos
- Inimigo forte: 25 pontos
- Boss: 500 pontos
- Bonus por vida restante: 100 pontos por vida

### Dificuldade
- Velocidade aumenta progressivamente
- Novos padrões de ataque em cada fase
- Quantidade de inimigos aumenta
- Intervalos de ataque diminuem

## 📱 Compatibilidade

- ✅ Chrome (Desktop/Android)
- ✅ Firefox (Desktop/Android)
- ✅ Safari (Desktop/iOS)
- ✅ Edge (Desktop)
- ✅ Opera (Desktop/Android)
- ✅ Samsung Internet (Android)

## 🚀 Como Usar

### Opção 1: Abrir diretamente no navegador
1. Clone o repositório:
```bash
git clone https://github.com/torsyvet1-cloud/Wegah-Galaga-Arcade.git
cd Wegah-Galaga-Arcade
```

2. Abra `index.html` no navegador

### Opção 2: Usar servidor local (Recomendado)
```bash
# Python 3
python -m http.server 8000

# Python 2
python -m SimpleHTTPServer 8000

# Node.js (com http-server)
npx http-server
```

Depois acesse: `http://localhost:8000`

### Opção 3: Deploy online
- GitHub Pages
- Netlify
- Vercel
- Firebase Hosting

## 🎨 Personalização

### Cores
Edite as variáveis CSS em `styles/main.css`:
```css
--color-player: #00ff00;
--color-enemy: #ff00ff;
--color-bullet: #ffff00;
--color-bg: #000000;
```

### Velocidades
Edite as constantes em `js/game.js`:
```javascript
const PLAYER_SPEED = 5;
const BULLET_SPEED = 7;
const ENEMY_SPEED_BASE = 1;
const ENEMY_FIRE_RATE = 0.01;
```

### Dificuldade
Ajuste em `js/enemies.js`:
```javascript
const ENEMY_COUNT_BASE = 8;
const LEVEL_MULTIPLIER = 1.5;
const BOSS_HEALTH = 5;
```

## 📊 Sistema de Pontuação

```
Inimigo Comum      → 10 pontos
Inimigo Forte      → 25 pontos
Boss               → 500 pontos
Bonus de Vidas     → 100 pontos por vida
Multiplicador      → Aumenta com o nível
```

## 🎮 Estados do Jogo

- **MENU** - Tela inicial aguardando início
- **PLAYING** - Jogo em andamento
- **PAUSED** - Jogo pausado
- **LEVEL_UP** - Transição entre níveis
- **GAME_OVER** - Jogo finalizado

## 🐛 Bugs Conhecidos

Nenhum no momento! Se encontrar algum, reporte na seção [Issues](https://github.com/torsyvet1-cloud/Wegah-Galaga-Arcade/issues).

## 📈 Próximas Melhorias

- [ ] Sistema de power-ups (escudo, tiro duplo, velocidade)
- [ ] Efeitos de partículas melhorados
- [ ] Leaderboard online com firebase
- [ ] Temas alternativos (neon, escuro, cyberpunk)
- [ ] Modo multiplayer local
- [ ] Achievements e badges
- [ ] Configurações de dificuldade
- [ ] Tutorial interativo
- [ ] Animações de transição

## 📄 Licença

Este projeto está licenciado sob a Licença MIT - veja o arquivo [LICENSE](LICENSE) para detalhes.

## 👨‍💻 Autor

Desenvolvido com ❤️ por **Wegah**

## 🙏 Créditos

- Inspirado no clássico Galaga (1981) da Namco
- Sprites inspirados em arcade retrô clássico
- Fontes: Press Start 2P (Cody "Cody" Boisclair)
- Comunidade de desenvolvimento de games

---

**Aproveite o jogo! 🎮✨**