{
  config,
  ...
}:
{
  home.file."${config.xdg.configHome}/xremap/config.yml".text = ''
    modmap:
      - name: Global
        remap:
          CapsLock: Esc
  '';

  # Install xremap via copr since systemd seems to fail executing the binary when downloaded from nix.
  #
  # ```
  # sudo dnf copr enable blakegardner/xremap
  # sudo dnf install xremap-gnome
  # ```
  #
  # Then copy the file `systemd/xremap.service` to `/etc/systemd/system` and then enable it via `sudo systemctl enable xremap.service`
}
