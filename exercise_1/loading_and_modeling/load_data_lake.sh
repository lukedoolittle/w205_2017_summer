#!/bin/bash

# save current directory
MY_CWD=$(pwd)

# create staging directory
mkdir ~/staging
mkdir ~/staging/exercise_1
cd ~/staging/exercise_1

# get file from remote source and unzip
wget https://data.medicare.gov/views/bg9k-emty/files/0a9879e0-3312-4719-a1db-39fd114890f1?filename=Hospital_Revised_Flatfiles.zip -O Hospital_Revised_Flatfiles.zip
unzip Hospital_Revised_Flatfiles.zip -d Hospital_Revised_Flatfiles

# create a mapping of all the physical file names to their logical names
declare -A file_mapping=( \
["hospitals"]="Hospital General Information.csv" \
["effective_care"]="Timely and Effective Care - Hospital.csv" \
["readmissions"]="Readmissions and Deaths - Hospital.csv" \
["measures"]="Measure Dates.csv" \
["survey_responses"]="hvbp_hcahps_11_10_2016.csv" \
["complications"]="Complications - Hospital.csv" \
["infections"]="Healthcare Associated Infections - Hospital.csv" \
["imaging"]="Outpatient Imaging Efficiency - Hospital.csv" \
["structural_measures"]="Structural Measures - Hospital.csv" \
["heart_attack_scores"]="hvbp_ami_11_14_2016.csv" \
["outcome_scores"]="hvbp_clinical_care_outcomes_11_10_2016.csv" \
["immunization_scores"]="hvbp_imm2_11_10_2016.csv" \
["preventative_scores"]="hvbp_pc_11_10_2016.csv" \
["safety_scores"]="hvbp_safety_11_10_2016.csv" \
["efficiency_scores"]="hvbp_efficiency_11_10_2016.csv" \
["total_scores"]="hvbp_tps_11_10_2016.csv" \
)

echo "  creating: hospital_compare in hdfs";
# create the root directory in HDFS
hdfs dfs -mkdir /user/w205/hospital_compare

# go through all the mappings and 
# (1) remove the header (the first line) from each
# (2) create the appropriate subdirectory in HDFS
# (3) place the modified file in the new subdirectory
for name in "${!file_mapping[@]}";
do echo "  creating: $name in hdfs";
tail -n +2 "Hospital_Revised_Flatfiles/${file_mapping[$name]}" > "$name.csv";
hdfs dfs -mkdir /user/w205/hospital_compare/"$name";
hdfs dfs -put "$name".csv /user/w205/hospital_compare/"$name"
done

# clean up now unneeded files
echo "  cleaning up inflated files";
rm -r Hospital_Revised_Flatfiles
rm Hospital_Revised_Flatfiles.zip

# change directory back to original
cd $MY_CWD