{ pkgs ? import ../nixpkgs.nix }:

let
  tools = pkgs.callPackage ../tools.nix {};
in tools.makeTest {
  name = "colmena-exec";

  bundle = ./.;

  testScript = ''
    logs = deployer.succeed("cd /tmp/bundle && ${tools.colmenaExec} exec --on @target -- echo output from '$(hostname)' 2>&1")

    assert "output from alpha" in logs
    assert "output from beta" in logs
    assert "output from gamma" in logs
  '';
}
