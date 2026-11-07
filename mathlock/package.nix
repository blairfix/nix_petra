{ pkgs ? import <nixpkgs> {} }:

let
  pythonEnv = pkgs.python3.withPackages (ps: [
    ps.pyside6
  ]);

  qmlModules = pkgs.kdePackages.qtdeclarative;
  qmlPath = "${qmlModules}/lib/qt-6/qml";
in
pkgs.stdenvNoCC.mkDerivation {
  pname = "mathlock";
  version = "0.1.0";
  src = ./.;

  nativeBuildInputs = [ pkgs.makeWrapper ];

  installPhase = ''
    mkdir -p $out/share/mathlock $out/bin
    cp main.py Main.qml poop.png $out/share/mathlock/

    makeWrapper ${pythonEnv}/bin/python $out/bin/mathlock \
      --add-flags "$out/share/mathlock/main.py" \
      --set QML_IMPORT_PATH "${qmlPath}" \
      --set QML2_IMPORT_PATH "${qmlPath}"
  '';
}

