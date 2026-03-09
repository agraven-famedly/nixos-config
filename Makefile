.PHONY: switch

switch:
	nixos-rebuild switch --sudo --flake '.#scuzzy'
