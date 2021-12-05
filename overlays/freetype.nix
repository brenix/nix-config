self: super:
{
  freetype = super.freetype.overrideAttrs (oldAttrs: {
    patches = (oldAttrs.patches or []) ++ [
      (super.fetchpatch {
        url = "https://gist.githubusercontent.com/brenix/bf63a85755391a52b8c885d0bf77fb10/raw/a9914cb653efce1e6ce2c0b7cb288c97de547cfc/freetype2-cleartype.patch";
        sha256 = "bbe98fce02d3e77a2092afb327ebca5dfd675a4d04a5409170cdce2525e73494";
      })
    ];
  };
}
