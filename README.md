# myenv
Needed to get my repo up and running

Generate a new SSH key for a new machine
```bash
$ ssh-keygen -t rsa -b 4096 -C "identified here"
```

Quickly add new SSH key to keys
```bash
$ eval "$(ssh-agent -s)"
$ ssh-add ~/.ssh/yourkeyhere
```

Add new SSH key to github profile

###### Choco Related:
1. Set-ExecutionPolicy AllSigned; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
2. Install the following packages:
    - 7zip
    - bind-toolsonly
    - exiftool
    - freetube
    - git
    - jq
    - packer
    - powershell-core
    - putty
    - sdelete
    - sysinternals
    - vagrant
    - virtualbox
    - virtualbox-guest-additions-guest.install
    - wget
    - winscp
    - yt-dlp
3. Pin the following choco packages:
    - choco pin add -n=vagrant --version 2.4.1
    - choco pin add -n=virtualbox --version 7.0.14
    - choco pin add -n="virtualbox-guest-additions-guest.install" --version 7.0.14
4. Install cinc-workstation:
    - . { iwr -useb https://omnitruck.cinc.sh/install.ps1 } | iex; install -project cinc-workstation -version 23

###### Git Related:
**Setup new git config**

    - git config --global user.email "email@address.something"
    - git config --global user.name "Some UserName"
    - git config --global credential.helper 'cache --timeout=3600'
    - git config --global color.ui auto
    - git config --global core.editor vim
    - git config --list


**Building a new repo (from web):**

1. Create a repo on Git.

2. Create a new folder on your workstation (ie. /home/user/repo/).

3. Add content.

4. git init
```
 $ git init
 Initialized empty Git repository in /home/user/repo/.git/
```

5. git add -f .

6. git commit -am 'Initial commit for repo.'
```
 $ git commit -am 'Initial commit for repo.'
 [master (root-commit) 70d1abe] Initial commit for repo
 2 files changed, 19 insertions(+)
 create mode 100644 LICENSE
 create mode 100644 README.md
```

7. git remote add origin https://github.com/user/repo.git

8. git push -u origin master
```
 $ git push -u origin master
 Username for 'https://github.com': user
 Password for 'https://user@github.com': <github access token>
 Counting objects: 4, done.
 Compressing objects: 100% (3/3), done.
 Writing objects: 100% (4/4), 810 bytes | 810.00 KiB/s, done.
 Total 4 (delta 0), reused 0 (delta 0)
 To https://github.com/user/repo.git
  * [new branch]  master -> master
 Branch master set up to track remote branch master from origin.
```

**Changing Remote URL**
```bash
$ git remote -v
> origin  https://github.com/USERNAME/REPOSITORY.git (fetch)
> origin  https://github.com/USERNAME/REPOSITORY.git (push)
$ git remote set-url origin git@github.com:USERNAME/REPOSITORY.git
$ git remote -v
# Verify new remote URL
> origin  git@github.com:USERNAME/REPOSITORY.git (fetch)
> origin  git@github.com:USERNAME/REPOSITORY.git (push)
```


**chroot troubleshooting**

1. Determine the root partition. Mount the partition.
```
 $ fdisk -l
 $ mount /dev/sda1 /mnt/myroot
```

2. Mount the following virtual directories.
```
 $ mount -o bind /dev /mnt/myroot/dev
 $ mount -o bind /proc /mnt/myroot/proc
 $ mount -o bind /sys /mnt/myroot/sys
```

3. Change your root!
```
 $ chroot /mnt/myroot /bin/bash
 $ mount /boot
```
