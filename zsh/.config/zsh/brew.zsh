fix-brew() {
   unset SSL_CERT_FILE
}

alias brewit='brew update && brew update && fix-brew && brew upgrade --ignore-pinned && brew cleanup && brew doctor'