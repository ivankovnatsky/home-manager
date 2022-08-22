{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.programs.dockutil;

in
{
  options.programs.dockutil = {
    enable = mkEnableOption "command line tool for managing dock items";

    appsToUse = mkOption {
      type = with types; listOf str;
      default = [ ];
      description = ''
        Add apps after cleaning up everything.
      '';
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.dockutil ];

    home.file.".dockutil/config".text = mkIf (cfg.appsToUse != [ ]) ''
      ${pkgs.dockutil}/bin/dockutil --remove all
    '';
  };
}
