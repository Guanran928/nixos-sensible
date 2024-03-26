{
  lib,
  config,
  ...
}: {
  # Add wheel group to trusted-users
  # These users will have additional rights when connecting to the Nix daemon,
  # such as the ability to specify additional substituters,
  # or to import unsigned NARs.
  nix.settings.trusted-users = ["root" "@wheel"];

  # https://archlinux.org/news/making-dbus-broker-our-default-d-bus-daemon/
  services.dbus.implementation = lib.mkDefault "broker";

  # https://github.com/nix-community/srvos/blob/c490c19a959d406c87ae1c1481a4608d41a83597/nixos/common/default.nix#L19-L30
  boot.initrd.systemd.enable = lib.mkDefault (
    !(
      if lib.versionAtLeast (lib.versions.majorMinor lib.version) "23.11"
      then config.boot.swraid.enable
      else config.boot.initrd.services.swraid.enable
    )
    && !config.boot.isContainer
    && !config.boot.growPartition
  );

  # Swap nano with vim
  programs.nano.enable = lib.mkDefault false;
  programs.vim.defaultEditor = lib.mkDefault true;

  # For purity
  users.mutableUsers = lib.mkDefault false;
  boot.tmp.cleanOnBoot = lib.mkDefault true;
  security.sudo.extraConfig = lib.mkDefault ''
    Defaults lecture = never
  '';
}
