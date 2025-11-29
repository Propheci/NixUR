{ lib
, fetchFromGitHub
, nix-filter
, stdenv
, cmake
, qt6
, openssl
, pkg-config
, libpulseaudio
}:

let
  version = "linux-v0.1.0";
  originalSource = nix-filter {
    name = "librepods";
    root = fetchFromGitHub {
      owner = "kavishdevar";
      repo = "librepods";
      rev = version;
      hash = "sha256-ZvHbSSW0rfcsNUORZURe0oBHQbnqmS5XT9ffVMwjIMU=";
    };
    include = [
      "linux"
    ];
  };
in stdenv.mkDerivation {
  name = "librepods";
  version = version;
  src = "${originalSource}/linux";

  nativeBuildInputs = [
    cmake
    qt6.full
    pkg-config
  ];

  buildInputs = [
    openssl.dev
    libpulseaudio
  ];

  PKG_CONFIG_PATH = "${openssl.dev}/lib/pkgconfig";

  meta = with lib; {
    description = "A Minimal Google Drive Downloader Written in Go";
    homepage = "https://github.com/JaskaranSM/drivedlgo";
    changelog = "https://github.com/JaskaranSM/drivedlgo/releases/tag/${version}";
    license = licenses.gpl3;
    # mainProgram = "";
  };
}

