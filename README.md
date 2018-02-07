# O2 Deployment of useful modules and tools

## Modules

Several additional modules for O2 are available.

* ashlar
* stitcher
* omero-scripts


## Install Instructions

Making use of these modules requires adding the path to the custom modules to
your `MODULEPATH` on O2. This can be accomplished easily by adding the following
line to your `~/.bashrc` on O2.

```bash
export MODULEPATH=$MODULEPATH:/n/groups/lsp/o2/modulefiles
```

After adding this (and starting a new shell), modules will be permanently
available in your O2 account.


## Example Usage in CycIF

Load and use the `ashlar` and `stitcher` modules to stitch and register CycIF
images and then generate pyramids as an OME-tiff, ready for import to OMERO.

0. Obtain flat-field images by imaging specially-prepared slides or using the
  CIDRE algorithm on existing datasets (tools forthcoming).
1. Use `mosaic` command from ASHLAR to stitch and register images.
2. Use `stitcher` command from Glencoe Software's stitcher to generate pyramids.
3. Import pyramid into OMERO.

### Steps 2 and 3:

```bash
# Load the ashlar and stitcher modules
module load ashlar stitcher

# Use ashlar to stitch and register the images in the given `scan_path`.
ashlar <scan_path> [--ffp <flat_field_path>]

# Create pyramids for the given `./scan*` directory and output as
# `dataset-name`.tif, merging the channels into one file.
stitcher create_pyramid --input ./scan* --output <dataset_name>.tif \
  --mergeChannels

# Clean up (logging out will also accomplish this)
module unload ashlar stitcher
```

### Step 3

```bash
# Load the omero module
module load omero

# Import a file or (recursively) a directory
omero import <file_or_dir>

# Clean up (logging out will also accomplish this)
module unload omero
```
