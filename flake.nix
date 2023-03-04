{
  description = "qmk build";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [];
      systems = ["x86_64-linux"];
      perSystem = {
        config,
        self',
        inputs',
        pkgs,
        system,
        ...
      }: let
        cwd = builtins.toString ./.;
        shellHook = ''
          export HOME=$(pwd)
        '';
      in {
        formatter = pkgs.alejandra;
        devShells.default = pkgs.mkShell {
          inherit shellHook;
          buildInputs = [
            pkgs.qmk
          ];
        };
      };
    };
}
