package() {
  package=$1
  if [ -z "$package" ]; then
    echo "Usage: Package <name>"
  elif [[ ! $package =~ ^[a-zA-Z0-9_\-]+$ ]]; then
    echo "package $package is invalid"
  else
    respone=$(curl "https://aur.archlinux.org/packages/$package")
    if [[ "$respone" != *"<title>AUR (en) - Not Found</title>"* ]]; then
      echo "Installing package $package..."
      start=${pwd}
      if [ ! -d "/tmp/packages" ]; then
        mkdir /tmp/packages
      fi
      cd /tmp/packages
      if [ ! -d "$package" ]; then
        git clone "https://aur.archlinux.org/$package.git"
      fi
      cd $package
      makepkg -i -s
      cd ..
      rm -rf $package
      cd $start
    else
      echo "Package $package not found on AUR"
    fi
  fi
}
