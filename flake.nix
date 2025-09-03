{
  description = "Custom nixpkgs for OSI";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  };

  outputs =
    { self, nixpkgs,  ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      overlays.default = final: prev: rec {
        dev-env = prev.callPackage ./pkgs/dev-env{ }; 
        hello-nix = prev.callPackage ./pkgs/hello-nix { }; 
        petsc = prev.callPackage ./pkgs/petsc { };
        petsc-project = prev.callPackage ./pkgs/petsc-project { };
        petscrc-update = prev.callPackage ./pkgs/petscrc-update { };
        waybar-weather = prev.callPackage ./pkgs/waybar-weather { };

        python3 = prev.python312.override {
          packageOverrides = py-final: _: rec {
	    cppimport = py-final.callPackage ./pkgs/cppimport { };
            #mpi4py = py-final.callPackage ./pkgs/mpi4py { };
            #petsc4py = py-final.callPackage ./pkgs/petsc4py { inherit petsc; };
          };
        };
    };

    packages.${system} = rec {
      cppimport = pkgs.python312Packages.callPackage ./pkgs/cppimport { };
      dev-env = pkgs.callPackage ./pkgs/dev-env { };
      hello-nix = pkgs.callPackage ./pkgs/hello-nix { }; 
      mpi4py = pkgs.python3Packages.callPackage ./pkgs/mpi4py { };
      petsc = pkgs.callPackage ./pkgs/petsc { };
      petsc-project = pkgs.callPackage ./pkgs/petsc-project { };
      petscrc-update = pkgs.callPackage ./pkgs/petscrc-update { };
      petsc4py = pkgs.python3Packages.callPackage ./pkgs/petsc4py {
        inherit petsc; };
      waybar-weather = pkgs.callPackage ./pkgs/waybar-weather { };
    };
  };
}
