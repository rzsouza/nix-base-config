{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    htop
    killall
    tldr
    neovim
    zsh
    lazygit
    ripgrep
    fzf
    starship
  ];
   
  programs = {
    starship = {
      enable = true;
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;

      defaultKeymap = "viins";

      history = { 
        append = true;
        size = 10000;
      };

      shellAliases = {
        gl = "git pull";
	gp = "git push";
	gst = "git status";
	vim = "nvim";
	vi = "nvim";
	nfu = "nix flake update";
	cd = "z";
      };
    };

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

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
    
    chromium = {
      enable = true;
      
      extensions = [
        "cjpalhdlnbpafiamejdnhcphjbkeiagm" # uBlock Origin
        "eimadpbcbfnmbkopoojfekhnkhdbieeh" # Dark Reader
        "nngceckbapebfimnlniiiahkandclblb" # Bitwarden
        "bmanlajnpdncmhfkiccmbgeocgbncfln" # Slinky Elegant Theme
      ];
      
      commandLineArgs = [
        "--restore-last-session"
        "--enable-spell-checking"
        "--spelling-languages=en-NZ,en-GB,pt-BR"
      ];
    };
  };  

}
