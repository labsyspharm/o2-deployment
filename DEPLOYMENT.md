# Deployment Instructions

These instructions cover deployment of these modules to O2 and should only be followed by an administrator.

Note that the administrator will need to be a member of the `lsp` group in Active Directory.

## Update An Application Version

Each version of an application is a separate module. To add a module for a new version of an application:

1. Ensure that the version of the application that is to be deployed is available through whatever mechanism is being used for installation in the relevant installation script. E.g. for ashlar, the version should be available on PYPI.

2. Add a new modulefile within the relevant application directory of this repository. It is best to base the new file on the previous version. In most cases there will be no changes. E.g. `modulefiles/ashlar/1.6.0.lua`.

3. Commit these changes to the master branch of this repository and push to Github.

4. Login to O2 and `cd /n/groups/lsp/o2`.

5. Pull the latest changes with `git pull`.

6. Run the deploy script to deploy any modules which are not already deployed. `python deploy.py`.
