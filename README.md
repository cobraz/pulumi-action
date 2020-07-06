# Pulumi Action for Node.js

This Github Actions docker image is based on the new [pulumi/pulumi-nodejs](https://hub.docker.com/r/pulumi/pulumi-nodejs). An alternative to the Pulumi docker image.

The problem I am having is that [pulumi/actions](https://hub.docker.com/r/pulumi/actions) are very heavy, because it leverages the Pulumi docker image and not these smaller new ones. The Pulumi docker image is ~800mb, this is ~150mb and should work just the same.

**IMPORTANT:** This Docker image is at an early stage and not yet used in production. We do not offer support for this. Feel free to play around, but for full functionality and support, please wait for the supported, stable release. Our intentions are to propose changes to the original Pulumi Docker files to incorporate the needs this repository fixes.