# <a href="https://github.com/giannivh/dotfiles">giannivh/dotfiles</a>

My personal dotfiles. I use GNU stow to manage them. 

## Installation

Go to your home directory

`$ cd`

Clone the repo

`$ git clone https://github.com/giannivh/dotfiles .dotfiles`

*Important: in order for stow to work, the repo needs to be cloned in the `$HOME` directory!*

Some dotfiles require scripts in `~/.scripts`, so stow them first:

```
$ cd .dotfiles
$ stow scripts
```

Make sure `~/.scripts` is inside your `$PATH`.

## Usage

Go to the dotfiles directory

`$ cd .dotfiles`

Install in $HOME (for example, tmux)

`$ stow tmux`

Uninstall from $HOME (for example, tmux)

`$ stow -D tmux`

## Dotfiles explained

If any of my dotfiles requires some info, it's explained below.

### ZSH

The config sources `~/Private/zsh/**/*.zsh`. I store my project specific aliases and other stuff I don't want to have public.

### VIM

Needs:

- Python3
- VIM >= 8 with python3: `:echo has('python3')` must return `1`
- Neovim python3 interface: `pip3 install neovim`
- Exuberant ctags >= 5.5

All plugins will be installed when you start VIM for the first time. I use vim-plug.

### Mails

I use the following setup:

- GPG
- Offlineimap
- Notmuch
- Neomutt

#### Encryption

I use my YubiKey to encrypt my email addresses and passwords. 

For offlineimap, the encrypted files are stored in `~/Private/offlineimap`, and a tree looks like this:

```
$ tree
.
├── imap-mailinglist-pass.gpg
├── imap-mailinglist-user.gpg
├── imap-personal-pass.gpg
├── imap-personal-user.gpg
├── imap-work-pass.gpg
└── imap-work-user.gpg

0 directories, 6 files
```

See `offlineimap/.offlineimap.py` on how the decryption is done.

For neomutt, the account configuration files and encrypted files are stored in `~/Private/neomutt`, and a tree looks like this:

```
$ tree
.
├── addresses
├── neomutt.account.mailinglist
├── neomutt.account.mailinglist.credentials.gpg
├── neomutt.account.personal
├── neomutt.account.personal.credentials.gpg
├── neomutt.account.work
├── neomutt.account.work.credentials.gpg
└── signature_work.html

0 directories, 8 files
```

The `neomutt.account.mailinglist` file contains the configuration for neomutt, whereas the `neomutt.account.mailinglist.credentials.gpg` file contains the encrypted email address and password for that account. There's an example configuration file for Gmail in `neomutt/.config/neomutt/neomutt.account.example`.

To create the GPG encrypted files, I use the following command:

```
$ gpg --recipient 0123456789 --encrypt --armor > neomutt.account.example.credentials.gpg
set my_user="example@gmail.com"
set my_pass="abc123"
<ctrl+d>
```

Replace `0123456789` with your key ID.
