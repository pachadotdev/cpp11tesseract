#!/bin/sh
set -e

prepare_pacman(){
  cp -f pacman.conf /etc/pacman.conf
  pacman -Scc --noconfirm
  pacman -Syy --noconfirm
}

arch_prefix(){
  echo "$@" | sed "s/[^ ]*/mingw-w64-${arch}-&/g"
}

skip_args(){
  echo "$@" | sed "s/[^ ]*/--assume-installed=mingw-w64-${arch}-&=99.99/g"
}

download_libs(){
  pkg=$(arch_prefix $package)
  version=$(pacman -Si $pkg  | grep -m 1 '^Version' | awk '/^Version/{print $3}' | cut -d '-' -f1)
  skiplist=$(skip_args gcc-libs libiconv libwinpthread-git libwinpthread)
  echo "Bundling: $pkg $version"
  #echo "Skiplist: $skiplist"

  # Check if version already exists
  tagurl="https://github.com/pachadotdev/tesseract/releases/tag/$package-$version"
  status=$(curl -sSLIw '%{http_code}' -o /dev/null $tagurl);
  if [ "$status" = "404" ]; then
    echo "Tag does not exist yet. Good."
  else
    echo "Tag already exists: $tagurl"
    if [ "$overwrite" = "true" ]; then
      echo "Overwriting as requested"
    else
      exit 1
    fi
  fi

  # Find dependencies
  if [ "$deps" ]; then
    pkgdeps=$(arch_prefix $deps)
    URLS=$(pacman -Spdd $pkg $pkgdeps --cache=$OUTPUT)
  else
    URLS=$(pacman -Sp $pkg $skiplist --cache=$OUTPUT)
    #pkgdeps=$(pacman -Si $pkg --assume-installed="$skip" | grep -m 1 'Depends On' | grep -o 'mingw-w64-[_.a-z0-9-]*' || true)
  fi

  # Prep output dir
  bundle="$package-$version-$arch"
  dist="$PWD/dist"
  rm -Rf $bundle
  mkdir -p $dist $bundle/lib

  # Tmp download dir
  OUTPUT=$(mktemp -d)
  for URL in $URLS; do
    curl -OLs $URL
    FILE=$(basename $URL)
    echo "Extracting: $FILE"
    echo " - $FILE" >> $bundle/files.md
    tar xf $FILE -C ${OUTPUT}
    unlink $FILE
  done

  # Extract files
  cp -Rv ${OUTPUT}/*/include $bundle/
  #rm -f ${OUTPUT}/*/lib/*.dll.a
  find ${OUTPUT}/*/lib -name \*.dll.a -delete;
  #cp -v ${OUTPUT}/*/lib/*.a $bundle/lib/
  find ${OUTPUT}/*/lib -name \*.a -exec cp -v {} $bundle/lib/ \;
  cp -Rf ${OUTPUT}/*/lib/pkgconfig $bundle/lib/ || true

  # Copy xtra files
  if [ "$extra_files" ]; then
    for file in $extra_files; do
      mkdir -p $(dirname $bundle/${file})
      cp -Rv ${OUTPUT}/*/${file} $bundle/${file}
    done
  fi
  tar -cJ --no-xattrs -f "$dist/$bundle.tar.xz" $bundle
  rm -Rf $bundle
}

create_bundles() {
  prepare_pacman
  arch="ucrt-x86_64" download_libs
  arch="clang-x86_64" download_libs
  arch="clang-aarch64" download_libs

  # Set success variables
  if [ "$GITHUB_OUTPUT" ]; then
    echo "version=$version" >> $GITHUB_OUTPUT
  fi
}
