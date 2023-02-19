{ pkgs, config, inputs, ... }: {
  imports = [
    # Importar módulo NixOS do home-manager
    inputs.home-manager.nixosModules.home-manager
  ];

  # Criar seu usuário
  users.users.bob = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  # Sua configuração do home-manager vai aqui dentro
  home-manager.users.bob = {
    # Instalar pacotes
    home.packages = with pkgs; [ neovim kitty ];

    # Declarar arquivos que vão no ~/.config
    xdg.configFile = {
      # Colocar configurações do nvim em ~/.config/nvim
      "nvim".source = ./dots/.config/nvim;
      # Colocar configurações do kitty em ~/.config/kitty
      "kitty".source = ./dots/.config/kitty;
    };

    home.stateVersion = "22.11";
  };

  system.stateVersion = "22.11";
}
