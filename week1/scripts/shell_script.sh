#!/bin/bash
. /home/project/.bash_profile
. /etc/profile



##############################################################
# 1. Set Default Variables

HOST=$HOSTNAME

SHORT_DATE=`date '+%Y-%m-%d'`

TIME=`date '+%H%M'`


##############################################################
# Product Variables

PRODUCT_USERNAME=`whoami`

##############################################################
######### DO NOT MODIFY ABOVE THIS LINE ######################

# Part 2: Setting up default variables

filenametime1=$(date +"%m%d%Y%H%M%S")
filenametime2=$(date +"%Y-%m-%d %H:%M:%S")

# Part 2: Setting up environment variables

export BASE_PATH="/home/alator20/wcd-assignments/week1"
export SCRIPTS_FOLDER="/home/alator20/wcd-assignments/week1/scripts"
export INPUT_FOLDER="/home/alator20/wcd-assignments/week1/input"
export OUT_FOLDER='/home/alator20/wcd-assignments/week1/output'
export LOGDIR='/home/alator20/wcd-assignments/week1/logs'
export SHELL_SCRIPT_NAME='shell_script'
export LOG_FILE=${LOGDIR}/${SHELL_SCRIPT_NAME}_${filenametime1}.log


# Part 3: GO TO SCRIPT FOLDER AND RUN
cd ${SCRIPTS_FOLDER}

# Part 4: SET LOG RULES
exec > >(tee ${LOG_FILE}) 2>&1

##############################################################
# Part 5: DOWNLOAD DATA
echo "START DOWNLOAD DATA"

for year in {2020..2022};
do wget -N --content-disposition "https://climate.weather.gc.ca/climate_data/bulk_data_e.html?format=csv&stationID=48549&Year=${year}&Month=2&Day=14&timeframe=1&submit= Download+Data" -O ${INPUT_FOLDER}/${year}.csv;
done;

RC1=$?
if [ ${RC1} != 0 ]; then
	echo "DOWNLOAD DATA FAILED"
	echo "[ERROR:] RETURN CODE:  ${RC1}"
	echo "[ERROR:] REFER TO THE LOG FOR THE REASON FOR THE FAILURE."
	exit 1
fi
###${RC1} = 0 means sucessful running the script
#########################################################
# PART 5: RUN PYTHON
echo "Start to run Python Script"
python3 ${SCRIPTS_FOLDER}/python_script.py


RC1=$?
if [ ${RC1} != 0 ]; then
	echo "PYTHON RUNNING FAILED"
	echo "[ERROR:] RETURN CODE:  ${RC1}"
	echo "[ERROR:] REFER TO THE LOG FOR THE REASON FOR THE FAILURE."
	exit 1
fi

echo "PROGRAM SUCCEEDED"

exit 0 