if [[ $commands[convert] ]]; then
  add-cover-label() {
    local image=${1:?'Image file not defined in $1'}
    local label=${2:?'Image label not defined in $2'}
    local fontsize=${3:-42}

    # resize image
    convert "${image}" \
      -resize "600x600^" \
      -crop 600x600+0+0 +repage \
      -quality 100 \
      "${image%.*}-resized.jpg"

    # add label
    convert -background white \
      -gravity east \
      -geometry +0+87 \
      -fill black \
      -pointsize ${fontsize} \
      -font Inter-Semi-Bold \
      -size 540x95 caption:"${label}\ \ " \
      "${image%.*}-resized.jpg" \
      +swap \
      -gravity southwest \
      -composite \
      "${image%.*}-labeled.jpg"

    rm -f "${image%.*}-resized.jpg"
    rm -f "${image%.*}-labeled-0.jpg"
    rm -f "${image%.*}-labeled-1.jpg"
  }
fi
