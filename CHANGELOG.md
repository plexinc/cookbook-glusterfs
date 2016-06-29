Changelog
=========

1.1.0
-----

Main:

- Set default version to 3.8 and update yum repos
- Add possibility of giving options to client mount
- Fix default search in cookbook
- Fix probe provider when peer status returns ip

Tests:

- Fix CI config on removing previous containers
- Strengthen gitlab-ci tests, use image directly
- Add retries on package installation
- Remove last node from "helpers" (work with -c)

1.0.0
-----

Initial version with Centos 7 support:

- create GlusterFS volumes (does not format drives)
- mount GlusterFS volumes with fuse driver
