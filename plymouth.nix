{ ... }:

{
	boot = {
		plymouth.enable = true;

		# Reduce boot console noise
		consoleLogLevel = 3;
		initrd.verbose = false;
		kernelParams = [
			"quiet"
			"udev.log_level=3"
			"systemd.show_status=auto"
		];

		# Make systemd available in the init ram disk (needed for graphical password prompt)
		initrd.systemd.enable = true;
	};
	
}
