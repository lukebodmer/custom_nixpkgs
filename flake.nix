{
  description = "Custom nixpkgs for OSI";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    { nixpkgs,  ... }:
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

        python312 = prev.python312.override {
          packageOverrides = py-final: _: rec {
	    chesscom = py-final.callPackage ./pkgs/chesscom { };
	    cppimport = py-final.callPackage ./pkgs/cppimport { };
	    mpld3 = py-final.callPackage ./pkgs/mpld3{ };
	    trame = py-final.callPackage ./pkgs/trame {
	      inherit trame-client;
	    };
	    #trame_common = py-final.callPackage ./pkgs/trame-common { };
	    trame-client = py-final.callPackage ./pkgs/trame-client {
	     # inherit trame_common;
	    };
	    trame-vtk = py-final.callPackage ./pkgs/trame-vtk {
	      inherit trame-client;
	    };
	    trame-vuetify = py-final.callPackage ./pkgs/trame-vuetify {
	      inherit trame-client;
	    };
	    trame-matplotlib= py-final.callPackage ./pkgs/trame-matplotlib{
	      inherit trame-client;
	      inherit mpld3;
	    };
	    trame-components = py-final.callPackage ./pkgs/trame-components {
	      inherit trame-client;
	    };
	    medmnist = py-final.callPackage ./pkgs/medmnist{ };
          };
        };
    };

    packages.${system} = rec {
      chesscom = pkgs.python312Packages.callPackage ./pkgs/chesscom { };
      cppimport = pkgs.python312Packages.callPackage ./pkgs/cppimport { };
      dev-env = pkgs.callPackage ./pkgs/dev-env { };
      hello-nix = pkgs.callPackage ./pkgs/hello-nix { }; 
      medmnist = pkgs.python3Packages.callPackage ./pkgs/medmnist{ };
      mpld3 = pkgs.python312Packages.callPackage ./pkgs/mpld3{ };
      mpi4py = pkgs.python3Packages.callPackage ./pkgs/mpi4py { };
      petsc = pkgs.callPackage ./pkgs/petsc { };
      petsc-project = pkgs.callPackage ./pkgs/petsc-project { };
      petscrc-update = pkgs.callPackage ./pkgs/petscrc-update { };
      petsc4py = pkgs.python3Packages.callPackage ./pkgs/petsc4py {
        inherit petsc;
      };
      trame = pkgs.python312Packages.callPackage ./pkgs/trame {
	inherit trame-client;
      };
      trame-client = pkgs.python312Packages.callPackage ./pkgs/trame-client { };
      trame-components = pkgs.python312Packages.callPackage ./pkgs/trame-components {
	inherit trame-client;
      };
      trame-vtk = pkgs.python312Packages.callPackage ./pkgs/trame-vtk {
	inherit trame-client;
      };
      trame-matplotlib = pkgs.python312Packages.callPackage ./pkgs/trame-matplotlib{
	inherit trame-client;
	inherit mpld3;
      };
      waybar-weather = pkgs.callPackage ./pkgs/waybar-weather { };
    };
  };
}
