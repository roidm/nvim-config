[![Preview](https://github.com/roidm/nvim-config/blob/main/pics/pic.png?raw=true)](https://github.com/roidm/nvim-config)

# 🚀 Configuración Personal de Neovim

Una configuración moderna, modular y eficiente de Neovim, optimizada para el desarrollo y construida con LazyVim.

## ✨ Características

### 🎨 **Interfaz**

- **Colorscheme**: Tokyo Night para una experiencia visual moderna y elegante
- **Statusline**: Lualine con iconos de nvim-web-devicons
- **Dashboard**: Pantalla de inicio personalizada
- **Noice**: Interfaz de mensajes moderna y mejorada

### 🔧 **Funcionalidad Core**

- **Gestor de paquetes**: LazyVim para manejo optimizado de plugins
- **Autocompletado**: Blink para completado ultrarrápido
- **LSP**: Mason y nvim-lspconfig para soporte robusto de lenguajes
- **Formateo**: Conform para formateo automático de código
- **Treesitter**: Syntax highlighting avanzado y análisis de código

### 🗂️ **Navegación y Búsqueda**

- **Búsqueda difusa**: Telescope para búsqueda rápida de archivos y contenido
- **Navegación rápida**: Flash para saltos rápidos por el texto
- **Diagnósticos**: Trouble para visualización de errores y warnings

### 🔄 **Control de versiones**

- **Git**: Integración completa con comandos Git nativos
- **Indicadores**: Cambios visuales en tiempo real

### 💡 **Productividad**

- **Snippets**: Soporte de snippets integrado
- **Comentarios**: Sistema de comentarios inteligente
- **Which-key**: Ayuda contextual para atajos de teclado
- **Snacks**: Utilidades adicionales para mejorar la experiencia
- **DAP**: Debugging integrado para múltiples lenguajes

## 📁 Estructura del proyecto

```
~/.config/nvim/
├── init.lua                 # Archivo de entrada principal
├── lua/
│   ├── config/              # Configuraciones principales
│   │   ├── autocommands.lua # Autocomandos personalizados
│   │   ├── icons.lua        # Iconos y símbolos
│   │   ├── keymaps.lua      # Mapeos de teclas personalizados
│   │   ├── options.lua      # Opciones generales de Neovim
│   │   ├── path.lua         # Configuración de rutas
│   │   ├── picker.lua       # Configuración del selector
│   │   └── util.lua         # Utilidades y funciones helper
│   ├── core/                # Núcleo de la configuración
│   │   └── lazy.lua         # Configuración de Lazy.nvim
│   └── plugins/             # Configuración de plugins
│       ├── blink.lua        # Autocompletado con Blink
│       ├── colorscheme.lua  # Tema Tokyo Night
│       ├── comments.lua     # Sistema de comentarios
│       ├── conform.lua      # Formateo con Conform
│       ├── dap.lua          # Debug Adapter Protocol
│       ├── dashboard.lua    # Pantalla de inicio
│       ├── flash.lua        # Navegación rápida
│       ├── formatting.lua   # Configuración de formateo
│       ├── lazydev.lua      # Desarrollo con Lazy
│       ├── lsp.lua          # Configuración LSP
│       ├── lualine.lua      # Barra de estado
│       ├── noice.lua        # Interfaz de mensajes
│       ├── snacks.lua       # Utilidades adicionales
│       ├── telescope.lua    # Búsqueda difusa
│       ├── treesitter.lua   # Syntax highlighting
│       ├── trouble.lua      # Diagnósticos y quickfix
│       └── wk.lua           # Which-key
```

## ⚡ Instalación rápida

### Requisitos previos

- Neovim >= 0.9.0
- Git
- Node.js (para algunos LSP servers)
- Un terminal con soporte para colores verdaderos
- [Nerd Font](https://www.nerdfonts.com/) para iconos

### Instalación

1. **Respalda tu configuración actual** (si existe):

   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```

2. **Clona el repositorio**:

   ```bash
   git clone https://github.com/roidm/nvim-config ~/.config/nvim
   ```

3. **Inicia Neovim**:

   ```bash
   nvim
   ```

4. **¡Listo!** LazyVim se encargará automáticamente de instalar todos los plugins necesarios.

## 🎯 Atajos de teclado principales

| Atajo        | Modo          | Descripción            |
| ------------ | ------------- | ---------------------- |
| `<leader>ff` | Normal        | Buscar archivos        |
| `<leader>fg` | Normal        | Búsqueda global (grep) |
| `<leader>fb` | Normal        | Buscar en buffers      |
| `<leader>gg` | Normal        | Abrir Lazygit          |
| `<leader>e`  | Normal        | Toggle explorador      |
| `<leader>/`  | Normal/Visual | Comentar líneas        |
| `gd`         | Normal        | Ir a definición        |
| `gr`         | Normal        | Ver referencias        |
| `K`          | Normal        | Hover información      |

> 💡 **Tip**: Usa `<leader>` (espacio por defecto) seguido de cualquier tecla para ver todas las opciones disponibles gracias a which-key.

### Añadir nuevos plugins

Crea un nuevo archivo en `lua/plugins/` siguiendo la convención de nombres.

### Modificar configuraciones

- **Keymaps**: `lua/config/keymaps.lua`
- **Opciones**: `lua/config/options.lua`
- **Autocomandos**: `lua/config/autocommands.lua`

## 📊 Plugins incluidos

<details>
<summary>Ver lista completa de plugins</summary>

- **LazyVim**: Gestor de plugins y configuración base
- **Tokyo Night**: Tema de colores moderno
- **Blink**: Autocompletado ultrarrápido
- **Mason**: Gestor de LSP, DAP, linters y formatters
- **nvim-lspconfig**: Configuración LSP
- **Conform**: Formateo de código
- **Telescope**: Búsqueda difusa
- **Flash**: Navegación rápida por el texto
- **Trouble**: Diagnósticos y quickfix
- **Treesitter**: Highlighting y parsing
- **Lualine**: Barra de estado
- **Which-key**: Ayuda de atajos
- **Dashboard**: Pantalla de inicio
- **Noice**: Interfaz de comandos/mensajes
- **Snacks**: Utilidades adicionales
- **DAP**: Debug Adapter Protocol

</details>

## 📝 Licencia

Este proyecto está bajo la licencia MIT. Consulta el archivo `LICENSE` para más detalles.

## 🙏 Agradecimientos

- A la increíble comunidad de Neovim por sus plugins
- A los desarrolladores de LazyVim por su gestor de paquetes intuitivo
- A todos los mantenedores de los plugins incluidos

---

**¡Disfruta programando con Neovim!** 🎉
