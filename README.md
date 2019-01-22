# SFW_Patterns Project

## Introduction

This project is projected to be a repository of coding patterns
for several interaction types.  The first patterns are methods
for generating drop-down lists from ENUM fields and lookup tables.
More patterns will follow as I rediscover them during development.

A better project for learning about the Schema Framework si
[sfw_simple.git](https://github.com/cjungmann/sfw_simple).
There you will find mentions of utilities that help in developing
framework applications.

## Warning

The setup scripts in this project write to protected files and
directories.  Make sure you understand what is being done before
running the scripts.  These are the protected areas that are
changed:

- The **setup** makes the following environment changes:
  - Adds a database, by default *SFW_Patterns* to MySQL.
    The database name can be changed near the top of the
    **setup** script.
  - Creates a *site* directory with a modified *default.xsl*
    file and a symbolic link to an *includes* directory
    that points to the default SchemaFW installation
    */usr/local/lib/schemafw/web_includes*
  - Creates tables and stored procedures in the database
    created earlier in the script.

- The **apache_set** script touches more significant parts
  of the system on which it resides.
  - It creates and enables an Apache configuration file in
    /etc/apache2/sites-available that points to the
    *site* directory created by the **setup** scripts
  - It optionally creates an additional entry in the
    */etc/hosts* file to make it easier to test the new
    application on a development workstation.
  - **apache_set** recognizes options for *install* and
    *uninstall*.  Uninstall will disable the configuration
    and remove the configuration file and, optionally,
    remove the */etc/hosts* entry.
  - There are variables declared near the top of the
    **apache_set** script that will change some of the
    default settings for DirectoryIndex, etc.


## Prepare and Use the Project

Keeping in mind the warnings from the previous section
(which might inspire one to change settings before 
running the scripts), enter the following commands to
setup the demonstration application.

1. Download the project into a working directory:

   ~~~sh
   user:~$ cd ~/www
   user:~/www$ git clone https://github.com/cjungmann/sfw_patterns.git
   user:~/www$ cd sfw_patterns/setup
   ~~~

1. Do the MySQL setup first because the tables that are
   created there are used by **apache_set** to set the
   *DirectoryIndex* configuration value.

   ~~~sh
   user:~/www/sfw_patterns/setup$ ./setup
   ~~~

1. Configure Apache to direct requests to the new site.  Note
   that running as root (using *sudo*) is necessary to be
   allowed to access the restricted files and directories.

   - Without changing */etc/hosts* (you'll have to
     figure out another way to direct requests.)

      ~~~sh
      user:~/www/sfw_patterns/setup$ sudo ./apache_set install
      ~~~

   - Add entry to */etc/hosts*.  The script will present
     a differences display  in order to review the changes
     Accept or abandon the changes according to your
     comfort level.  Enter "1" to accept the changes,
     anything else will abandon the changes to */etc/hosts*.

     ~~~sh
     user:~/www/sfw_patterns/setup$ sudo ./apache_set install -h
     ~~~

1. Test Configuration

   Especially if you have used the *-h* option to update
   the */etc/hosts* file, open a browser and navigate to
   *http://sfw_patterns*.

## Uninstall the Project

The setup steps can be entirely undone by use of scripts
in the setup directory.  A complete uninstall should be
executed in the following order:

1. Take down the Apache configuration first.  Omit the
   *-h* option if it was not used in the setting-up call
   to **apache_set** script:

   ~~~sh
   user:~/www/sfw_patterns/setup$ sudo ./apache_set uninstall -h
   ~~~

   With the *-h* option, the script displays the differences
   between the    existing */etc/hosts* file and the proposed
   replacement.  As when running the *install* option, type
   "1" to accept the changes, anything else will abort.

   NOTE:  This script should be run before **unsetup**
   because a generated file in the *setup* directory
   (installed_site.txt) has saved the name that is the 
   basis for the configuration file name and the host
   name of the site.

1. Remove other files and the MySQL Database.  Do this after
   **apache_set**:

   ~~~sh
   user:~/www/sfw_patterns/setup$ unsetup
   ~~~

## Earlier Projects

There are two previous **gensfw** driven projects listed below.
The setup and uninstall processes are different, but won't be updated
to conform to the setup conventions I hope to start with this one.

- The [login project](https://github.com/cjungmann/sfw_login) was
  created to demonstrate how to use sessions.

- The [households list project](https://github.com/cjungmann/sfw_household)
  explores alternative many-to-one implementations.



