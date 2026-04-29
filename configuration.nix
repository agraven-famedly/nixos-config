# Edit this configuration file to define what should be installed on
# your system.	Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:
{
	imports = [
		# Include the results of the hardware scan.
		./hardware-configuration.nix
		./plymouth.nix
		./documentation.nix
	];

	# Bootloader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	boot.initrd.luks.devices."luks-81db1793-93f1-4367-9c11-812c245701f2".device = "/dev/disk/by-uuid/81db1793-93f1-4367-9c11-812c245701f2";

	networking.hostName = "scuzzy"; # Define your hostname.
	# networking.wireless.enable = true;	# Enables wireless support via wpa_supplicant.

	# Enable networking
	networking.networkmanager.enable = true;

	# Set your time zone.
	time.timeZone = "Europe/Copenhagen";

	# Select internationalisation properties.
	i18n.defaultLocale = "en_DK.UTF-8";

	i18n.extraLocaleSettings = {
		LC_ADDRESS = "da_DK.UTF-8";
		LC_IDENTIFICATION = "da_DK.UTF-8";
		LC_MEASUREMENT = "da_DK.UTF-8";
		LC_MONETARY = "da_DK.UTF-8";
		LC_NAME = "da_DK.UTF-8";
		LC_NUMERIC = "da_DK.UTF-8";
		LC_PAPER = "da_DK.UTF-8";
		LC_TELEPHONE = "da_DK.UTF-8";
		LC_TIME = "da_DK.UTF-8";
	};

	# Enable the X11 windowing system.
	# You can disable this if you're only using the Wayland session.
	services.xserver.enable = true;

	# Enable the KDE Plasma Desktop Environment.
	services.displayManager.sddm.enable = true;
	services.desktopManager.plasma6.enable = true;

	# Configure keymap in X11
	services.xserver.xkb = {
		layout = "us";
		variant = "";
		options = "caps:escape_shifted_capslock";
	};


	# Enable CUPS to print documents.
	services.printing.enable = true;

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

	# Allow unfree packages
	nixpkgs.config.allowUnfree = true;
	# Enable flakes
	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.amanda = {
		isNormalUser = true;
		description = "Amanda";
		extraGroups = [ "networkmanager" "wheel" "docker" ];
		packages = with pkgs; [
			kdePackages.kate
		#	thunderbird
		];
	};


	# Program options
	programs.bash.vteIntegration = true;
	programs.direnv.enable = true;
	programs.neovim = {
		enable = true;
		# Set the EDITOR variable to nvim globally
		defaultEditor = true;
	};
	programs.firefox.enable = true;
	programs.kde-pim = {
		kontact = true;
		kmail = true;
		enable = true;
	};
	programs.nh.enable = true;
	programs.partition-manager.enable = true;

	# List packages installed in system profile. To search, run:
	# $ nix search wget
	environment.systemPackages = with pkgs; [
		bitwarden-desktop
		cinny-desktop
		direnv
		element-desktop
		fd
		gcc
		gh
		git
		gnumake
		go
		inkscape
		neovide
		nerd-fonts.iosevka-term-slab
		ripgrep

		ast-grep
		bash-language-server
		clang-tools
		lemminx
		nixd
		ruff
		rustup
		tree-sitter
		ty
		vim-language-server
		vscode-langservers-extracted
		vscode-extensions.vadimcn.vscode-lldb.adapter
		yaml-language-server

		kdePackages.akonadi
		kdePackages.akonadi-calendar
		kdePackages.akonadi-contacts
		kdePackages.akonadi-import-wizard
		kdePackages.akonadi-search
		kdePackages.kaccounts-integration
		kdePackages.kaccounts-providers
		kdePackages.kdepim-addons
		kdePackages.kdepim-runtime
		kdePackages.kio-gdrive
		kdePackages.signon-kwallet-extension
		kdePackages.signond
		libsForQt5.qoauth
	];

	famedly-hwp.osquery_secret_path = "/etc/nixos/osquery_secret.txt";

	hardware.bluetooth.enable = true;

	virtualisation.docker = {
		enable = true;
	};

	programs.gnupg.agent = {
		enableSSHSupport = true;
		#settings = {
		#	disable-ccid = true;
		#};
	};

	hardware.gpgSmartcards.enable = true;

	# Open ports in the firewall.
	# networking.firewall.allowedTCPPorts = [ ... ];
	# networking.firewall.allowedUDPPorts = [ ... ];
	# Or disable the firewall altogether.
	# networking.firewall.enable = false;

	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It‘s perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "25.11"; # Did you read the comment?
}
