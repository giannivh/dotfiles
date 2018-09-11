from os.path import expanduser

home = expanduser("~")
offlineimap_location = "%s/.config/offlineimap" % home

def file_get_contents(filename):
    with open(filename) as f:
        return f.read()

def mailuser(account):
    path = "%s/imap-%s-user" % (offlineimap_location, account)
    return file_get_contents(path)

def mailpass(account):
    path = "%s/imap-%s-pass" % (offlineimap_location, account)
    return file_get_contents(path)