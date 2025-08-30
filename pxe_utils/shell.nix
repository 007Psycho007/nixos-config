{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [
    pkgs.python3
    (pkgs.python3.withPackages (ps: with ps; [
      flask
      requests
      typst
      pip
    ]))
  ];

  shellHook = ''
    echo "Python + Flask dev environment is ready!"
  '';
}
