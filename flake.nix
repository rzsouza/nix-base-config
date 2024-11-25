{
  description = "Base development configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager } : { 
    homeManagerModules.base = { config, pkgs, ... }: {
      home.packages = with pkgs; [
        htop
        killall
        chromium
        tldr
        neovim
        zsh
      ];
  
      programs = {
        git = {
          enable = true;
          
          extraConfig = {
            init.defaultBranch = "main";
            pull.rebase = true;
            rebase.autoStash = true;
            core.editor = "nvim";
            help.format = "html";
            core.pager = "less --LONG-PROMPT --tabs=3 --quit-at-eof --quit-if-one-screen --tilde --jump-target=3 --ignore-case --status-column";
          };
        };
  
        chromium = {
          enable = true;
  
          extensions = [
            "cjpalhdlnbpafiamejdnhcphjbkeiagm" # uBlock Origin
            "eimadpbcbfnmbkopoojfekhnkhdbieeh" # Dark Reader
            "nngceckbapebfimnlniiiahkandclblb" # Bitwarden
            "bmanlajnpdncmhfkiccmbgeocgbncfln" # Slinky Elegant Theme
          ];
  
          commandLineAgs = [
            "--restore-last-session"
            "--enable-spell-checking"
            "--spelling-languages=en-NZ,en-GB,pt-BR"
          ];
        };
      };  
    };
  };
}
