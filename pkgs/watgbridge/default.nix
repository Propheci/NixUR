{ lib
, buildGoApplication
, enableFfmpeg ? true
, enableLibWebPTools ? true
, fetchFromGitHub
, ffmpeg
, libwebp
}:

let

  v = "1.9.0";

in buildGoApplication rec {
  pname = "watgbridge";
  version = v;

  pwd = fetchFromGitHub {
    owner = "akshettrj";
    repo = "watgbridge";
    rev = "v${v}";
    hash = "sha256-FhPsvcn2xwOkbxotGnq4A5uKPX9K8qbY/JACDP1r6uk=";
  };
  src = pwd;

  ldflags = [ "-s" "-w" ];

  buildInputs = [
  ] ++ lib.optionals enableFfmpeg [
    ffmpeg
  ] ++ lib.optionals enableLibWebPTools [
    libwebp
  ];

  meta = with lib; {
    description = "A bridge between WhatsApp and Telegram written in Golang";
    homepage = "https://github.com/akshettrj/watgbridge";
    changelog = "https://github.com/akshettrj/watgbridge/releases/tag/v${version}";
    license = licenses.mit;
    mainProgram = "watgbridge";
  };
}

