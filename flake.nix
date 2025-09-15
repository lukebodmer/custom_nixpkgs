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

        python312 = prev.python312.override {
          packageOverrides = py-final: _: rec {
	    cppimport = py-final.callPackage ./pkgs/cppimport { };
	    trame = py-final.callPackage ./pkgs/trame {
	      inherit trame_server;
	      inherit trame_vuetify;
	    };
	    trame_common = py-final.callPackage ./pkgs/trame-common {
	    };
	    trame_client = py-final.callPackage ./pkgs/trame-client {
	      inherit trame_common;
	    };
	    trame_server = py-final.callPackage ./pkgs/trame-server {
	      inherit wslink;
	    };
	    trame_vtk = py-final.callPackage ./pkgs/trame-vtk {
	      inherit trame_client;
	    };
	    trame_vuetify = py-final.callPackage ./pkgs/trame-vuetify {
      	      inherit trame_client;
	      inherit trame_vtk;
	    };
	    wslink = py-final.callPackage ./pkgs/wslink { };
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
        inherit petsc;
      };
      trame = pkgs.python312Packages.callPackage ./pkgs/trame{
	#inherit trame_vuetify;
        #inherit trame_server;
      };
      trame_common = pkgs.python312Packages.callPackage ./pkgs/trame-common { };
      trame_client = pkgs.python312Packages.callPackage ./pkgs/trame-client{
        inherit trame_common;
      };
      trame_server = pkgs.python312Packages.callPackage ./pkgs/trame-server {
      	inherit wslink;
      };
      trame_vtk = pkgs.python312Packages.callPackage ./pkgs/trame-vtk {
      	inherit trame_client;
      };
      trame_vuetify = pkgs.python312Packages.callPackage ./pkgs/trame-vuetify {
      	inherit trame_client;
	inherit trame_vtk;
      };
      waybar-weather = pkgs.callPackage ./pkgs/waybar-weather { };
      wslink = pkgs.python312Packages.callPackage ./pkgs/wslink { };
    };
  };
}
