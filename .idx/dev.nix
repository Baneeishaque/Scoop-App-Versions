{ pkgs, ... }: {
  channel = "unstable";

  packages = [
    pkgs.powershell
  ];

  env = { };
  idx = {
    extensions = [
      "FittenTech.Fitten-Code"
      "EditorConfig.EditorConfig"
      "ms-vscode.powershell"
    ];

    previews = {
      enable = false;
      previews = { };
    };

    workspace = {
      onCreate = { };
      onStart = { };
    };
  };
}
