{ lib, stdenv
, fetchFromGitHub
, rustPlatform
}:

rustPlatform.buildRustPackage rec {
  pname = "cargo-atcoder";
  version = "0.3.0";

  src = fetchFromGitHub {
    owner = "tanakh";
    repo = pname;
    rev = "v${version}";
    sha256 = "0rw39dbg1xdm72ymmzlnfz2pjck49a3l5c3m0w00p5v043536flq";
  };

  cargoSha256 = "03wxl7fgsqpxsfsw2hkgqrk718ff61d3zrziv7n8zm6lcg10fd88";

  doCheck = false;

  meta = with lib; {
    description = "Cargo subcommand for AtCoder";
    homepage = "https://github.com/tanakh/cargo-atcoder";
    license = [ licenses.mit ];
  };
}
