{
  config,
  pkgs,
  lib,
  ...
}: {
  home = {
    stateVersion = "24.05";
    username = "hexfae";
    homeDirectory = "/home/hexfae";
    packages =
      (with pkgs; [
        helix
        (goofcord.overrideAttrs (finalAttrs: previousAttrs: {
          version = "1.6.0";
          src = let
            base = "https://github.com/Milkshiift/GoofCord/releases/download";
          in
            {
              x86_64-linux = fetchurl {
                url = "${base}/v${finalAttrs.version}/GoofCord-${finalAttrs.version}-linux-amd64.deb";
                hash = "sha256-knP2gFiGKWiSoEJyWm4qzvdgKHCRXkdLoNMb1pUqlZs=";
              };
            }
            .${stdenv.hostPlatform.system}
            or (throw "Unsupported system: ${stdenv.hostPlatform.system}");
        }))
        starship
        nushell
        # zoxide
        gnome-tweaks
        gnome-extension-manager
        resources
        gnome-terminal
        bacon
        # xdg-desktop-portal-gnome
        obs-studio
        gimp
        dolphin-emu
        lime3ds
        prismlauncher
        lutris
        blender
        yt-dlp
        ffmpeg
        tlrc
        nil
        alejandra
        amberol
        obsidian
        librewolf
      ])
      ++ (with pkgs.gnomeExtensions; [
        dash-to-dock
        blur-my-shell
        gsconnect
        pano
        appindicator
        vitals
      ]);

    sessionVariables = {
      GDK_BACKEND = "wayland,x11,*";
      QT_QPA_PLATFORM = "wayland;xcb";
      SDL_VIDEODRIVER = "wayland";
      CLUTTER_BACKEND = "wayland";
    };

    file.".cargo/config.toml".source = ./files/config.toml;
  };

  dconf = {
    enable = true;
    settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = with pkgs.gnomeExtensions; [
          blur-my-shell.extensionUuid
          dash-to-dock.extensionUuid
          pano.extensionUuid
          gsconnect.extensionUuid
          appindicator.extensionUuid
          vitals.extensionUuid
        ];
      };
      "org/gnome/desktop/interface" = {
        clock-show-seconds = true;
        show-battery-percentage = true;
      };
      "org/gnome/desktop/wm/preferences" = {
        button-layout = "close,minimize::";
      };
      "org/gnome/desktop/peripherals/mouse" = {
        accel-profile = "flat";
      };
      "org/gnome/desktop/privacy" = {
        remember-recent-files = false;
      };
      "org/gnome/mutter" = {
        edge-tiling = true;
        experimental-features = ["scale-monitor-framebuffer"];
        dynamic-workspaces = true;
      };
    };
  };

  xdg = {
    mime.enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = {
        "image/jpeg" = "org.gnome.Loupe.desktop";
        "image/png" = "org.gnome.Loupe.desktop";
      };
      associations.added = {
        "x-scheme-handler/sms" = "org.gnome.Shell.Extensions.GSConnect.desktop";
        "x-scheme-handler/tel" = "org.gnome.Shell.Extensions.GSConnect.desktop";
        "image/jpeg" = "org.gnome.Loupe.desktop";
        "image/png" = "org.gnome.Loupe.desktop";
      };
    };
    # portal = {
    #   enable = true;
    #   xdgOpenUsePortal = true;
    #   extraPortals = [
    #     pkgs.xdg-desktop-portal-gnome
    #   ];
    #   config.common.default = "*";
    # };
    userDirs = {
      enable = true;
      createDirectories = true;
      # desktop = "${config.home.homeDirectory}/des";
      desktop = null;
      publicShare = null;
      templates = null;
      documents = "${config.home.homeDirectory}/dox";
      download = "${config.home.homeDirectory}/dwn";
      music = "${config.home.homeDirectory}/mus";
      pictures = "${config.home.homeDirectory}/pix";
      videos = "${config.home.homeDirectory}/vid";
    };
  };

  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };
  };

  stylix = {
    enable = true;
    image = ./keys.png;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/onedark.yaml";
    cursor = {
      package = pkgs.posy-cursors;
      name = "Posy_Cursor_Black";
    };
    fonts = {
      serif = {
        package = pkgs.roboto-slab;
        name = "Roboto Slab";
      };
      sansSerif = {
        package = pkgs.roboto;
        name = "Roboto";
      };
      monospace = {
        package = pkgs.maple-mono-NF;
        name = "Maple Mono NF";
      };
      emoji = {
        package = pkgs.twitter-color-emoji;
        name = "Twitter Color Emoji";
      };
    };
  };

  programs = {
    home-manager.enable = true;
    firefox.enable = true;
    fzf.enable = true;
    zoxide = {
      enable = true;
    };
    starship = {
      enable = true;
      settings = {
        format = lib.concatStrings [
          "$username"
          "$hostname"
          "$shlvl"
          "$kubernetes"
          "$directory"
          "$vcsh"
          "$git_branch"
          "$git_commit"
          "$git_state"
          "$git_metrics"
          "$git_status"
          "$hg_branch"
          "$docker_context"
          "$package"
          "$cmake"
          "$dart"
          "$deno"
          "$dotnet"
          "$elixir"
          "$elm"
          "$erlang"
          "$golang"
          "$helm"
          "$java"
          "$julia"
          "$kotlin"
          "$nim"
          "$nodejs"
          "$ocaml"
          "$perl"
          "$php"
          "$purescript"
          "$python"
          "$red"
          "$ruby"
          "$rust"
          "$scala"
          "$swift"
          "$terraform"
          "$vlang"
          "$vagrant"
          "$zig"
          "$nix_shell"
          "$conda"
          "$memory_usage"
          "$aws"
          "$gcloud"
          "$openstack"
          "$env_var"
          "$crystal"
          "$custom"
          "$cmd_duration"
          "$time"
          "$line_break"
          "$lua"
          "$jobs"
          "$battery"
          "$status"
          "$shell"
          "$character"
        ];

        character = {
          success_symbol = "[❯](green)";
          error_symbol = "[❯](green)";
        };

        cmd_duration = {
          min_time = 1000;
          format = "in [$duration](bold yellow) ";
        };

        directory = {
          read_only = " ";
          style = "bold white";
          read_only_style = "bold yellow";
          truncation_length = 8;
          truncation_symbol = "…/";
        };

        username = {
          format = "[\\[](bold red)[$user](bold yellow)";
          disabled = false;
          show_always = true;
        };

        hostname = {
          ssh_only = false;
          format = "[@](bold green)[$hostname](bold blue)[\\]](bold purple) ";
          trim_at = ".companyname.com";
          disabled = false;
        };

        time = {
          disabled = false;
          format = "[\\[$time\\]](bold white)";
          time_format = "%T";
          utc_time_offset = "+1";
        };

        aws = {
          symbol = "  ";
        };

        conda = {
          symbol = " ";
        };

        dart = {
          symbol = " ";
        };

        docker_context = {
          symbol = " ";
        };

        elixir = {
          symbol = " ";
        };

        elm = {
          symbol = " ";
        };

        git_branch = {
          symbol = " ";
        };

        golang = {
          symbol = " ";
        };

        hg_branch = {
          symbol = " ";
        };

        java = {
          symbol = " ";
        };

        julia = {
          symbol = " ";
        };

        memory_usage = {
          symbol = " ";
        };

        nim = {
          symbol = " ";
        };

        nix_shell = {
          symbol = " ";
        };

        package = {
          symbol = " ";
        };

        perl = {
          symbol = " ";
        };

        php = {
          symbol = " ";
        };

        python = {
          symbol = " ";
        };

        ruby = {
          symbol = " ";
        };

        rust = {
          symbol = " ";
        };

        scala = {
          symbol = " ";
        };

        shlvl = {
          symbol = " ";
        };

        swift = {
          symbol = "ﯣ ";
        };
      };
    };

    git = {
      enable = true;
      userName = "hexfae";
      userEmail = "hexfae@proton.me";
    };

    zellij = {
      enable = true;
      settings = {
        default_shell = "nu";
        mouse_mode = false;
        ui = {
          pane_frames = {
            rounded_corners = true;
            hide_session_name = true;
          };
        };
      };
    };

    helix = {
      enable = true;
      defaultEditor = true;
      languages = {
        language = [
          {
            name = "rust";
            auto-format = true;
          }
          {
            name = "nix";
            auto-format = true;
            formatter.command = "${pkgs.alejandra}/bin/alejandra";
          }
        ];
        language-server.rust-analyzer.config.check = {
          command = "clippy";
        };
      };
      settings = {
        editor = {
          scrolloff = 10;
          mouse = false;
          middle-click-paste = false;
          shell = ["nu" "'--commands'"];
          line-number = "relative";
          gutters = ["diagnostics" "line-numbers" "diff"];
          idle-timeout = 0;
          preview-completion-insert = false;
          completion-trigger-len = 1;
          bufferline = "multiple";
          color-modes = true;
          statusline = {
            left = ["mode" "file-modification-indicator" "read-only-indicator" "spinner"];
            center = ["file-name"];
            right = ["primary-selection-length" "workspace-diagnostics" "diagnostics" "position"];
            separator = "│";
            mode.normal = "N";
            mode.insert = "I";
            mode.select = "S";
          };
          lsp = {
            display-messages = true;
            display-inlay-hints = true;
          };
          cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "underline";
          };
          # auto-pairs = {
          #   '(' = ')';
          #   '{' = '}';
          #   '[' = ']';
          #   '"' = '"';
          #   '`' = '`';
          #   '<' = '>';
          # };
          indent-guides = {
            render = true;
            character = "▏";
            skip-levels = 1;
          };
          soft-wrap = {
            enable = true;
          };
        };
      };
    };

    nushell = {
      enable = true;
      configFile.source = ./files/config.nu;
      envFile.source = ./files/env.nu;
      environmentVariables = {
        EDITOR = "hx";
        VISUAL = "hx";
      };
    };
  };
}
