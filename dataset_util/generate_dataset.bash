#!/usr/bin/env bash

# Default value
max=800

# Set the destination folder name at the beginning
dest_folder="datasets/dataset_zip_$(date +%Y%m%d)"

# Check if an argument is provided
if [ $# -eq 1 ]; then
    # Check if the argument is a valid integer
    if [[ $1 =~ ^[0-9]+$ ]]; then
        max=$1
    else
        echo "Error: Argument must be a positive integer."
        exit 1
    fi
fi

# for i in $(seq 0 $max); do 
#     python ./dataset_util/generate_dataset.py $i data/versioned_data/hm3d-0.1/hm3d/train $dest_folder
# done    

max_processes=8
current_processes=0
pids=()


for i in $(seq 0 $max); do
  while [[ $current_processes -ge $max_processes ]]; do
    wait -n  # Wait for any child process to complete
    ((current_processes--))
  done
  python ./dataset_util/generate_dataset.py $i data/versioned_data/hm3d-0.1/hm3d/train $dest_folder &
  pids+=($!)
  ((current_processes++))
done

wait "${pids[@]}" # Wait for all remaining processes
echo "All done!"