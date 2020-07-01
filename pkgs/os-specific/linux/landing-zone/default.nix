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
  ref = "event_log";
  rev = "61472b97754abaea7de13455c04573c5c6ac97ce";
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
