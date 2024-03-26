{
  description = "Basic NixOS settings everyone can agree on";

  outputs = _: {
    nixosModules = {
      default = ./nixos;
      zram = ./nixos/zram.nix;
    };
  };
}
