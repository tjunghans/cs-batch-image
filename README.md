# cs-batch-image

Batch image resize script

This script reads images out of a source directory and resizes to two sizes:

1. 1600x1600 (large)
2. 120x120 (small/thumbnail)

If a destination is not provided, the resized images are stored in 
`resized` which is created in the source directory.

The new images are renamed as well: img0001.jpg, img0002.jpg.

**Warning**: The script is very raw and serves only a specific use case. It
can of course be optimized by adding further options and checks. 
Back up images if you do use it.


## Requirements

- Bash shell
- [ImageMagic](http://www.imagemagick.org/script/index.php)


## Running the script

```
sh resize.sh --source /dir/images
```


## Command line options

- `--source` or `-s` is the path of the directory with the original images
- `--dest` or `-d` is the path of the directory where the converted images are saved to. If skipped, a directory named `resized-"timestamp"` is created in the source directory.
- `--help` or `-h` shows all commands
- `--dry` runs script without doing anything
- `--thumb-prefix` or `-t` specifies the prefix to add to the thumb nails. Defaults to `tn_`


