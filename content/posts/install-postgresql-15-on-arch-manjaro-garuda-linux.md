+++
title ="Install PostgreSQL 15 on Arch | Manjaro | Garuda Linux"
description = "Installing postgresql"
date = 2023-02-16T15:34:14.160Z
[taxonomies]
tags = ["postgresql", "archlinux", "manjaro", "garuda", "linux"]
+++

Getting PostgreSQL up and running on Arch Linux-based distros

<!-- more -->

# Overview

**PostgreSQL** is a powerful open-source relational database management system (RDBMS) that allows you to store and manage large amounts of data. It was first released in 1996 and has become one of the most popular RDBMSs in the world.

PostgreSQL is designed to handle high levels of **concurrency**, providing features such as **MVCC (multi-version concurrency control)** that allow multiple users to access the same data simultaneously without conflicts. It is also **highly extensible**, with a large number of third-party extensions and libraries available that can be used to add functionality to the core database.

Some of the key features of PostgreSQL include support for **complex SQL queries**, **advanced indexing** and **query optimization**, **transactional integrity**, and support for a **wide range of programming languages** and development frameworks.PostgreSQL is used by a wide range of organizations, from small businesses to large enterprises, and is particularly popular in industries such as finance, healthcare, and e-commerce, where high levels of data security and reliability are critical.

In this tutorial, we’ll look at how to install PostgreSQL 15 on Arch Linux, Manjaro, Garuda Linux, or any other Arch-based distro out there.

# PostgreSQL use cases

- **E-commerce websites:** PostgreSQL is a popular choice for e-commerce websites because it can handle large amounts of data and supports complex queries. It is used for product catalogs, order management, customer data, and more.
- **Financial institutions:** PostgreSQL is used in financial institutions to store and manage transactional data, such as stock trades, bank transfers, and credit card transactions. It is highly secure and provides features such as transactional integrity and data encryption.
- **Healthcare industry:** PostgreSQL is used in the healthcare industry to store patient data, such as medical records and diagnostic test results. It is also used for research purposes, where large amounts of data need to be stored and analyzed.
- **Government agencies:** PostgreSQL is used by government agencies for a variety of purposes, including managing large datasets, storing and analyzing census data, and managing public health information.
- **Mobile and web applications:** PostgreSQL is often used as a back-end database for mobile and web applications. It provides reliable data storage and retrieval and supports a wide range of programming languages and development frameworks.
- **Geospatial applications:** PostgreSQL has built-in support for geospatial data and is often used for applications that require location-based data, such as mapping and GPS tracking.

# Why PostgreSQL?

Postgres offers a lot of advantages that make it an excellent choice for highly transactional environments regardless of application size and data volume. Its rich feature set and flexibility make it a popular choice for a wide range of applications and industries. Some of the top features are:

- **ACID Compliance:** PostgreSQL is ACID (Atomicity, Consistency, Isolation, Durability) compliant, which means it provides high reliability, consistency, and data integrity, even in the presence of hardware failures, power outages, and other system errors.
- **Extensibility:** PostgreSQL is highly extensible, allowing developers to add new data types, operators, and functions using its extension framework. This makes it easy to customize PostgreSQL to meet the specific needs of your application.
- **Concurrency:** PostgreSQL provides a high level of concurrency, allowing multiple users to access the same data at the same time without conflicts. It uses a Multi-Version Concurrency Control (MVCC) model that enables fast and reliable access to data, even under heavy load.
- **Full-text search:** PostgreSQL provides a powerful full-text search engine that supports advanced search capabilities, such as stemming, ranking, and relevance matching.
- **Advanced indexing:** PostgreSQL provides a wide range of indexing options, including B-tree, Hash, GiST, SP-GiST, GIN, and BRIN. These indexing options allow developers to optimize database performance for their specific use cases.
- **JSON support:** PostgreSQL provides native support for storing and querying JSON data, making it easy to work with modern web and mobile applications that rely on JSON for data exchange.
- **Security:** PostgreSQL provides a high level of security, with features such as SSL support, client authentication, and role-based access control. It also provides encryption for both data at rest and data in transit.
- **Scalability:** PostgreSQL is designed to scale horizontally and vertically, allowing you to add more nodes to a cluster or increase the resources of a single node to handle more load.

# Install PostgreSQL on Arch | Manjaro | Garuda Linux

Now with all that fluff out of the way, let's get to business. The steps have been tested on Arch Linux with the KDE desktop.

> **Note:** Commands that should be run as the *postgres* user are prefixed by `[postgres]$` in this article.

## Step 1: Installing the PostgreSQL Package

```sh
$ sudo pacman -Syu postgresql
```

This command will update the package database and update all packages on the system then install the PostgreSQL package from your distribution mirrors. Never install a package without updating the system first. On a rolling release, this can lead to an unbootable system. Installing the package will also create a system user called *postgres*. You can now switch to the *postgres* user using a privilege elevation program.

You can switch to the PostgreSQL user by executing the following command:

- If you have sudo and are in sudoers

  ```sh
  $ sudo -iu postgres
  ```

- Otherwise using su:

  ```sh
  $ su
  # su -l postgres
  ```

## Step 2: Initial Configuration

Before PostgreSQL can function correctly, the database cluster must be initialized.

### 2.1 We can confirm the installed PostgreSQL version by running:

```sh
$ postgres --version                                                                           ─╯
postgres (PostgreSQL) 15.1
```

### 2.2 Set applicable entries in **/etc/locale.gen**

```sh
$ echo "en_US.UTF-8 UTF-8" | sudo tee /etc/locale.gen
```

### 2.3 Then run **\*\*locale-gen\*\*** to generate locale settings

```sh
$ sudo locale-gen
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
$ systemctl status postgresql                                                                  ─╯
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
$ sudo systemctl enable postgresql
```

### 3.4 Verify that PostgreSQL is running by running the following command:

```sh
$ sudo systemctl status postgresql                                                             ─╯
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

# Resources

- [Arch Linux Wiki](https://wiki.archlinux.org/title/PostgreSQL)
- [Wikipedia](https://en.wikipedia.org/wiki/PostgreSQL)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)

# Conclusion

Installing PostgreSQL on Arch Linux-based distribution is a straightforward process that can be completed in just a few steps. By following the steps outlined above, you can install, configure, and start the PostgreSQL database server on your Arch Linux system. Once installed, you can use PostgreSQL to store, manage, and query data for a wide range of applications and use cases. With its advanced features and high level of extensibility, PostgreSQL is a popular choice for developers and businesses seeking a robust and reliable database management system.

You can connect to the PostgreSQL server using the psql command-line client or a graphical tool such as pgAdmin.
