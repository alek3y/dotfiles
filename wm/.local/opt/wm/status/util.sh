
# Map a range of values to another
function map {
	input=$1
	in_min=$2
	in_max=$3
	out_min=$4
	out_max=$5

	(
		printf "r="
		printf "((%d - %d)/" $input $in_min
		printf "(%d - %d))*" $in_max $in_min
		printf "(%d - %d)" $out_max $out_min
		printf "+%d+0.5;" $out_min
		printf "scale=0;"
		printf "r/1\n"
	) | bc -l
}
