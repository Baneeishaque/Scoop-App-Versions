{ pkgs, ... }: {
  channel = "unstable";

  packages = [
    pkgs.powershell
    pkgs.tree
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
