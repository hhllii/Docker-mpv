#run.sh

#!/bin/bash

#(1/2/4/8 n threads) and (1/4/16/64/256 1/n instructions) totally 20 run 
#set threads and instrctions for single run
myPath="./report/" 
if [ ! -x "$myPath" ]; then 
mkdir "$myPath" 
fi 

while getopts "t:i:h" arg 
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
             h)
                echo "Usage:"
		echo "-t <int> (1/2/4/8 n threads) -i <int> (1/4/16/64/256 1/n instructions)"
                ;;
             ?)
		echo "Usage:"
            	echo "-t <int> (1/2/4/8 n threads) -i <int> (1/4/16/64/256 1/n instructions)"
        exit 1
        ;;
        esac
done
if [ -n "$threads" ] && [ -n "$instructions" ];then
	echo "Processing ......"
	sudo docker run -it --privileged hhllii/mpv perf stat -e instructions,branch-misses,cycles,L1-dcache-load-misses,L1-icache-load-misses mpv qa_$instructions.mp4 --o=video_out --of=flv --ovc=libx264 --ovcopts=threads=$threads --oac=libmp3lame --oacopts=threads=$threads > ./$myPath/report_${threads}t_${instructions}i.txt
	echo "Report at $myPath"
else
	echo "Usage:"
	echo "-t <int> (1/2/4/8 n threads) -i <int> (1/4/16/64/256 1/n instructions)"
fi
