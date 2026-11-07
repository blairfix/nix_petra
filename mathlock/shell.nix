{ pkgs ? import <nixpkgs> {} }:

let
qtQmlModules = [
    pkgs.kdePackages.qtdeclarative
];
in
pkgs.mkShell {
    packages = [
	pkgs.python3
	    pkgs.python3Packages.pyside6
	    pkgs.kdePackages.qtwayland
    ] ++ qtQmlModules;

    shellHook = ''

	start-mathlock() {
	    python main.py &
		echo $! > "$XDG_RUNTIME_DIR/mathlock.pid"
	}

    kill-mathlock() {
	local pidfile="$XDG_RUNTIME_DIR/mathlock.pid"
	    if [ -f "$pidfile" ]; then
		kill -TERM "$(cat "$pidfile")" 2>/dev/null || true
		    rm -f "$pidfile"
	    else
		echo "No mathlock PID file found."
		    fi
    }


    export QML_IMPORT_PATH="${pkgs.lib.makeSearchPath "lib/qt-6/qml" qtQmlModules}:''${QML_IMPORT_PATH:-}"
	export QML2_IMPORT_PATH="$QML_IMPORT_PATH"
	'';
}

