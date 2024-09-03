{ lib
, buildGoApplication
, enableFfmpeg ? true
, enableLibWebPTools ? true
, fetchFromGitHub
, ffmpeg
, libwebp
, nix-filter
}:

let

  v = "1.9.5";

  gitSrc = nix-filter{
    name = "watgbridge";
    root = fetchFromGitHub {
      owner = "akshettrj";
      repo = "watgbridge";
      rev = "v${v}";
      hash = "sha256-eNGR6E1g9VEsyb3x9Ne5D9oIPaceu1ejiWvtdQMs6vg=";
    };
    exclude = [
      "flake.nix"
      "flake.lock"
      "README.md"
      "sample_config.yaml"
      "watgbridge.service.sample"
      ".github"
      "nix"
      "assets"
      ".envrc"
      ".gitignore"
      "Dockerfile"
      "LICENSE"
    ];
  };

in buildGoApplication rec {
  pname = "watgbridge";
  version = v;

  pwd = gitSrc;
  src = gitSrc;

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

