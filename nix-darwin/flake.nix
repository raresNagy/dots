{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    #Declrative tap management
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
  };

  outputs = inputs@{
    self, nix-darwin, nixpkgs, nix-homebrew, homebrew-core, homebrew-cask
    }:
  let
    configuration = { pkgs, config, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = [
          pkgs.mkalias
          pkgs.neovim
          pkgs.alacritty
          pkgs.bitwarden-desktop
          pkgs.vscodium
          pkgs.librewolf
          # pkgs.orca-slicer
          pkgs.spotify
          pkgs.go
          pkgs.nodejs
          pkgs.zoxide
          pkgs.teams
          pkgs.qbittorrent
          pkgs.oh-my-posh
          pkgs.fzf
        ];

        homebrew = {
          enable = true;
          casks = [
            "iina"
            "the-unarchiver"
            "autodesk-fusion"
            "orcaslicer"
          ];
          onActivation.cleanup = "zap";
        };

        fonts.packages = [
          pkgs.nerd-fonts.jetbrains-mono
        ];

        system.activationScripts.application.text = let
          env = pkgs.buildEnv {
          name = "system-applications";
          paths = config.environment.systemPackages;
          pathsToLink = "/Applications";
        };
      in
          pkgs.lib.mkForce ''
          # Set up applications.
          echo "setting up /Applications..." >&2
          rm -rf /Applications/Nix\ Apps
          mkdir -p /Applications/Nix\ Apps
          find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
          while read -r src; do
            app_name=$(basename "$src")
            echo "copying $src" >&2
            ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
          done
        '';

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      system.primaryUser = "raresnagy";

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";

      #Allow unfree packages
      nixpkgs.config.allowUnfree = true;
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#Raress-MacBook-Air
    darwinConfigurations."Raress-MacBook-Air" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            # Install Homebrew under the default prefix
            enable = true;

            # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
            enableRosetta = true;

            # User owning the Homebrew prefix
            user = "raresnagy";

            # Automatically migrate existing Homebrew installations
            autoMigrate = true;
          };
        }
        ];
    };
  };
}
