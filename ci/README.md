# CI-build utilities


## Create release for Ubuntu Launchpad

For a new release a git-tag is needed. It must have the format `v0.0.0`.
Usually the conventional commit approach is used for the versioning.

To prepare a new release on `debian/main` run
1. `git checkout debian/main`
2. Ensure to be up to date `git pull`
3. `./ci/docker-run.sh ./ci/create_debian_release.sh <x.y.z>`
4. Push **debian/main** , not *main* and not *integration*!
5. Push **pristine-tar**
6. Wait until automatic builds on
   https://launchpad.net/~elos-team/+archive/ubuntu/dev fetched and build the
   new package.
