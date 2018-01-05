# Dotfiles

This dotfiles have my installation instruction for Arch Linux and the
configuration for my essential programs. The *master* branch contains a
configuration for Linux programs and the *OSX* branch contains instruction to
configure OSX programs such as mutt, offlineimap, pass.

I keep these dotfiles at `~/.dotfiles/` and I create softlinks to the dotfiles
at `$HOME` using `create_links.sh`.

# OSX conf

```bash
brew install caskroom/cask/iterm2;
brew install tmux ranger mutt vim offlineimap pass notmuch msmtp openssh ctags gpg-agent w3m;
mkdir ~/.dotfiles;
git clone https://github.com/cristianpb/dotfiles.git ~/.dotfiles
vim -cmd "+PromptlineSnapshot! .shell_prompt.sh airline" +qall
brew tap caskroom/fonts
brew cask install font-inconsolata-nerd-font
pip install -U mutt_ics urlscan
```

## gpg keys

```bash
gpg --list-keys
cp ~/.dotfiles/gpg-agent.conf .gnupg/gpg-agent.conf
gpg --import XXX.asc
gpg --import XXX.gpg
```

## Pass

* Initiate pass with gpg key
```
pass init B212E65B
```
* Insert passwords
```
pass insert Mail/Gmail
pass insert Mail/Kernix
```

## Offlineimap

```python
# .offlineimaprc
ssl=true
sslcacertfile = /usr/local/etc/openssl/cert.pem
```

## Notmuch for mac

### Install perl

```sh
$ brew install perl && brew link perl --force
$ brew install cpanm
```

### Add perl module paths

```
# .zshrc

# Include ~/.bin in the path
export PATH="$HOME/.bin:/usr/local/bin:$PATH"

# Point perl to local modules
export PERL_LOCAL_LIB_ROOT="$HOME/perl5"
export PERL5LIB="$PERL_LOCAL_LIB_ROOT/lib/perl5"
export PERL_MB_OPT="--install_base \"$PERL_LOCAL_LIB_ROOT\""
export PERL_MM_OPT="INSTALL_BASE=$PERL_LOCAL_LIB_ROOT"
export PATH="$PERL_LOCAL_LIB_ROOT/bin:$PATH";
```

### Install notmuch-mutt script dependencies

```sh
cpanm Digest::SHA\
  Mail::Box\
  Mail::Header\
  Mail::Box::Maildir\
  String::ShellQuote\
  Term::ReadLine::Gnu
```

### Fetch notmuch-mutt script and edit for OS X compatability

```sh
$ mkdir ~/.bin
$ cd ~/.bin && wget http://git.notmuchmail.org/git/notmuch/blob_plain/HEAD:/contrib/notmuch-mutt/notmuch-mutt
$ vi notmuch-mutt
```

```diff
--- a/bin/notmuch-mutt
+++ b/bin/notmuch-mutt
@@ -52,7 +52,7 @@ sub search($$$) {
     empty_maildir($maildir);
     system("notmuch search --output=files $dup_option $query"
 	   . " | sed -e 's: :\\\\ :g'"
-	   . " | xargs -r -I searchoutput ln -s searchoutput $maildir/cur/");
+	   . " | xargs -I searchoutput ln -s searchoutput $maildir/cur/");
 }

 sub prompt($$) {
--
```

```
$ chmod +x notmuch-mutt
$ cd ~/.mutt && wget http://git.notmuchmail.org/git/notmuch/blob_plain/HEAD:/contrib/notmuch-mutt/notmuch-mutt.rc
```

* Optional

```
# .mutt/muttrc
source ~/.mutt/notmuch-mutt.rc
```

* Initiate notmuch

```
notmuch
```

* Then open mutt and open a search with `<F8>`.

## Python install

Install python3 and ensure that you have the lastest pip version. Install 
jupyter notebook and add the python2 kernel.

```bash
brew install python3
pip3 install --upgrade pip
pip3 install jupyter
python2 -m pip install ipykernel
python2 -m ipykernel install --user
```

## Ranger

* Change preview method to iterm2

* Install imagemagick (convert) and poppler (pdftoppm) to obtain preview for 
  images, pdf et svg

```
brew install imagemagick
brew install poppler --with-splash-output
```
