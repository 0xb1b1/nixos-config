{ system, nixpkgs }:

let
  pkgs = nixpkgs.legacyPackages.${system};

in
pkgs.mkShell {
  name = "installation-shell";
  buildInputs = with pkgs; [ wget curl s-tar ];
}
