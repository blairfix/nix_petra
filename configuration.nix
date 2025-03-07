
{ config, pkgs, ... }:

{
    imports =
	[ 
	# include
	./hardware-configuration.nix
	./borg_petra.nix

	];

    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # kernel
    boot.kernelPackages = pkgs.linuxPackages_latest;

    networking.hostName = "petra-laptop"; # Define your hostname.
	# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

	# Configure network proxy if necessary
	# networking.proxy.default = "http://user:password@proxy:port/";
	# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

	# Enable networking
	networking.networkmanager.enable = true;

    # Set your time zone.
    time.timeZone = "America/Edmonton";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_CA.UTF-8";

    # Enable the X11 windowing system.
    services.xserver.enable = true;

    # Enable the KDE Plasma Desktop Environment.
    services.displayManager.sddm.enable = true;
    services.xserver.desktopManager.plasma6.enable = true;

    # Configure keymap in X11
    services.xserver.xkb = {
	layout = "us";
    };

    # Enable CUPS to print documents.
    services.printing.enable = true;

    # Enable tailscale
    services.tailscale.enable = true;

    # Enable sound with pipewire.
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
	enable = true;
	alsa.enable = true;
	alsa.support32Bit = true;
	pulse.enable = true;
	# If you want to use JACK applications, uncomment this
	#jack.enable = true;

	# use the example session manager (no others are packaged yet so this is enabled by default,
		# no need to redefine it in your config for now)
	#media-session.enable = true;
    };

    # Enable touchpad support (enabled default in most desktopManager).
    # services.xserver.libinput.enable = true;


    # syncthing
    services.syncthing = {
	enable = true;
	user = "petra";
	dataDir = "/home/petra"; 
	configDir = "/home/petra/.config/syncthing";
    };



    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.petra = {
	isNormalUser = true;
	description = "petra";
	extraGroups = [ "networkmanager" "wheel" ];
	packages = with pkgs; [

	    firefox
	    syncthing
	    neovim
	    tailscale
	    alacritty  
	    libreoffice
	    htop
	    eza
	    trash-cli
	    gnome-disk-utility
	    gnome-multi-writer
	    retroarchFull
	    onlyoffice-bin
	    minetest

	];
    };



    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # List packages installed in system profile. To search, run:

    environment.systemPackages = with pkgs; [

	borgbackup
	    git

    ];

    
    # for bash scripts 
    services.envfs.enable = true;

    # version
    system.stateVersion = "23.05"; # Did you read the comment?

}
