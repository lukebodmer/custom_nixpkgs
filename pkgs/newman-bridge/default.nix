{ lib, stdenv, fetchFromGitHub, zip, bash, python3 }:

stdenv.mkDerivation rec {
  pname = "newman-bridge";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "lukebodmer";
    repo = "newman-firefox-bridge";
    rev = "7b415cfce5c7b4c4d874124df926e84c595ae15a";
    sha256 = "sha256-BrsnBleObqIcp8lTmceRf5ptK0FzoTtH7pmQ5Rwv37U=";
  };

  nativeBuildInputs = [ zip ];

  buildPhase = ''
    mkdir -p xpi-work
    cp extension/manifest.json extension/background.js xpi-work/
    cd xpi-work && zip -r ../newman_bridge.xpi . && cd ..
  '';

  installPhase = ''
    mkdir -p $out/bin $out/share/newman-bridge $out/share/mozilla/native-messaging-hosts

    cp newman_bridge.xpi $out/share/newman-bridge/
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
