# Install

Based on https://toast.al/posts/techlore/2024-04-17_berkeley-mono-on-nixos/

## Steps

1. Download zip to this dir
2. Rename (if needed) to `berkeley-mono-$variant-$version`. For example:
   `berkeley-mono-ligaturesoff-0variant2-7variant0-1.009`
3. Run nix-hash

   ```sh
   nix-prefetch-url --type sha256 file://$PWD/berkeley-mono-ligaturesoff-0variant2-7variant0-1.009.zip
   ```

4. Update package with hash
5. Install/build

## Nerd fonts patch

1. Download and extract zip
2. Run nerd fonts patcher via a container

   ```sh
   docker run --rm \
   -v /path/to/berkeley-mono:/in \
   -v /path/to/berkeley-mono-patched:/out \
   nerdfonts/patcher -c --careful --progress -s -l --name filename
   ```

3. Create zip file. Rename (if needed) to `berkeley-mono-$variant-$version`. For
   example: `berkeley-mono-ligaturesoff-0variant2-7variant0-1.009`
4. Run nix-hash

   ```sh
   nix-prefetch-url --type sha256 file://$PWD/berkeley-mono-ligaturesoff-0variant2-7variant0-1.009.zip
   ```

5. Update package with hash
6. Install/build
