{ pkgs, config, inputs, ... }: {
  imports = [
    # Importar módulo NixOS do home-manager
    inputs.home-manager.nixosModules.home-manager
  ];

  # Criar seu usuário
  users.users.bob = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    password = "1234";
  };

  # Sua configuração do home-manager vai aqui dentro
  home-manager.users.bob = { config, ... }:
  let inherit (config.lib.file) mkOutOfStoreSymlink;
  in
  {
    # Instalar pacotes
    home.packages = with pkgs; [ neovim kitty git ];

    # Declarar arquivos que vão no ~/.config
    xdg.configFile = {
      # Fazer links simbólicos pra caminhos hardcodados
      "nvim".source = mkOutOfStoreSymlink "/home/bob/dots/.config/nvim";
      "kitty".source = mkOutOfStoreSymlink "/home/bob/dots/.config/kitty";
    };

    home.stateVersion = "22.11";
  };

  system.stateVersion = "22.11";
}
