{ lib, stdenv, fetchFromGitHub, bash, python3 }:

stdenv.mkDerivation rec {
  pname = "newman-bridge";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "lukebodmer";
    repo = "newman-firefox-bridge";
    rev = "3331ac881239bff6862fc346ac150757d37b5f0b";
    sha256 = "sha256-Of/fS41dEd15aBg9wIshkhLIRsHtjrECWcgrffI2rZ4=";
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
