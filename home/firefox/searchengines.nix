{
  default = "DuckDuckGo";

  engines = {
    "Nix Packages" = {
      urls = [
        {
          template = "https://search.nixos.org/packages";
          params = [
            {
              name = "type";
              value = "packages";
            }
            {
              name = "query";
              value = "{searchTerms}";
            }
          ];
        }
      ];

      iconUpdateURL = "https://nixos.org/favicon.png";
      updateInterval = 24 * 60 * 60 * 1000; # every day
      icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
      definedAliases = ["!np"];
    };
    "Nix Options" = {
      urls = [
        {
          template = "https://search.nixos.org/options";
          params = [
            {
              name = "query";
              value = "{searchTerms}";
            }
          ];
        }
      ];

      iconUpdateURL = "https://nixos.org/favicon.png";
      updateInterval = 24 * 60 * 60 * 1000; # every day
      icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
      definedAliases = ["!no"];
    };
    "NixOS Wiki" = {
      urls = [{template = "https://wiki.nixos.org/index.php?search={searchTerms}";}];
      iconUpdateURL = "https://wiki.nixos.org/favicon.png";
      updateInterval = 24 * 60 * 60 * 1000; # every day
      icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
      definedAliases = ["!nw"];
    };

    "Scryfall" = {
      urls = [
        {
          template = "https://www.scryfall.com/search";
          params = [
            {
              name = "q";
              value = "{searchTerms}";
            }
          ];
        }
      ];

      iconUpdateURL = "https://www.scryfall.com/favicon.ico";
      updateInterval = 24 * 60 * 60 * 1000; # every day
      definedAliases = ["!sc"];
    };

    # fuck fandom.com
    "Kill Six Billion Demons" = {
      urls = [
        {
          template = "https://antifandom.com/killsixbilliondemons/search";
          params = [
            {
              name = "q";
              value = "{searchTerms}";
            }
          ];
        }
      ];

      iconUpdateURL = "https://static.wikia.nocookie.net/killsixbilliondemons/images/4/4a/Site-favicon.ico";
      updateInterval = 24 * 60 * 60 * 1000; # every day
      definedAliases = ["!k6" "!k6bd"];
    };

    "Minecraft" = {
      urls = [
        {
          template = "https://minecraft.wiki/";
          params = [
            {
              name = "search";
              value = "{searchTerms}";
            }
          ];
        }
      ];

      iconUpdateURL = "https://minecraft.wiki/images/Wiki.png";
      updateInterval = 24 * 60 * 60 * 1000; # every day
      definedAliases = ["!mi" "!mine"];
    };
    "The Binding of Issac" = {
      urls = [
        {
          template = "https://bindingofisaacrebirth.wiki.gg/wiki/";
          params = [
            {
              name = "search";
              value = "{searchTerms}";
            }
          ];
        }
      ];

      iconUpdateURL = "https://bindingofisaacrebirth.wiki.gg/images/4/4a/Site-favicon.ico";
      updateInterval = 24 * 60 * 60 * 1000; # every day
      definedAliases = ["!tb" "!tboi" "!issac"];
    };
  };
}
