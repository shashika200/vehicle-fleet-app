# To learn more about how to use Nix to configure your environment
# see: https://firebase.google.com/docs/studio/customize-workspace
{ pkgs, ... }:
let
  androidPkgs = pkgs.androidenv.composeAndroidPackages {
    platformVersions = [ "33" ];
    buildToolsVersions = [ "33.0.2" ];
    ndkVersions = [ "25.2.9519653" ];
    abiVersions = [ "x86_64" ];
    includeEmulator = true;
    includeSystemImages = true;
  };
in
{
  # Which nixpkgs channel to use.
  channel = "stable-24.05"; # or "unstable"

  # Use https://search.nixos.org/packages to find packages
  packages = [
    pkgs.gtk3
    pkgs.jdk17
    pkgs.unzip
    pkgs.imagemagick
    pkgs.clang
    pkgs.cmake
    pkgs.ninja
    pkgs.pkg-config
    # Add the composed Android packages to the environment
    androidPkgs.androidsdk
    androidPkgs.platform-tools
    androidPkgs.emulator
  ];

  # Sets environment variables in the workspace
  env = {
    # Update the ANDROID_SDK_ROOT to the correct path
    ANDROID_SDK_ROOT = "${androidPkgs.androidsdk}/share/android-sdk";
  };

  idx = {
    # Search for the extensions you want on https://open-vsx.org/ and use "publisher.id"
    extensions = [
      "Dart-Code.flutter"
      "Dart-Code.dart-code"
    ];
    workspace = {
      # Runs when a workspace is first created with this `dev.nix` file
      onCreate = { };
      # To run something each time the workspace is (re)started, use the `onStart` hook
    };
    # Enable previews and customize configuration
    previews = {
      enable = true;
      previews = {
        web = {
          command = ["flutter" "run" "-t" "lib/main_user.dart" "--machine" "-d" "web-server" "--web-hostname" "0.0.0.0" "--web-port" "$PORT"];
          manager = "flutter";
        };
        android = {
          # Simplified the command, as auto-detection should now work.
          command = ["flutter" "run" "-t" "lib/main_user.dart" "--machine" "-d" "android"];
          manager = "flutter";
        };
      };
    };
  };
}
