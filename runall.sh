#runall.sh

#!/bin/bash
threads=1
instructions=1
time=0

for((t=1;t<=8;t*=2));
do
	for((i=1;i<=256;i*=4));
	do
		threads=$t
		instructions=$i
		time=$[time+1]
		echo "time:$time"
		./run.sh -t $threads -i $instructions
		#echo "$threads"	
		#echo "$instructions"
	done
done
