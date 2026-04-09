{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  packages = [
    pkgs.python3
    pkgs.uv

    pkgs.stdenv.cc.cc.lib  # 👈 provides libstdc++.so.6
  ];

  shellHook = ''
    export LD_LIBRARY_PATH=${pkgs.stdenv.cc.cc.lib}/lib:$LD_LIBRARY_PATH
    echo "Python and uv are ready!"
    python --version
    uv --version

    if [ ! -d .venv ]; then
      uv venv
    fi
    source .venv/bin/activate
    echo "uv virtualenv activated"
  '';
}
