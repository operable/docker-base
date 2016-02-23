# Operable Base Image

This is the Docker base image for Operable's projects. It's built from Debian Jessie and has some basic dependencies installed from the public Debian repository. 

In addition, there are a number of Operable-built packages that are included because of requirements on versions that are not available in the distribution repo. At this time, those packages include:

- Erlang 18.2.2
- Elixir 1.2.0
- libsodium 1.0.8
- Goon 1.1.1

These packages are all pulled from Operable's public Debian repository at PackageCloud:
https://packagecloud.io/operable/deps
