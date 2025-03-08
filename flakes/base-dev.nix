{ config, pkgs, ... }:
let
  # Create a custom Chromium build with all necessary media features
  myChromium = pkgs.chromium.override {
    enableWideVine = true;
  };
in
{
  home.packages = with pkgs; [
    htop
    killall
    tldr
    neovim
    lazygit
    ripgrep
    starship
    nerd-fonts.jetbrains-mono
    asdf-vm
#    widevine-cdm # for DRM content like Netflix 
  ];

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    }

    nushell = {
      enable = true;

      extraConfig = ''
        $env.config = {
	  show_banner: false
	}

	def git_current_branch [] {
          git branch --show-current
        }

	$env.ASDF_DIR = "${pkgs.asdf-vm}/share/asdf-vm"
        source ${pkgs.asdf-vm}/share/asdf-vm/asdf.nu
      '';

      shellAliases = {
        ga = "git add --all";
	gco = "git checkout";
	gcb = "git checkout -b";
	gcm = "git checkout main";
        gc = "git commit --verbose";
	gcam = "git commit --all --message";
        gd = "git diff";
	gdca = "git diff --cached";
	gf = "git fetch";
        gl = "git pull";
	gp = "git push";
        gpsup = "git push --set-upstream origin (git_current_branch)";
        gst = "git status";
	gm = "git merge";
	gmom = "git merge origin/main";
	gma = "git merge --abort";
	glog = "git log --oneline --decorate --graph";
	gstl = "git stash list";
	gstp = "git stash pop";
	gsta = "git stash push";
	vim = "nvim";
	vi = "nvim";
	nfu = "nix flake update";
	cd = "z";
      };
    };

    starship = {
      enable = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      autosuggestion.enable = true;

      defaultKeymap = "viins";

      history = { 
        append = true;
        size = 10000;
      };

      initExtra = ''
        . ${pkgs.asdf-vm}/share/asdf-vm/asdf.sh
      '';

      shellAliases = {
        ga = "git add --all";
	gco = "git checkout";
	gcb = "git checkout -b";
	gcm = "git checkout main";
        gc = "git commit --verbose";
	gcam = "git commit --all --message";
        gd = "git diff";
	gdca = "git diff --cached";
	gf = "git fetch";
        gl = "git pull";
	gp = "git push";
        gpsup = "git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)";
        gst = "git status";
	gm = "git merge";
	gmom = "git merge origin/main";
	gma = "git merge --abort";
	glog = "git log --oneline --decorate --graph";
	gstl = "git stash list";
	gstp = "git stash pop";
	gsta = "git stash push";
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
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    carapace = {
      enable = true;
      enableNushellIntegration = true;
    };

    wezterm = {
      enable = true;

      extraConfig = ''
        local wezterm = require 'wezterm'
        local config = wezterm.config_builder()

        config.default_prog = { 'nu' } 
        config.use_fancy_tab_bar = false
        config.hide_tab_bar_if_only_one_tab = true 
        config.window_decorations = "TITLE | RESIZE"
        config.native_macos_fullscreen_mode = true
        config.enable_wayland = false;
        config.front_end = "WebGpu"
        config.color_scheme = "Catppuccin Mocha"
        config.font = wezterm.font("JetBrains Mono")

        return config
      '';
    };

    chromium = {
      enable = true;
      package = myChromium;

      extensions = [
        "cjpalhdlnbpafiamejdnhcphjbkeiagm" # uBlock Origin
        "eimadpbcbfnmbkopoojfekhnkhdbieeh" # Dark Reader
        "nngceckbapebfimnlniiiahkandclblb" # Bitwarden
        "bmanlajnpdncmhfkiccmbgeocgbncfln" # Slinky Elegant Theme
	"hkgfoiooedgoejojocmhlaklaeopbecg" # Picture-in-Picture by Google
      ];
      
      commandLineArgs = [
        "--restore-last-session"
        "--enable-spell-checking"
        "--spelling-languages=en-NZ,en-GB,pt-BR"
        "--enable-features=EnableWidevineCdm"
      ];
    };
  };  
}
