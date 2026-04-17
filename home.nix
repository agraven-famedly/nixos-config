# Home manager configuration

{ ... }:
{
	# Boilerplate

	home.username = "amanda";
	home.homeDirectory = "/home/amanda";

	# State version to prevent breaking changes across upgrades
	home.stateVersion = "25.11";

	# Let home manager manage itself
	programs.home-manager.enable = true;

	# Actual configuration starts here

	programs.git = {
		enable = true;
		signing = {
			signByDefault = true;
			key = "BC58FE0C4256DB033D26C66E71F1C405C9569184";
		};
		settings = {
			user = {
				name = "Amanda Graven";
				email = "a.graven@famedly.com";
			};
		};
	};

	# Enable man page searching with apropos (slows the build a little)
	programs.man.generateCaches = true;

	programs.neovide = {
		enable = true;
		settings = {
			maximized = true;
			font = {
				normal = "IosevkaTermSlab Nerd Font";
				size = 11;
				edging = "subpixelantialias";
			};
		};
	};
}
