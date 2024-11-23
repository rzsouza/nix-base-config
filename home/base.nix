{

  home.packages = with pkgs; [
    ripgrep
    git
    htop
    killall
    tldr
    chromium
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
      package = pkgs.chromium;
    };
  };

  home.file.".config/google-chrome/policies/managed/my_policy.json".text = builtins.toJSON {
    ExtensionSettings = {
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" = {  # uBlock Origin
        "installation_mode" = "force_installed";
        "update_url" = "https://clients2.google.com/service/update2/crx";
      };
      "eimadpbcbfnmbkopoojfekhnkhdbieeh" = {  # Dark Reader
        "installation_mode" = "force_installed";
        "update_url" = "https://clients2.google.com/service/update2/crx";
      };
      "nngceckbapebfimnlniiiahkandclblb" = {  # Bitwarden
        "installation_mode" = "force_installed";
        "update_url" = "https://clients2.google.com/service/update2/crx";
      };
      "bmanlajnpdncmhfkiccmbgeocgbncfln" = {  # Slinky Elegant Theme
        "installation_mode" = "force_installed";
        "update_url" = "https://clients2.google.com/service/update2/crx";
      };
    };
    RestoreOnStartup = 1;
    DefaultBrowserSettingEnabled = false;
    BookmarkBarEnabled = false;
    SpellcheckEnabled = true;
    SpellcheckLanguage = [ "en-NZ" "en-AU" "en-GB" "en-US" "pt-BR" ];
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
}
