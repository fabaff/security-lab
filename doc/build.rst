.. build:

Create the Fedora Security Lab Live media
=========================================

The ​[How to create and use a Live CD page]() in the Fedora Project wiki outlines the steps which are needed to create a LiveCD. This page is about additional steps with a focus to create the Fedora Security Lab.

First create a clone of the Fedora Security Lab git repository.::

    $ git clone ​ssh://git.fedorahosted.org/git/security-spin.git

Make a clone of the [​Fedora Kickstarts repository](https://pagure.io/fedora-kickstarts) because the Fedora Security Lab kickstart file depends on files which are located there.

```bash
$ git clone git://git.fedorahosted.org/git/spin-kickstarts.git
```

Make a copy of the existing kickstart file and create a symlink to the spin-kickstart directory.

```bash
$ cp security-spin/fedora-livecd-security.ks security-spin/fedora-livecd-security-new.ks
$ ln -s security-spin/fedora-livecd-security-new.ks  spin-kickstarts/fedora-livecd-security-new.ks
```

Edit the new kickstart file till it fits your need.

Now you are ready to spin, but first set SELinux to permissive mode as root.

```bash
$ sudo setenforce 0
```

Spinning the Fedora Security Lab CD (as root).

```bash
$ sudo livecd-creator \
--verbose \
--config=../spin-kickstarts/fedora-livecd-security-new.ks \
--fslabel=FSL-LiveCD \
--cache=/var/cache/live
``

This will take some minutes to complete. If you don't want to type less, just use the ​fsl-maker helper script.
