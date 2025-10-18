{ config, pkgs, lib, ... }:
let
  gdk = pkgs.google-cloud-sdk.withExtraComponents( with pkgs.google-cloud-sdk.components; [
    gke-gcloud-auth-plugin
  ]);

  pythonWithPackages = pkgs.python3.withPackages (pp: with pp; [
    pip
    urllib3
    deepmerge
    chardet
    idna
    certifi
    apipkg
    ruamel_yaml
    pyyaml
    pytest
    requests
    gitpython
    pygithub
    python-dotenv
  ]);

  fortio = with pkgs; buildGoModule rec {
	pname = "fortio";
	version = "1.63.7";

	src = fetchFromGitHub {
	  rev = "v${version}";
	  owner = "fortio";
	  repo = "fortio";
	  sha256 = "sha256-KIxHBBWKH9Y4R0O1DjupmWPl1z2jjC4v1zF06v4y9Rs=";
	};

	vendorHash = "sha256-ClI9R4u2O3GXJCEN3QSAIAm/y8Jpqzyt4LdDGhSJYUM=";

	doCheck = false;

	meta = with lib; {
	  description = "Fortio istio benchmarking app";
	  homepage = "https://github.com/fortio/fortio";
	};
  };
  #pkg2503 = import <nixpkgs-25-03> {};
in
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "svij";
  home.homeDirectory = "/home/svij";
  home.packages = with pkgs; [
	sbt
    awscli
    docker-compose
    kubernetes-helm
    kubectl
    #go-jira
    circleci-cli
    tilt
    terraform
    dos2unix
    mercurial
    yq
    kustomize
    #newrelic-cli
    mysql-client
    iptables
    # bug in frontgate test suit
    # https://github.com/hapijs/hapi/issues/4298
    #nodejs-14_x
    nodejs_20
    binutils
    kind
    gh
    php
    jira-cli-go
    siege
    wrk
    crane
    conntrack-tools
    luajitPackages.luacheck
    tcpdump
    go
    dig
    terragrunt
    istioctl
    goose-cli
  ] ++ [ gdk pythonWithPackages fortio ];

  # This determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  home.sessionVariables = {
  	PYTHONPATH = "${pythonWithPackages}/${pythonWithPackages.sitePackages}";
  };
}
