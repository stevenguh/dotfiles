#!/usr/bin/env bash

function backup_dotfiles() {
  if ! command -v rsync > /dev/null 2>&1; then
    echo "rsync command does not exist."
    return 1;
  fi

  function backup_rsync() {
    rsync \
      --exclude ".git/" \
      --exclude ".DS_Store" \
      --include "/.**" \
      --exclude "*" \
      --existing \
      --itemize-changes \
      -ah --no-perms $1 ~/ .
  }

  backup_rsync '--dry-run'
	read -p "Do you want to backup those files to your dotfiles? (y/n) " -n 1
	echo ""
	if [[ $REPLY =~ ^[Yy]$ ]]; then
    backup_rsync
	fi

  unset -f backup_rsync
}

function backup_homebrew() {
	read -p "Do you want to backup your Homebrew bundle? (y/n) " -n 1
	echo ""
	if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Backing up Homebrew bundle..."
    brew bundle dump --no-lock --file=./macos/Brewfile --force
  fi
}

function main() {
  backup_dotfiles

  if [[ "$OSTYPE" == "darwin"* ]]; then
    if command -v brew > /dev/null 2>&1; then
      backup_homebrew
    fi
  fi
}

main

unset -f backup_dotfiles
unset -f backup_homebrew
unset -f main