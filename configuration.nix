# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:
	{
  		imports =
    		[ 
      			./hardware-configuration.nix
    		];

	# ------------------- LINUX KERNEL ------------------------
	boot.kernelPackages = pkgs.linuxPackages_6_18;

	# ------------------- TIMEZONE CONF -----------------------
	boot.loader.grub.enable = true;
	boot.loader.grub.device = "/dev/nvme0n1";
	boot.loader.grub.useOSProber = true;
  	time.timeZone = "Europe/Kyiv";

	# -------------------- NVIDIA DROVA -----------------------
	hardware.graphics = {
	enable = true;
	};

	# ------------------------ NIX ----------------------------
	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	# --------------------- SERVICES --------------------------
	services.logmein-hamachi.enable = true;

	services = {
		xserver.enable = true;
		displayManager.sddm = {
			enable = true;
			wayland.enable = true;
		};
		desktopManager.plasma6.enable = true;
		xserver.excludePackages = with pkgs; [ xterm ];
	};
	services.xserver.videoDrivers = ["nvidia"];
	hardware.nvidia = {
		modesetting.enable = true;
		powerManagement.enable = false;
		powerManagement.finegrained = false;
		open = true;
		nvidiaSettings = true;
		package = config.boot.kernelPackages.nvidiaPackages.latest;
	};
	services.xserver.xkb.layout = "us";
	services.pipewire = {
		enable = true;
		pulse.enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		jack.enable = true;
		wireplumber.enable = true;
	};

	# ------------------ NETWORKING ----------------------
	networking.networkmanager.enable = true;

	# --------------------- USER -------------------------
	users.users.syrik2000 = {
		isNormalUser = true;
		uid = 1000;
		extraGroups = [ "wheel" ];
		packages = with pkgs; [
			tree
		];
	};

	# -------------------- PROGRAMS ----------------------
	programs.steam = {
  		enable = true;
  		remotePlay.openFirewall = true;
  		dedicatedServer.openFirewall = true;
  		localNetworkGameTransfers.openFirewall = true;
	};
	programs.nix-ld.libraries = with pkgs; [
		vlc
		zlib
      		zstd
      		stdenv.cc.cc
      		curl
		openssl
      		attr
      		libssh
      		bzip2
      		libxml2
      		acl
      		libsodium
      		util-linux
      		xz
      		systemd
      		xorg.libXcomposite
      		xorg.libXtst
      		xorg.libXrandr
      		xorg.libXext
      		xorg.libX11
      		xorg.libXfixes
		libGL
      		libva
      		pipewire
      		xorg.libxcb
      		xorg.libXdamage
      		xorg.libxshmfence
      		xorg.libXxf86vm
      		libelf
      		glib
      		gtk2
      		vulkan-loader
      		libgbm
      		libdrm
      		libxcrypt
      		coreutils
      		pciutils
      		zenity
      		xorg.libXinerama
      		xorg.libXcursor
      		xorg.libXrender
      		xorg.libXScrnSaver
      		xorg.libXi
      		xorg.libSM
		xorg.libICE
      		gnome2.GConf
      		nspr
      		nss
      		cups
      		libcap
      		SDL2
      		libusb1
      		dbus-glib
      		ffmpeg
      		libudev0-shim
      		gtk3
      		icu
      		libnotify
      		gsettings-desktop-schemas
      		xorg.libXt
      		xorg.libXmu
      		libogg
      		libvorbis
      		SDL
      		SDL2_image
      		glew110
		libidn
      		tbb
      		flac
      		freeglut
      		libjpeg
      		libpng
      		libpng12
      		libsamplerate
      		libmikmod
      		libtheora
      		libtiff
      		pixman
      		speex
      		SDL_image
      		SDL_ttf
      		SDL_mixer
      		SDL2_ttf
      		SDL2_mixer
      		libappindicator-gtk2
      		libdbusmenu-gtk2
      		libindicator-gtk2
      		libcaca
      		libcanberra
		libgcrypt
      		libvpx
      		librsvg
      		xorg.libXft
      		libvdpau
      		pango
      		cairo
      		atk
      		gdk-pixbuf
      		fontconfig
      		freetype
      		dbus
      		alsa-lib
      		expat
      		libxkbcommon
		libxcrypt-legacy
      		libGLU 
      		fuse
      		e2fsprogs
		# PsychEngine
		gamemode
		# tes3mp
		openmw
		lz4
		qt5.qtbase
		libwebp
		zvbi
		snappy
		gsm
	];
	programs.gamemode.enable = true;
	programs.hyprland = {
		enable = true;
		xwayland.enable = true;
	};
	programs.nix-ld.enable = true;
	
	# --------- ALLOW UNFREE + SOMETHING ELSE -----------
	nixpkgs.config = {
		allowUnfree = true;
	};

	xdg.portal = {
		enable = true;
		xdgOpenUsePortal = true;
		config = {
			common.default = ["gtk"];
			hyprland.default = ["gtk" "hyprland"];
		};
		extraPortals = [
			pkgs.xdg-desktop-portal-gtk
			pkgs.xdg-desktop-portal-wlr
			pkgs.xdg-desktop-portal-hyprland
		];
	};
	hardware.bluetooth.enable = true;
	services.flatpak.enable = true;

	# ---------------- HERE ARE SYRI PKGS ---------------
	environment.systemPackages = with pkgs; [
		vim
		alacritty
		firefox
		wget
		neovim
	  	fastfetch
	  	git
	  	links2
	  	telegram-desktop
	  	kdePackages.dolphin
	  	blueman
	  	cava
	  	discord
	  	pavucontrol
	  	xdg-desktop-portal-hyprland
  		xdg-desktop-portal
	  	xdg-desktop-portal-wlr
	  	quickshell
		ayugram-desktop
		librewolf
		wineWowPackages.stagingFull_11
		hyprpaper
		vlc
		unzip
		btop
		cmatrix
		hyprlock
		nerd-fonts.fira-mono
		flameshot
		killall
		rofi
		mako
		hyprshot
		harfbuzz
		fribidi
		logmein-hamachi
		haguichi
		openmw
		wineasio
		bat
		tree
		gnumake
		gcc
		kdePackages.sddm-kcm
		kdePackages.qt6ct
		mesa-demos
		qpwgraph
		pulsemeeter
		lsd
		wlr-randr
		vscodium
		obs-studio
		prismlauncher
		javaPackages.compiler.openjdk25
		lutris
		# here i ADD pkgs
	];

	# ----------------- OTHER ENVIRONMENTS ------------------
	environment = {
	  	variables = {
	    		XDG_CURRENT_DESKTOP = "Hyprland";
	    		XDG_SESSION_TYPE = "wayland";
	    		XDG_SESSION_DESKTOP = "Hyprland";
			XDG_DATA_DIRS = lib.mkForce "/etc/xdg:/nix/store/1vkdqgrr7hdqakr0yyllz8r5yji5cz14-desktops/share:/home/syrik2000/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:/home/syrik2000/.nix-profile/share:/nix/profile/share:/home/syrik2000/.local/state/nix/profile/share:/etc/profiles/per-user/syrik2000/share:/nix/var/nix/profiles/default/share:/run/current-system/sw/share";
		};
		etc."xdg/icons/hicolor/256x256/apps/flicon.png".source = ./flicon.png;
		etc."xdg/menus/applications.menu".source = "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";
		sessionVariables = {
		MOZ_ENABLE_WAYLAND = "1";
		NIXOS_OZONE_WL = "1";
		T_QPA_PLATFORM = "wayland";
		GDK_BACKEND = "wayland";
    		WLR_NO_HARDWARE_CURSORS = "1";
	};
};

# ----------------- SYSTEM VERSION ------------------
system.stateVersion = "25.11";
}

