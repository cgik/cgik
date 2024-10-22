-- remappings
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)



-- packer plugins
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use ({
	  'rebelot/kanagawa.nvim',
	  as = 'kanagawa',
	  config = function()
		  vim.cmd.colorscheme('kanagawa')

		  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	  end
  })

  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.8',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  use {
	  'nvim-treesitter/nvim-treesitter',
	  run = function()
		  local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
		  ts_update()
	  end,
  }
end)
