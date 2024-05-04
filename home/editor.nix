{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      cmp-buffer
      cmp-vsnip
      cmp-nvim-lsp
      gitsigns-nvim
      nvim-cmp
      nvim-lspconfig
      nvim-tree-lua
      nvim-treesitter.withAllGrammars
      nvim-web-devicons
      plenary-nvim
      telescope-nvim
      tokyonight-nvim
      vim-vsnip
    ];
    extraLuaConfig = ''
      vim.g.mapleader = " " -- Set leader key
      vim.g.maplocalleader = " " -- Set local leader key
      vim.o.completeopt = "menuone,noselect" -- Have a better completion experience
      vim.opt.breakindent = true -- Keep indentation for line breaks
      vim.opt.clipboard = "unnamedplus" -- Use system clipboard
      vim.opt.ignorecase = true -- Ignore case
      vim.opt.inccommand = "split" -- Preview for find-replace command
      vim.opt.laststatus = 3 -- Global status line
      vim.opt.number = true -- Show line numbers
      vim.opt.relativenumber = true -- Relative line numbers
      vim.opt.shortmess = "I" -- Disable welcome screen
      vim.opt.smartcase = true -- Do not ignore case with capitals
      vim.opt.spelllang = "en_us" -- Set default spell language
      vim.opt.splitbelow = true -- Put new windows below current
      vim.opt.splitright = true -- Put new windows right of current
      vim.opt.termguicolors = true -- True color support
      vim.opt.tabstop = 4 -- Set tab width to 4 spaces
      vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true }) -- Reserve space for keymaps

      require('gitsigns').setup()

      local cmp = require('cmp')
      cmp.setup({
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
          end,
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'vsnip' },
        }, {
          { name = 'buffer' },
        })
      })

      local lspconfig = require('lspconfig')
      lspconfig.gopls.setup({})
      lspconfig.marksman.setup({})
      lspconfig.nil_ls.setup({})
      lspconfig.svelte.setup({})
      lspconfig.tsserver.setup({})
      lspconfig.yamlls.setup({})
      lspconfig.rust_analyzer.setup({})
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
          local opts = { buffer = ev.buf }
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set({ 'n', 'v' }, '<leader>a', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', '<leader>k', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, opts)
          vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
          end, opts)
        end,
      })

      require("nvim-tree").setup()
      vim.keymap.set('n', '<leader>t', '<Cmd>NvimTreeFindFileToggle<CR>', {})

      local telescope_builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>f', telescope_builtin.find_files, {})
      vim.keymap.set('n', '<leader>/', telescope_builtin.live_grep, {})

      vim.cmd[[colorscheme tokyonight-night]]
    '';
  };

  programs.helix = {
    enable = true;
    settings = {
      theme = "tokyonight";
      editor = {
        line-number = "relative";
        soft-wrap.enable = true;
        cursor-shape.insert = "bar";
        file-picker.hidden = false;
      };
    };
    languages = {
      language-server = {
        gopls = { config."formatting.gofumpt" = true; };
      };
      language = [
        { name = "bash"; auto-format = true; formatter = { command = "${pkgs.shfmt}/bin/shfmt"; }; }
        { name = "css"; formatter = { command = "${pkgs.nodePackages.prettier}/bin/prettier"; args = [ "--parser" "css" ]; }; }
        { name = "html"; formatter = { command = "${pkgs.nodePackages.prettier}/bin/prettier"; args = [ "--parser" "html" ]; }; }
        { name = "javascript"; auto-format = true; formatter = { command = "${pkgs.nodePackages.prettier}/bin/prettier"; args = [ "--parser" "typescript" ]; }; }
        { name = "json"; formatter = { command = "${pkgs.nodePackages.prettier}/bin/prettier"; args = [ "--parser" "json" ]; }; }
        { name = "markdown"; auto-format = true; formatter = { command = "${pkgs.nodePackages.prettier}/bin/prettier"; args = [ "--parser" "markdown" ]; }; }
        { name = "nix"; auto-format = true; formatter = { command = "${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt"; }; }
        { name = "python"; auto-format = true; formatter = { command = "${pkgs.ruff}/bin/ruff"; args = [ "format" "-" ]; }; }
        { name = "svelte"; auto-format = true; formatter = { command = "${pkgs.nodePackages.prettier}/bin/prettier"; args = [ "--parser" "svelte" ]; }; }
        { name = "typescript"; auto-format = true; formatter = { command = "${pkgs.nodePackages.prettier}/bin/prettier"; args = [ "--parser" "typescript" ]; }; }
        { name = "yaml"; auto-format = true; formatter = { command = "${pkgs.nodePackages.prettier}/bin/prettier"; args = [ "--parser" "yaml" ]; }; }
      ];
    };
  };

  home.packages = with pkgs; [
    # Language servers
    docker-compose-language-service
    gopls
    golangci-lint-langserver
    marksman
    nil
    nodePackages.bash-language-server
    nodePackages.dockerfile-language-server-nodejs
    nodePackages.svelte-language-server
    nodePackages.typescript-language-server
    nodePackages.yaml-language-server
    python311Packages.python-lsp-server
    rust-analyzer
    terraform-ls
    vscode-langservers-extracted

    # Debuggers
    delve
    lldb

    # Formatters
    nodePackages.prettier
    rustfmt
  ];
}
