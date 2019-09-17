This script is designed to search a specified 'Access Policy' for rules with ZERO HITS. This supports both MDS and SMS environments. This script is made to run directly on the managment station and will email the results to admins

It is highly recommended to run the 'DISABLE' version prior to running a 'DELETE' it will treat it as a staging for full deletion

You have the option to export the commands to 'DISABLE' or 'DELETE' the rules with Zero Hits.

## How to Use ##
 - Move script the management station
 - Edit the Variables as needed;
  - from="$(date --date="6 months ago" +%Y-%m-%d)"
    - Default is 6 months from the date. Can change to 3 or whatever by changing the # Months
  - DOMAIN=1.1.1.1
    - enter the IP of your SMS or CMA
  - MAIL_SERVER=1.1.1.2
    - mail relay IP for email
  - MAIL_FROM=a@a.com
    - enter a FROM email address
  - MAIL_to=a@abc.com
    - enter a TO email address. You can do multiple with , separated.
  - POL_NAME=Network
    - Enter the Name of the Access Policy you wish to Check
  - DISDEL=disable
    - Default is to disable the rules. If you want delete commands just comment this out and un-comment out the variable below
  - #DISDEL=delete
  - #EXPORT_TYPE1=name
    - Default is for UID. UID is more accurate as it does not change. But if you want rule number un-comment this out and comment out the below variable.
  - EXPORT_TYPE1=uid
    - if you use UID and want to check the UID in the rulebase you can copy the UID and use ctrl+g in smartdashboard to search by UID
  - #SECHEAD=y
    - Default is for a policy with no section headers. If you use section headers in your policy un-comment this variable and comment out the below variable.
  - SECHEAD=n
