# CoViS-Net

[![GitHub license](https://img.shields.io/badge/license-GPLv3.0-blue.svg)](https://github.com/proroklab/CoViS-Net/blob/master/LICENSE)

This is the repository accompanying the paper "CoViS-Net: A Cooperative Visual Spatial Foundation Model for Multi-Robot Applications".

## Environment setup
Setup Miniconda as instructed [here](https://docs.anaconda.com/miniconda/miniconda-install/). Run the commands below to create and activate the environment. Don't forget to source the `pre_training_setup` script. Creating the conda environment can take up to 30 minutes, but installing [libmamba](https://www.anaconda.com/blog/a-faster-conda-for-a-growing-community) can help speeding up resolving dependencies.
```
conda env create -f environment.yml
conda activate covisnet
export ./pre_training_setup.bash
```

## Dataset generation
Download the HM3D dataset by signing up on the website.
```
python -m habitat_sim.utils.datasets_download --username xxx --password xxx --uids hm3d_full
```

Make sure the dataset was downloaded:
```
ls data/versioned_data/hm3d-1.0/hm3d/train | wc -l
``` 
The command should show a number higher than 800.

The dataset generation can be triggered with the following command:
```
./dataset_util/generate_dataset.bash 800 
```
The number indicates the upper limit on the HM3D scenes used for the data generation (0 would only generate the first scene, 800 all training scenes). The datasets will be moved to the `datasets` folder.

## Real-world dataset
Download the dataset from [here](https://drive.google.com/file/d/1Bbf-S4_jxr5AdLceIrHYhLQitqkQBv8R/view?usp=sharing), move it to the `datasets` folder and extract the zip.

## Training
After generating the dataset, update the dataset path of the field `data/data_dir` in `train/configs/covisnet.yaml`. Update the logging configuration in `train/configs/logging.yaml` as appropriate.

To reproduce training, run the following command:
```
python3 -m train fit --config train/configs/covisnet.yaml --config train/configs/logging.yaml
```

## Unity run
```
salloc -p gpu-preempt -t 06:00:00 --gpus=2 --mem=64G --constraint=l40s --cpu-per-gpu 8

module load conda/latest
module load cudnn/8.9.7.29-12-cuda12.6

conda activate covisnet

source pre_training_setup.bash
python3 -m train fit --config train/configs/covisnet.yaml --config train/configs/logging.yaml
```

