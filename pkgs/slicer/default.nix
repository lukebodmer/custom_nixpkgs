{ lib
, stdenv
, fetchurl
, autoPatchelfHook
, makeWrapper
, copyDesktopItems
, makeDesktopItem
, alsa-lib
, cups
, dbus
, expat
, fontconfig
, freetype
, glib
, libGL
, libGLU
, libglvnd
, libpq
, libxkbcommon
, libxcrypt-legacy
, nspr
, nss
, pcre2
, pulseaudio
, unixODBC
, util-linux
, xorg
, zlib
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "slicer";
  version = "5.12.4";

  # Upstream publishes releases by build revision rather than by version
  # alone; 34645 is the revision behind the 5.12.4 Linux release.
  revision = "34645";

  src = fetchurl {
    url = "https://slicer-packages.kitware.com/api/v1/item/6aa1beb7ce9de556d3010204/download";
    name = "Slicer-${finalAttrs.version}-linux-amd64.tar.gz";
    hash = "sha256-MRo9KlIEazRMRMFgpyMtl317c81JYd1Sle6hh5xqo3A=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
    makeWrapper
    copyDesktopItems
  ];

  # Slicer bundles its own Qt, VTK, ITK, CTK and Python; only the system-level
  # libraries below need to come from nixpkgs.
  buildInputs = [
    alsa-lib
    cups
    dbus
    expat
    fontconfig
    freetype
    glib
    libGL
    libGLU
    libglvnd
    libpq
    libxkbcommon
    libxcrypt-legacy
    nspr
    nss
    pcre2
    pulseaudio
    unixODBC
    util-linux
    zlib
    stdenv.cc.cc.lib
    xorg.libICE
    xorg.libSM
    xorg.libX11
    xorg.libXcomposite
    xorg.libXcursor
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXi
    xorg.libXrandr
    xorg.libXrender
    xorg.libXtst
    xorg.libxcb
    xorg.xcbutil
    xorg.xcbutilimage
    xorg.xcbutilkeysyms
    xorg.xcbutilrenderutil
    xorg.xcbutilwm
  ];

  # The bundled libraries live in several directories that reference each
  # other; teach autoPatchelf about all of them.
  runtimeDependencies = [ (placeholder "out") ];

  dontConfigure = true;
  dontBuild = true;

  # The tree ships prebuilt binaries with their own RPATHs plus a large number
  # of Python extension modules; stripping breaks nothing but is slow and the
  # build already ships stripped objects.
  dontStrip = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/slicer
    cp -r . $out/share/slicer

    mkdir -p $out/bin

    # The launcher pins SLICER_HOME into the read-only store, but Slicer wants
    # to create a "slicer.org" directory underneath it for its per-revision
    # settings file and installed extensions. Build a writable SLICER_HOME in
    # the user's data dir that symlinks back to the store for everything else,
    # and point the launcher at it, so the Extension Manager works.
    cat > $out/bin/.slicer-setup <<'EOF'
store="@out@/share/slicer"
home="''${XDG_DATA_HOME:-$HOME/.local/share}/Slicer/@revision@"
mkdir -p "$home/slicer.org"
for entry in "$store"/*; do
  name="$(basename "$entry")"
  [ "$name" = slicer.org ] && continue
  ln -sfn "$entry" "$home/$name"
done
# Drop stale links from a previous store path so an upgrade cannot leave the
# overlay pointing at a garbage-collected generation.
for link in "$home"/*; do
  [ -L "$link" ] && [ ! -e "$link" ] && rm -f "$link"
done
launcher="$home/LauncherSettings.ini"
sed "s|<APPLAUNCHER_SETTINGS_DIR>/\.\.|$home|g" \
  "$store/bin/SlicerLauncherSettings.ini" > "$launcher"
EOF
    substituteInPlace $out/bin/.slicer-setup \
      --replace-fail '@revision@' '${finalAttrs.revision}' \
      --replace-fail '@out@' "$out"

    # Slicer only bundles Qt's xcb platform plugin, so a Wayland session would
    # otherwise fail to start; force it through XWayland. QT_PLUGIN_PATH and
    # the theme plugins are unset so that a host Qt from the user's profile
    # cannot be loaded into Slicer's bundled Qt.
    makeWrapper $out/share/slicer/Slicer $out/bin/Slicer \
      --set QT_QPA_PLATFORM xcb \
      --unset QT_PLUGIN_PATH \
      --unset QT_QPA_PLATFORMTHEME \
      --unset QT_STYLE_OVERRIDE \
      --run ". $out/bin/.slicer-setup" \
      --add-flags "--launcher-additional-settings \"\$launcher\""

    install -Dm644 Slicer.png $out/share/icons/hicolor/128x128/apps/Slicer.png

    runHook postInstall
  '';

  # autoPatchelf must be able to resolve Slicer's own libraries, which are
  # spread across lib/, lib/Slicer-5.12/ and friends.
  preFixup = ''
    addAutoPatchelfSearchPath $out/share/slicer/lib
    addAutoPatchelfSearchPath $out/share/slicer/lib/Slicer-5.12
    addAutoPatchelfSearchPath $out/share/slicer/lib/Slicer-5.12/cli-modules
    addAutoPatchelfSearchPath $out/share/slicer/lib/Slicer-5.12/qt-loadable-modules
    addAutoPatchelfSearchPath $out/share/slicer/lib/Teem-1.12.0
    addAutoPatchelfSearchPath $out/share/slicer/lib/Python/lib
    addAutoPatchelfSearchPath $out/share/slicer/bin
  '';

  desktopItems = [
    (makeDesktopItem {
      name = "Slicer";
      exec = "Slicer %F";
      icon = "Slicer";
      desktopName = "3D Slicer";
      genericName = "Medical Image Computing Platform";
      comment = "Analysis and visualization of medical images";
      categories = [ "Graphics" "Science" "MedicalSoftware" "3DGraphics" ];
      mimeTypes = [ "application/x-mrml" "application/dicom" ];
    })
  ];

  meta = {
    description = "Open source software platform for medical image informatics, image processing, and three-dimensional visualization";
    homepage = "https://www.slicer.org/";
    license = lib.licenses.bsd3;
    platforms = [ "x86_64-linux" ];
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
    mainProgram = "Slicer";
  };
})
