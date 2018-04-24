#!/bin/bash
#author:971

array_chess=(0 0 0 0 0 0 0 0 0)

#胜负判定函数
wins=(0 1 2 3 4 5 6 7 8 0 3 6 1 4 7 2 5 8 0 4 8 2 4 6)
determine(){
i=0
xx=0
yy=1
zz=2
while(( $i < 8))
do
	x=${wins[xx]}
	y=${wins[yy]}
	z=${wins[zz]}
if [[ (${array_chess[x]} != 0) && (${array_chess[y]} != 0) && (${array_chess[z]} != 0)]]
then
	if [[ (${array_chess[x]} == ${array_chess[y]}) && (${array_chess[y]} == ${array_chess[z]}) ]]
	then
		if [[ ${array_chess[x]} == 1 ]]
		then
			echo -e "\033[31m X方获胜！\033[0m" |tee -a ${thisrecord}
			exit
		else 
			echo -e "\033[31m O方获胜！\033[0m" |tee -a ${thisrecord}
			exit
		fi
	fi
fi
	let i++ xx=xx+3 yy=yy+3 zz=zz+3

done
for var in 0 1 2 3 4 5 6 7 8
do
	
	if [[ ${array_chess[var]} == 0 ]]
	then
		break
	elif test $var -eq 8
	then 
		echo -e "\033[31m 平局！ \033[0m" |tee -a ${thisrecord}
		exit
	fi
done
putchess
}

#将现在的棋盘画出来
printChessbord(){
i=0

printf "第$n回合:\n" >> ${thisrecord}
let n++

printf "\n" >> ${thisrecord}

while(( $i < 9 ))
do 
	if test ${array_chess[i]} -eq 1
	then	
		printf "X" |tee -a ${thisrecord}
	elif test ${array_chess[i]} -eq -1
	then
		printf "O" |tee -a ${thisrecord}
	else
		printf " " |tee -a ${thisrecord}
	fi
	
	if test $i -eq 2 -o $i -eq 5 -o $i -eq 8
	then 
		printf "\n" |tee -a  ${thisrecord}
	else 
		printf "|" |tee -a  ${thisrecord}
	fi
	let "i++"
done
	printf "\n" >> ${thisrecord}	
}

putchess(){
if test $flag -eq 1
then
	read -p "X方回合:" row column
elif test $flag -eq -1
then
	read -p "O方回合:" row column
fi

legal=0
while(( $legal == 0))
do
if test $row -le 3 -a $row -ge 1 -a $column -le 3 -a $column -ge 1
then
	num=$[($row-1)*3+$column-1]
	if test ${array_chess[num]} -eq 0
	then 
		legal=1
	else
		read -p "输入的位置已有棋子，请重新输入:" row column
	fi
else
	read -p "输入不合法，请重新输入:" row column
fi
#判断输入的位置是否合法
done

num=$[($row-1)*3+$column-1]
array_chess[$num]=$flag
printChessbord
flag=`expr -1 \* $flag`
determine
}

gameBegin(){

array_chess=(0 0 0 0 0 0 0 0 0)
flag=-1
n=1
thisrecord=`date +"%Y-%m-%d_%T"`
thisrecord="./record/"${thisrecord}
putchess

}

gameBegin
