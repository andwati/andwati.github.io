---
title : "Install PostgreSQL  on Arch | Manjaro | Garuda Linux"
description : "Getting PostgreSQL up and running on Arch Linux-based distros"
date : 2023-02-16 +0300
tags : ["postgresql", "archlinux", "manjaro", "garuda", "linux"]
---

# Overview

**PostgreSQL** is a powerful open-source relational database management system (RDBMS) that allows you to store and manage large amounts of data. It was first released in 1996 and has become one of the most popular RDBMSs in the world.


In this tutorial, we’ll look at how to install PostgreSQL on Arch Linux, Manjaro, Garuda Linux, or any other Arch-based distro out there.

# Why PostgreSQL?

Postgres offers a lot of advantages that make it an excellent choice for highly transactional environments regardless of application size and data volume. Its rich feature set and flexibility make it a popular choice for a wide range of applications and industries.

# Install PostgreSQL on Arch | Manjaro | Garuda Linux

Now with all that fluff out of the way, let's get to business. The steps have been tested on Arch Linux with the KDE desktop.

> **Note:** Commands that should be run as the *postgres* user are prefixed by `[postgres]$` in this article.

## Step 1: Installing the PostgreSQL Package

```sh
sudo pacman -Syu postgresql
```

This command will update the package database and update all packages on the system then install the PostgreSQL package from your distribution mirrors. Never install a package without updating the system first. On a rolling release, this can lead to an unbootable system. Installing the package will also create a system user called *postgres*. You can now switch to the *postgres* user using a privilege elevation program.

You can switch to the PostgreSQL user by executing the following command:

- If you have sudo and are in sudoers

  ```sh
  sudo -iu postgres
  ```

- Otherwise using su:

  ```sh
  su
  su -l postgres
  ```

## Step 2: Initial Configuration

Before PostgreSQL can function correctly, the database cluster must be initialized.

### 2.1 We can confirm the installed PostgreSQL version by running:

```sh
postgres --version                                                                           ─╯
postgres (PostgreSQL) 15.1
```

### 2.2 Set applicable entries in **/etc/locale.gen**

```sh
echo "en_US.UTF-8 UTF-8" | sudo tee /etc/locale.gen
```

### 2.3 Then run **\*\*locale-gen\*\*** to generate locale settings

```sh
sudo locale-gen
Generating locales...
  en_US.UTF-8... done
Generation complete.
```

### 2.4 Initialize Postgres Data Directory

You must first log in as the **postgres** user using the following command before you can initialize PostgreSQL’s data directory:

```sh
sudo su - postgres
```

### 2.5 With the following command, you can now initialize PostgreSQL’s data directory:

```sh
[postgres]$ initdb -D /var/lib/postgres/data
```

### Step 3: PostgreSQL Service Management

### 3.1 Check PostgreSQL status with the following command:

```sh
systemctl status postgresql                                                                  ─╯
 postgresql.service - PostgreSQL database server
     Loaded: loaded (/usr/lib/systemd/system/postgresql.service; disabled; preset: disabled)
     Active: inactive (dead)
```

### 3.2 Start the PostgreSQL service by running the following command:

```sh
sudo systemctl start postgresql
```

### 3.3 Enable the PostgreSQL service to start automatically at boot by running the following command:

```sh
sudo systemctl enable postgresql
```

### 3.4 Verify that PostgreSQL is running by running the following command:

```sh
sudo systemctl status postgresql                                                             ─╯
● postgresql.service - PostgreSQL database server
     Loaded: loaded (/usr/lib/systemd/system/postgresql.service; enabled; preset: disabled)
     Active: active (running) since Thu 2023-02-16 22:52:43 EAT; 20s ago
   Main PID: 26106 (postgres)
      Tasks: 6 (limit: 8790)
     Memory: 16.9M
        CPU: 113ms
     CGroup: /system.slice/postgresql.service
             ├─26106 /usr/bin/postgres -D /var/lib/postgres/data
             ├─26107 "postgres: checkpointer "
             ├─26108 "postgres: background writer "
             ├─26110 "postgres: walwriter "
             ├─26111 "postgres: autovacuum launcher "
             └─26112 "postgres: logical replication launcher "
```

### Change postgres user password

To change the postgres user password execute the following command:

```sh
sudo -u postgres psql -c "ALTER USER postgres PASSWORD '$PGPASSWORD';"
```

# Resources

- [Arch Linux Wiki](https://wiki.archlinux.org/title/PostgreSQL)
- [Wikipedia](https://en.wikipedia.org/wiki/PostgreSQL)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
