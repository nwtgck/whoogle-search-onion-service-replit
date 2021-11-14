{ pkgs }: {
  deps = [
    pkgs.tor
    pkgs.python39
    pkgs.python39Packages.pip
    pkgs.python39Packages.setuptools
    pkgs.libffi
  ];
}
