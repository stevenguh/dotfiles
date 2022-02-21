#!/usr/bin/env bash

function restore_dotfiles() {
  if ! command -v rsync > /dev/null 2>&1; then
    echo "rsync command does not exist."
    return 1;
  fi

  function restore_rsync() {
    rsync \
      --exclude ".git/" \
      --exclude ".DS_Store" \
      --include "/.**" \
      --exclude "*" \
      --itemize-changes
      -ah --no-perms $1 ./ ~
  }

  restore_rsync '--dry-run'
	read -p "Do you want to restore those files to your home? (y/n) " -n 1
	echo ""
	if [[ $REPLY =~ ^[Yy]$ ]]; then
    restore_rsync
	fi

  unset -f restore_rsync
}

function restore_homebrew() {
	if ! command -v brew > /dev/null 2>&1; then
		echo "Installing Homebrew..."
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	fi

	# Update Homebrew recipes
  echo "Updating Homebrew..."
	brew update

	# Install all our dependencies with bundle (See Brewfile)
  echo "Installing Homebrew bundle..."
  brew bundle --file=./macos/Brewfile
}

function restore_macos() {
	read -p "Do you want to restore homebrew? (y/n) " -n 1
	echo ""
	if [[ $REPLY =~ ^[Yy]$ ]]; then
    # Restore homebrew
    restore_homebrew
	fi

	read -p "Do you want to restore macOS settings? (y/n) " -n 1
	echo ""
	if [[ $REPLY =~ ^[Yy]$ ]]; then
    # Restore system defaults
    ./macos/defaults.sh
	fi
}

function main() {
  # Restore dotfiles
  restore_dotfiles

  if [[ "$OSTYPE" == "darwin"* ]]; then
    restore_macos
  fi
}

main

unset -f restore_dotfiles
unset -f restore_homebrew
unset -f restore_macos
unset -f main
