{
  lib,
  python3,
  audiobook-dl-src,
}:
let
  mkDate =
    longDate:
    (lib.concatStringsSep "-" [
      (builtins.substring 0 4 longDate)
      (builtins.substring 4 2 longDate)
      (builtins.substring 6 2 longDate)
    ]);
  date = mkDate (audiobook-dl-src.lastModifiedDate or "19700101");
in

python3.pkgs.buildPythonApplication {
  pname = "audiobook-dl";
  version = "date-=${date}_${audiobook-dl-src.shortRev or "dirty"}";
  pyproject = true;

  src = audiobook-dl-src;

  build-system = [
    python3.pkgs.setuptools
    python3.pkgs.setuptools-scm
  ];

  dependencies = with python3.pkgs; [
    appdirs
    attrs
    cssselect
    importlib-resources
    lxml
    m3u8
    mutagen
    pillow
    pycountry
    pycryptodome
    requests
    rich
    tomli
    urllib3
  ];

  meta = {
    description = "Audiobook CLI downloader";
    homepage = "https://github.com/jo1gi/audiobook-dl";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "audiobook-dl";
  };
}
