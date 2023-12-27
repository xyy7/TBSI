mytest(){
    scale=$1
    mode=$2
    sed -i -e "s/visible/visible-$scale-$mode/" /home/xyy/TBSI/lib/test/evaluation/lasherdataset.py
    cp /home/xyy/TBSI/experiments/tbsi_track/vitb_256_tbsi_32x4_4e4_lasher_15ep_in1k.yaml /home/xyy/TBSI/experiments/tbsi_track/vitb_256_tbsi_32x4_4e4_lasher_15ep_in1k-$scale-$mode.yaml 
    CUDA_VISIBLE_DEVICES=$3 python tracking/test.py tbsi_track vitb_256_tbsi_32x4_4e4_lasher_15ep_in1k-$scale-$mode --dataset_name lasher_test --threads 6 --num_gpus 1 &
    sleep 5
    sed -i -e "s/visible-$scale-$mode/visible/" /home/xyy/TBSI/lib/test/evaluation/lasherdataset.py

    # python tracking/analysis_results.py --tracker_name tbsi_track --tracker_param vitb_256_tbsi_32x4_4e4_lasher_15ep_in1k-$scale-$mode --dataset_name lasher_test > mytest_res_$scale-$mode.log &
}

mytest 2 1 3
mytest 2 2 4
mytest 4 2 5

