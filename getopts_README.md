This is a basic script and illustration of how getopts tool works to parse Arguments inside a bash script.

**What this do:**<br>
This script Takes 2x Arguments as -n and -t.<br>
-n should be followed by a name string.<br>
-t should be followed by a Number.<br>
-n or -t if missing the succeeding Name_String or Number would Print Error and usage. \n<br>



**Sample Cases and Outputs**

|**exampe 1**|**example 2**|
|:---|:---|
|**./getopts.sh**<br>Output : <br>Hi!<br> |**./getopts.sh -t 3**<br>Output : <br>Hi!<br>Hi!<br>Hi!<br>|**./getopts.sh -n Tim**<br>Output : <br>Hi, Tim!<br>|
|**exampe 3**|**example 4**|
|**./getopts.sh -n Tim -t 3**<br>Output : <br>Hi, Tim!<br>Hi, Tim!<br>Hi, Tim!<br>|**./getopts.sh -n (A missing Argument Should Prompt Error)**<br>Error: -n requires an argument.<br>Usage: ./getopts.sh [ -n NAME ] [ -t TIMES ]<br>|

<br>**How getopts Work? :**<br>
This tool iterates through all the arguments passed. 
```
while getopts ":n:t:" options; do  
          case "${options}" in
                  n)                                    # If the option is n,
                          NAME=${OPTARG}                # set $NAME to specified value.
                  ;;
                  t)                                    # If the option is t,
                          TIMES=${OPTARG}               # Set $TIMES to specified value.
                          re_isanum='^[0-9]+$'          # Regex: match whole numbers only
                          if ! [[ $TIMES =~ $re_isanum ]] ; then   # if $TIMES not whole:
                                  echo "Error: TIMES must be a positive, whole number."
                                  exit_abnormal
                          elif [ $TIMES -eq "0" ]; then # If it's zero:
                                  echo "Error: TIMES must be greater than zero."
                                  exit_abnormal         # Exit abnormally.
                          fi
                  ;;
                  :)                                    # If expected argument omitted:
                          echo "Error: -${OPTARG} requires an argument."
                          exit_abnormal                 # Exit abnormally.
                  ;;
                  *)                                    # If unknown (any other) option:
                          exit_abnormal                 # Exit abnormally.
                  ;;
          esac
done 
```
<br>***Explaining :n:t:***<br>
The First colon : means Do not Print Errors by getopts. Because we want to handle errors by ourself.<br>
n       is for argument -n which would be a name_string.<br>
n:      -n has to be followed by an argument<br>
t:      -t has to be followed by an integer number<br> 
Hint: if there no succeeding colon : after any option No Arguments are required and that Option acts merely as a (0/1) Flag.<br>
