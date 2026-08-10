{ lib, stdenv, fetchFromGitHub, bash, python3 }:

stdenv.mkDerivation rec {
  pname = "newman-bridge";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "lukebodmer";
    repo = "newman-firefox-bridge";
    rev = "ec802ee4f5a65a099b27f93c8934eb0576046991";
    sha256 = "sha256-pLSH8z1CywhOvRmbYtVMtN9i7au+TvUx+3FvcwwhCvQ=";
  };

  nativeBuildInputs = [ ];

  buildPhase = "true";

  installPhase = ''
    mkdir -p $out/bin $out/share/newman-bridge $out/share/mozilla/native-messaging-hosts

    cp newman_bridge_signed.xpi $out/share/newman-bridge/newman_bridge.xpi
    cp host/newman_bridge.py $out/share/newman-bridge/

    # Manifest with the final installed path baked in
    cat > $out/share/mozilla/native-messaging-hosts/newman_bridge.json <<EOF
    {
      "name": "newman_bridge",
      "description": "Newman browser bridge native messaging host",
      "path": "$out/bin/newman-bridge",
      "type": "stdio",
      "allowed_extensions": ["newman-bridge@lukebodmer"]
    }
    EOF

    cat > $out/bin/newman-bridge <<EOF
    #!${bash}/bin/bash
    exec ${python3}/bin/python3 $out/share/newman-bridge/newman_bridge.py "\$@"
    EOF
    chmod +x $out/bin/newman-bridge
  '';

  meta = with lib; {
    description = "Firefox WebExtension + native messaging host for the Newman AI harness";
    platforms = platforms.linux;
  };
}
