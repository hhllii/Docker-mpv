#run.sh

#!/bin/bash

# -h for usage
#-t (1/2/4/8 n threads) and -i (1/4/16/64/256 1/n instructions) totally 20 run 
#set threads and instrctions for single run
#-l run for lantency totally 50 tests
myPath="./report/" 
if [ ! -x "$myPath" ]; then 
mkdir "$myPath" 
fi 

while getopts "t:i:hl" arg 
do
        case $arg in
             t)
                echo "threads:$OPTARG"
		threads=$OPTARG
                ;;
             i)
                echo "instructions:$OPTARG" 
		instructions=$OPTARG
                ;;
             l)
		lantency=1
                ;;
		
             h)
                echo "Usage:"
		echo "-t <int> (1/2/4/8 n threads) -i <int> (1/4/16/64/256 1/n instructions)"
		echo "-l to test the lantency"
                ;;
             ?)
		echo "Usage:"
            	echo "-t <int> (1/2/4/8 n threads) -i <int> (1/4/16/64/256 1/n instructions)"
		echo "-l to test the lantency"
        exit 1
        ;;
        esac
done
if [ -n "$threads" ] && [ -n "$instructions" ];then
	echo "Processing ......"
	sudo docker run -it --privileged hhllii/mpv perf stat -e instructions,branch-misses,cycles,L1-dcache-load-misses,L1-icache-load-misses mpv qa_$instructions.mp4 --o=video_out --of=flv --ovc=libx264 --ovcopts=threads=$threads --oac=libmp3lame --oacopts=threads=$threads > ./$myPath/report_${threads}t_${instructions}i.txt
	echo "Report at $myPath"
elif [ -n "$lantency" ] ; then
	echo "Processing ......"
	for((i=0;i<50;i++));
	do
		sudo docker run -it --privileged hhllii/mpv perf stat -e instructions,branch-misses,cycles,L1-dcache-load-misses,L1-icache-load-misses mpv qa_test.mp4 --o=video_out --of=flv --ovc=libx264 --oac=libmp3lame >> lantency.txt
	done
	echo "Report at lantency.txt"
else
	echo "Usage:"
	echo "-t <int> (1/2/4/8 n threads) -i <int> (1/4/16/64/256 1/n instructions)"
fi
