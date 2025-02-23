# Managing container images
## Exercise 26-2


### Step 1: Inspect a container image.

Check which registries are currently used in your system.

> The `-A 10` option in the following grep command displays the matched line and 10 lines after the match (-A = after).

```bash
podman info | grep -A 10 registries
# Output:

# registries:
#   search:
#   - registry.access.redhat.com
#   - registry.redhat.io
#   - docker.io
# store:
#   configFile: /etc/containers/storage.conf
#   containerStore:
#     number: 4
#     paused: 0
#     running: 2
```

Search in the Red Hat registry for all UBI images.

```bash
podman search registry.access.redhat.com/ubi
# Output: 

# NAME                                                DESCRIPTION
# registry.access.redhat.com/ubi8/go-toolset          Platform for building and running Go 1.11.5...
# registry.access.redhat.com/ubi8/dotnet-70-runtime   rhcc_registry.access.redhat.com_ubi8/dotnet-...
# registry.access.redhat.com/ubi8/dotnet-90-runtime   rhcc_registry.access.redhat.com_ubi8/dotnet-...
# registry.access.redhat.com/ubi7                     The Universal Base Image is designed and eng...
# registry.access.redhat.com/ubi8/dotnet-70           rhcc_registry.access.redhat.com_ubi8/dotnet-...
# ...
```

Inspect an image with **skopeo**. Examine the output.

```bash
skopeo inspect docker://registry.access.redhat.com/ubi9

# Output: 

# {
    # "Name": "registry.access.redhat.com/ubi9",
    # "Digest": "sha256:53d6c19d664f4f418ce5c823d3a33dbb562a2550ea249cf07ef10aa063ace38f",
    # "RepoTags": [
    #     "9.0.0",
    #     "9.0.0-1468",
    #     "9.0.0-1468.1655190709",
    #     "9.0.0-1468.1655190709-source",
    #     "9.0.0-1468-source",
```

Pull the image.

```bash
podman pull registry.access.redhat.com/ubi9
# Output:

# Trying to pull registry.access.redhat.com/ubi9:latest...
# Getting image source signatures
# Checking if image destination supports signatures
# Copying blob ec465ce79861 done   | 
# Copying blob facf1e7dd3e0 done   | 
# Copying config 4d9d358589 done   | 
# Writing manifest to image destination
# Storing signatures
# 4d9d3585895106bd08273429983b91f401339b921cf03c6ecfaaffc8a40b2ad5
```

Verify the image is locally available.

```bash
podman images
# Output:

# REPOSITORY                       TAG         IMAGE ID      CREATED       SIZE
# registry.access.redhat.com/ubi9  latest      4d9d35858951  3 days ago    234 MB
# docker.io/library/nginx          latest      f876bfc1cc63  6 weeks ago   196 MB
# docker.io/library/busybox        latest      af4709625109  3 months ago  4.52 MB
```

Inspect the image with *podman* and look for the command that is started by the image.

```bash
podman inspect registry.access.redhat.com/ubi9
# Output:

# [
    #  {
    #       "Id": "4d9d3585895106bd08273429983b91f401339b921cf03c6ecfaaffc8a40b2ad5",
    #       "Digest": "sha256:c1154105be5991313d18b6d4e7e8c8009c74d4b51ee748872d2b279de15c1af2",
    #       "RepoTags": [
    #            "registry.access.redhat.com/ubi9:latest"
    #       ],
    #       "RepoDigests": [
    #            "registry.access.redhat.com/ubi9@sha256:53d6c19d664f4f418ce5c823d3a33dbb562a2550ea249cf07ef10aa063ace38f",
    #            "registry.access.redhat.com/ubi9@sha256:c1154105be5991313d18b6d4e7e8c8009c74d4b51ee748872d2b279de15c1af2"
    #       ],
    #       "Parent": "",
    #       "Comment": "",
    #       "Created": "2025-01-09T06:37:11.783912772Z",
    #       "Config": {
    #            "Env": [
    #                 "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
    #                 "container=oci"
    #            ],
    #            "Cmd": [
    #                 "/bin/bash"
    #            ],
```

In the output, we can see that the **Cmd** is `/bin/bash`.


---