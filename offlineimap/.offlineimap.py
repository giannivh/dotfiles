import subprocess
from os.path import expanduser

home = expanduser("~")
offlineimap_location = "%s/Private/offlineimap" % home

def decrypt(filename):
    return subprocess.check_output(["gpg", "--quiet", "--batch", "--decrypt", filename]).strip()

def mailuser(account):
    path = "%s/imap-%s-user.gpg" % (offlineimap_location, account)
    return decrypt(path)

def mailpass(account):
    path = "%s/imap-%s-pass.gpg" % (offlineimap_location, account)
    return decrypt(path)