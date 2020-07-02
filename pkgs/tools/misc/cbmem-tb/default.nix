{ stdenv, fetchgit, fetchurl, zlib, pciutils, coreutils, acpica-tools, iasl, makeWrapper, gnugrep, gnused, file, buildEnv }:

let
  version = "4.12";

  meta = with stdenv.lib; {
    description = "Various coreboot-related tools";
    homepage = "https://www.coreboot.org";
    license = licenses.gpl2;
    platforms = platforms.linux;
  };

  generic = { pname, path ? "util/${pname}", ... }@args: stdenv.mkDerivation (rec {
    inherit pname version meta;

    src = builtins.fetchGit {
      url = "https://github.com/pcengines/coreboot.git";
      ref = "cbmem_drtm_fixes";
      rev = "872f00d03113df2eb545b99cdcc736593e3bc602";
    };

    enableParallelBuilding = true;

    postPatch = ''
      cd ${path}
    '';

    makeFlags = [
      "INSTALL=install"
      "PREFIX=${placeholder "out"}"
    ];

    NIX_CFLAGS_COMPILE = "-Wno-error";
  } // args);

  utils = {
    cbmem = generic {
      pname = "cbmem";
      meta.description = "Coreboot console log reader";
    };
  };

in utils // {
  coreboot-utils = (buildEnv {
    name = "coreboot-utils-${version}";
    paths = stdenv.lib.attrValues utils;
    postBuild = "rm -rf $out/sbin";
  }) // {
    inherit meta version;
  };
}
