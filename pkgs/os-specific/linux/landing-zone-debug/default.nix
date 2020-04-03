{ lib
, stdenv
, fetchurl
, automake
, gcc-unwrapped
, pkgconfig
, libstdcxx5
, hexdump
}:

stdenv.mkDerivation rec {
  pname = "landing-zone-debug";
  version = "0.3.0";

  src = builtins.fetchGit {
  url = "https://github.com/TrenchBoot/landing-zone.git";
  ref = "master";
  rev = "9c7dd385014b19e045b31bce10e35c07961ba748";
  };

  patches = [ ./compatibility.patch ];

  nativeBuildInputs = [ hexdump pkgconfig automake gcc-unwrapped ];
  buildInputs = [ libstdcxx5 ];

  meta = with lib; {
    homepage = https://github.com/TrenchBoot/landing-zone;
    description = "Landing Zone";
    license = licenses.gpl2;
    platforms = platforms.all;
  };

  makeFlags = [ "DEBUG=y" ];
}
