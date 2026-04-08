{
  description = "Example project demonstrating Dependabot for Nix flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # Pinned to a commit with hello 2.12.2 — Dependabot will open a PR
    # to update this, picking up hello 2.12.3+ along with other changes.
    # To reset the lock file to this older commit, run:
    #   nix flake update nixpkgs --override-input nixpkgs github:NixOS/nixpkgs/74db1477155674a4c3e18de28628f24eba310ebf
  };

  outputs = { self, nixpkgs }:
    let
      systems = [
        "aarch64-darwin"
        "x86_64-darwin"
        "x86_64-linux"
        "aarch64-linux"
      ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems f;
    in
    {
      packages = forAllSystems (system: {
        default = nixpkgs.legacyPackages.${system}.hello;
      });
    };
}
