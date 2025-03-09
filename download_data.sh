data_uid="hm3d_v0.1"

# Check if an argument is provided
if [ $# -eq 1 ]; then
    data_uid=$1
fi

export MATTERPORT_PW=602fc3c4dfce15d6c89013e1a6e2b799
export MATTERPORT_ID=fed6fccb2f05b202

conda init
conda activate convisnet

python -m habitat_sim.utils.datasets_download --username $MATTERPORT_ID --password $MATTERPORT_PW --uids $data_uid