{ config, pkgs, ... }:
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
		settings = {
			user = {
				name = "Amanda Graven";
				email = "a.graven@famedly.com";
			};
		}
	};
}
