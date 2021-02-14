# Whonix Packer

We explore containerized, build-described, etc. deployment options for Whonix with the goal of making Whonix deployable in any project. The current big challenge is creating a working Whonix Dockerfile. Along the way, we're also defining some other deployments via Packer (Which
also supports Docker).

## Milestones

- [ ] Whonix-gateway-cli in Docker.
- [ ] Whonix-workstation-cli in Docker.
- [ ] Whonix-gateway-cli in Vagrant.
- [ ] Whonix-workstation-cli in Vagrant.
- [ ] Whonix-gateway-cli in KVM.
- [ ] Whonix-workstation-cli in KVM.
- [ ] A Whonix Chef recipe.
- [x] Define provisioner for Whonix deployment to DigitalOcean *droplets*.
- [ ] New Packer provisioner supporting the DigitalOcean App Platform.
- [ ] Packer builder for KVM.
- [ ] Packer builder for LXC.

## Related Repos

[Docker-Whonix](https://github.com/TensorTom/Docker-Whonix) - Trying to come up with a working Dockerfile.

[Dockernymous](https://github.com/bcapptain/dockernymous) - Not the same goals (Not exactly Whonix) but still helpful.
