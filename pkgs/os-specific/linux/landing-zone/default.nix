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
  pname = "landing-zone";
  version = "0.3.0";

  src = builtins.fetchGit {
  url = "https://github.com/3mdeb/landing-zone.git";
  ref = "tpm12_fix";
  rev = "eaf2ce53f8cc66b23b4fae98f19ddd2275af0e6b";
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
}
