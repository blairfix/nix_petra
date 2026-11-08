
# install configs
sudo cp *.nix /etc/nixos/


# install nix_build
mkdir /home/petra/bin
cp yay /home/petra/bin
cp nix_cleanup /home/petra/bin
cp tailscale /home/petra/bin

# install mathlock
mkdir -p ~/.config/autostart/

cp -r mathlock /home/petra/bin
cp mathlock/mathlock-resume-watch /home/petra/bin
cp mathlock/mathlock-resume-watch.desktop ~/.config/autostart/
