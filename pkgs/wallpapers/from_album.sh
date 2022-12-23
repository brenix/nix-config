#!/usr/bin/env nix-shell
#!nix-shell -i bash -p jq curlie

function fetch_image() {
  image=$1

  name=$(echo $image | cut -d '|' -f 1)
  ext=$(echo $image | cut -d '|' -f 2 | cut -d '/' -f 2)
  id=$(echo $image | cut -d '|' -f 3)
  sha256=$(nix-prefetch-url https://i.imgur.com/$id.$ext)

  echo "  {"
  echo "    name = \"$name\";"
  echo "    ext = \"$ext\";"
  echo "    id = \"$id\";"
  echo "    sha256 = \"$sha256\";"
  echo "  }"
}

album="QA1WK3e" # https://imgur.com/a/QA1WK3e
clientid="770bc1a0ce2b5ea"

result=$(curlie https://api.imgur.com/3/album/$album -H Authorization:"Client-ID $clientid")
images=$(echo $result | jq -r '.data.images[] | "\(.description)|\(.type)|\(.id)"')

echo "["
while read -r image; do
  fetch_image $image &
  sleep 0.5
done <<<"$images"
wait
echo "]"
