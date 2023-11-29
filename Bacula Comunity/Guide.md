# Guide: Installing Bacula Community on Ubuntu 22.04 and Integrating with Webmin


## Introduction

Bacula Community on Ubuntu 22.04. Bacula is a powerful open-source backup and recovery solution. This guide will walk you through the step-by-step process, ensuring a smooth installation and configuration experience for robust data protection on your Ubuntu system.

## Installation Steps

1. **Update System Packages:**
   Ensure your system is up-to-date by running:
     ```bash
     sudo apt update && sudo apt upgrade
     ```
2. **Additional Package Installation:**
   You must install the following package:
     ```bash
     apt-get install apt-transport-https
     ```
3. **Import the GPG key:**
   The packages are signed with a GPG key signature that you can find at the root of
your download area:
    ```bash
    sudo cd /tmp &&
    wget https://www.bacula.org/downloads/Bacula-4096-Distribution-Verification-key.asc &&
    apt-key add Bacula-4096-Distribution-Verification-key.asc &&
    rm Bacula-4096-Distribution-Verification-key.asc &&
    ```
4. **apt Package Manager Configuration:**
    Lets check, binay version in currently the version is 13.03:
    https://bacula.org/packages/5f1e8eefd1016/debs/
     - We installing in Ubuntu 22.04 jammy
     - Current version of bacula community
   
    Add the following entries to a new file called:
    ```bash
    sudo /etc/apt/sources.list.d/Bacula-Community.list
    ```

    Adapting the URL to point to your Download Area. Also, please pay careful attention
    to use the correct Bacula Community version and platform in the URL.
    ```
    # Bacula Community
    deb [arch=amd64] https://www.bacula.org/packages/@access-key@/debs/@bacula-version@ @ubuntu-version@ main
    ``` 
      Where:
      ◾ @access-key@ refers to your personalized area string. This is the trailing
      path component sent in the registration email. Copying the URI from that
      email will be one of the simplest ways to set this up correctly.
      ◾ @bacula-version@ should be replaced by the version of Bacula Community
      you are using (e. g. 13.0.1).
      ◾ @ubuntu-version@ is the code name of the distribution (“xenial” or “bionic”,
      for example).
    Complete example:
   
    ```
    #Bacula Community
    deb [arch=amd64] https://www.bacula.org/packages/5f1e8eefd1016/debs/13.0.1 jammy main
    ```
   
5. **Package Installation**
   Run apt-get update to update the package system and verify your Bacula repositories are correctly configured.
    ```bash
     sudo apt update && sudo apt upgrade
    ```
     
6. **Install the Database Engine**
   If PostgreSQL is not already installed, please run this command to install it
    ```bash
     apt-get install postgresql postgresql-client
    ```

8. **Install the Bacula Community Software:**
    Run the following command to create the Bacula database:
    ```bash
     apt-get install bacula-postgresql
    ```
    apt will ask you if you want to “Configure database for bacula-postgresql with
    dbconfig-common?” Choose “Yes”, then enter a password and confirm it.
    Please now go to the “Security and Permissions Considerations” Chapter and
    continue the installation from there

9. **Final configuration:**
    Start PostgreSQL database:
    ```bash
     systemctl start postgresql.service
    ```
    Please run the following commands to create the database and grant ownership:
    ```bash
     su - postgres
    /opt/bacula/scripts/create_postgresql_database
    /opt/bacula/scripts/make_postgresql_tables
    /opt/bacula/scripts/grant_postgresql_privileges
    exit
    ```
    Launch the services:
    ```bash
    systemctl start bacula-fd.service
    systemctl start bacula-sd.service
    systemctl start bacula-dir.service
    ```

10. **Webmin integration:**
    Install PostgreSQL database driver for the DBI module:
    ```bash
    Search for module "DBD::Pg" in menu, Tool\Perl modules
    ```
    Also Change the 'local' entry for Unix domain socket connections from peer to md5 in the File:
    Change to:
        host    all         all                 md5
    
    ```bash
    sudo nano /etc/postgresql/14/main/pg_hba.conf
    ```

# Its Done
Congratulations! You have successfully installed Bacula Community on Ubuntu 22.04. Customize your backup strategy using the Bacula Console for effective data protection.
