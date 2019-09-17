today="$(date +%Y-%m-%d)"
from="$(date --date="6 months ago" +%Y-%m-%d)"
timestamp="$(date +%Y-%m-%d-%H-%M-%S)"
DOMAIN=1.1.1.1
MAIL_SERVER=1.1.1.2
MAIL_FROM=a@a.com
MAIL_to=a@abc.com

POL_NAME=Network
POL2=$(echo $POL_NAME | tr -d ' ')
total=$(mgmt_cli -r true -d $DOMAIN show access-rulebase name "$POL_NAME" --format json |jq '.total')

DISDEL=disable
#DISDEL=delete
EXPORT_TYPE1=name
#EXPORT_TYPE1=uid
#SECHEAD=y
SECHEAD=n

#printf "\nListing Access Policy Package Names\n"
#mgmt_cli -r true -d $DOMAIN show access-layers limit 500 --format json | jq --raw-output '."access-layers"[] | (.name)'


  if [ "$DISDEL" = "disable" ] && [ "$EXPORT_TYPE1" = "name" ] && [ "$SECHEAD" = "y" ]; then
      for I in $(seq 0 500 $total)
      do
        mgmt_cli -r true -d $DOMAIN show access-rulebase name "$POL_NAME" details-level "standard" offset $I limit 500 use-object-dictionary true show-hits true hits-settings.from-date $from hits-settings.to-date $today --format json | jq --raw-output --arg RBN "$POL_NAME" '.rulebase[] | .rulebase[] | select(.hits.value == 0) | (" set access-rule rule-number  " + (."rule-number"|tostring) + " enabled false layer")' >> $POL2-tmp.txt
      done
      sed "s,$, '$POL_NAME' comments 'disabled by API Zero Hit'," $POL2-tmp.txt > $POL2-2tmp.txt; sed "s/^/mgmt_cli -r true -d $DOMAIN/" $POL2-2tmp.txt >$POL2-unused.txt; rm *tmp.txt

  elif [ "$DISDEL" = "disable" ] && [ "$EXPORT_TYPE1" = "name" ] && [ "$SECHEAD" = "n" ]; then
      for I in $(seq 0 500 $total)
      do
        mgmt_cli -r true -d $DOMAIN show access-rulebase name "$POL_NAME" details-level "standard" offset $I limit 500 use-object-dictionary true show-hits true hits-settings.from-date $from hits-settings.to-date $today --format json | jq --raw-output --arg RBN "$POL_NAME" '.rulebase[] | select(.hits.value == 0) | (" set access-rule rule-number " + (."rule-number"|tostring) + " enabled false layer")' >> $POL2-tmp.txt
      done
      sed "s,$, '$POL_NAME' comments 'disabled by API Zero Hit'," $POL2-tmp.txt > $POL2-2tmp.txt; sed "s/^/mgmt_cli -r true -d $DOMAIN/" $POL2-2tmp.txt >$POL2-unused.txt; rm *tmp.txt

    elif [ "$DISDEL" = "disable" ] && [ "$EXPORT_TYPE1" = "uid" ] && [ "$SECHEAD" = "y" ]; then
      for I in $(seq 0 500 $total)
      do
        mgmt_cli -r true -d $DOMAIN show access-rulebase name "$POL_NAME" details-level "standard" offset $I limit 500 use-object-dictionary true show-hits true hits-settings.from-date $from hits-settings.to-date $today --format json | jq --raw-output --arg RBN "$POL_NAME" '.rulebase[] | .rulebase[] | select(.hits.value == 0) | (" set access-rule uid  " + (.uid|tostring) + " enabled false layer")' >> $POL2-tmp.txt
      done
      sed "s,$, '$POL_NAME' comments 'disabled by API Zero Hit'," $POL2-tmp.txt > $POL2-2tmp.txt; sed "s/^/mgmt_cli -r true -d $DOMAIN/" $POL2-2tmp.txt >$POL2-unused.txt; rm *tmp.txt

      elif [ "$DISDEL" = "disable" ] && [ "$EXPORT_TYPE1" = "uid" ] && [ "$SECHEAD" = "n" ]; then
      for I in $(seq 0 500 $total)
      do
        mgmt_cli -r true -d $DOMAIN show access-rulebase name "$POL_NAME" details-level "standard" offset $I limit 500 use-object-dictionary true show-hits true hits-settings.from-date $from hits-settings.to-date $today --format json | jq --raw-output --arg RBN "$POL_NAME" '.rulebase[] | select(.hits.value == 0) | (" set access-rule uid " + (.uid|tostring) + " enabled false layer")' >> $POL2-tmp.txt
      done
      sed "s,$, '$POL_NAME' comments 'disabled by API Zero Hit'," $POL2-tmp.txt > $POL2-2tmp.txt; sed "s/^/mgmt_cli -r true -d $DOMAIN/" $POL2-2tmp.txt >$POL2-unused.txt; rm *tmp.txt


  elif [ "$DISDEL" = "delete" ] && [ "$EXPORT_TYPE1" = "name" ] && [ "$SECHEAD" = "y" ]; then
      for I in $(seq 0 500 $total)
      do
        mgmt_cli -r true -d $DOMAIN show access-rulebase name "$POL_NAME" details-level "standard" offset $I limit 500 use-object-dictionary true show-hits true hits-settings.from-date $from hits-settings.to-date $today --format json | jq --raw-output --arg RBN "$POL_NAME" '.rulebase[] | .rulebase[] | select(.hits.value == 0) | (" delete access-rule rule-number " + (."rule-number"|tostring) + " layer")' >> $POL2-tmp.txt
      done
      sed "s,$, '$POL_NAME' comments 'disabled by API Zero Hit'," $POL2-tmp.txt > $POL2-2tmp.txt; sed "s/^/mgmt_cli -r true -d $DOMAIN/" $POL2-2tmp.txt >$POL2-unused.txt; rm *tmp.txt

  elif [ "$DISDEL" = "delete" ] && [ "$EXPORT_TYPE1" = "name" ] && [ "$SECHEAD" = "n" ]; then
      for I in $(seq 0 500 $total)
      do
        mgmt_cli -r true -d $DOMAIN show access-rulebase name "$POL_NAME" details-level "standard" offset $I limit 500 use-object-dictionary true show-hits true hits-settings.from-date $from hits-settings.to-date $today --format json | jq --raw-output --arg RBN "$POL_NAME" '.rulebase[] | select(.hits.value == 0) | (" delete access-rule rule-number " + (."rule-number"|tostring) + " layer")' >> $POL2-tmp.txt
      done
        sed "s,$, '$POL_NAME'," $POL2-tmp.txt > $POL2-2tmp.txt; sed "s/^/mgmt_cli -r true -d $DOMAIN/" $POL2-2tmp.txt >$POL2-unused.txt; rm *tmp.txt

    elif [ "$DISDEL" = "delete" ] && [ "$EXPORT_TYPE1" = "uid" ] && [ "$SECHEAD" = "y" ]; then
      for I in $(seq 0 500 $total)
      do
        mgmt_cli -r true -d $DOMAIN show access-rulebase name "$POL_NAME" details-level "standard" offset $I limit 500 use-object-dictionary true show-hits true hits-settings.from-date $from hits-settings.to-date $today --format json | jq --raw-output --arg RBN "$POL_NAME" '.rulebase[] | .rulebase[] | select(.hits.value == 0) | (" delete access-rule uid " + (.uid|tostring) + " layer")' >> $POL2-tmp.txt
      done
              sed "s,$, '$POL_NAME'," $POL2-tmp.txt > $POL2-2tmp.txt; sed "s/^/mgmt_cli -r true -d $DOMAIN/" $POL2-2tmp.txt >$POL2-unused.txt; rm *tmp.txt

      elif [ "$DISDEL" = "delete" ] && [ "$EXPORT_TYPE1" = "uid" ] && [ "$SECHEAD" = "n" ]; then
      for I in $(seq 0 500 $total)
      do
        mgmt_cli -r true -d $DOMAIN show access-rulebase name "$POL_NAME" details-level "standard" offset $I limit 500 use-object-dictionary true show-hits true hits-settings.from-date $from hits-settings.to-date $today --format json | jq --raw-output --arg RBN "$POL_NAME" '.rulebase[] | select(.hits.value == 0) | (" delete access-rule uid " + (.uid|tostring) + " layer")' >> $POL2-tmp.txt
      done
              sed "s,$, '$POL_NAME'," $POL2-tmp.txt > $POL2-2tmp.txt; sed "s/^/mgmt_cli -r true -d $DOMAIN/" $POL2-2tmp.txt >$POL2-unused.txt; rm *tmp.txt
  fi

$FWDIR/bin/sendmail -t $MAIL_SERVER -s "Rules with Zero Hits Since $from" -f $MAIL_FROM $MAIL_TO <$POL2-unused.txt
