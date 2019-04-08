#!/bin/bash
myUser=$(whoami)
echo Hello $myUser! Thanks for stopping by.
echo Starting the program now.
echo

sep="-"
choose='y'
while [ "$choose" = 'y' ] #while starts starts here, not greeting user twice                                  
                          #for a single session
do
    cdate=`date +%Y-%d-%m`
    cyear=${cdate:0:4}
    cday=${cdate:5:2}
    cmonth=${cdate:8:2}
    
    echo Enter Birth Year YYYY
    read byear
    echo Enter Birth Day DD
    read bday
    echo Enter Birth Month MM
    read bmonth
    bdate="$byear$sep$bday$sep$bmonth"
    
#ignore this, I used it to test for holiday message pre=pretend
    preday=07
    preMonth=04
    preMsg="Pretend holiday"
    
    christmasday=25
    christmasmonth=12
    christmasMsg="Merry Christmas!"
    
    hday=31
    hmonth=10
    hMsg="Happy Halloween!"
    
    stpday=17
    stpmonth=03
    stpMsg="Happy st patricks day!"
    
    canday=01
    canmonth=07
    canMsg="Happy Canada Day!"
    
    offset=$1
    
    echo 
    echo ----- Birthday Count Down -----
    echo    
#If the birthday has passed, calculate birthday for next year (+1)
    d3="$(($cyear + 1))$sep$bday$sep$bmonth"
#If the birthday has NOT passed, calculate for this year.
    d4="$(($cyear))$sep$bday$sep$bmonth"

    if [[ $# -eq 1 && $1>-1 ]] 
    then
#	echo One argument given that is greater than 0
	dChar="d"
	nDATE=$(date -v +$offset$dChar +%Y-%d-%m)
	echo Date with offset of $offset is $nDATE
	nyear=${nDATE:0:4}
	nday=${nDATE:5:2}
	nmonth=${nDATE:8:2} 

	#If the birthday has passed, calculate birthday for next year (+1                            
	d5="$(($nyear + 1))$sep$bday$sep$bmonth"
        #If the birthday has NOT passed, calculate for this year. 
	d6="$(($nyear))$sep$bday$sep$bmonth"


	echo
	echo The offset is $1
	echo
	if [[ $offset<5476 ]]
	then
	    if [[ "$nmonth" -eq "$bmonth" && "$nday" -eq "$bday" ]]
	    then
		echo It is your birthday!! Happy Birthday
		let age=$cyear-$byear
		echo You are $age years old now.
		if [[ "$nmonth" = "$hmonth" && "$nday" = "$hday" ]]
		then
		    echo $hMsg
		elif [[ "$nmonth" = "$christmasmonth" && "$nday" = "$christmasday" ]]
		then
		    echo $christmasMsg
		elif [[ "$nmonth" = "$stpmonth" && "$nday" = "$stpday" ]]
		then
		    echo $stpMsg
		elif [[ "$nmonth" = "$canmonth" && "$nday" = "$canday" ]]
		then
		    echo $canMsg
		else
		    echo There are no holidays on your birthday with the given offset.
		fi
	    elif [[ "$bmonth" < "$nmonth" ]]
            then
		echo The current date is $cdate
		echo The date with the offset of $offset days is $nDATE
		echo
		echo The date with the offset is past my birthday, so next birthday is next year.
		echo Days until next birthday: $(((`date -jf %Y-%d-%m $d5 +%s` - `date -jf %Y-%d-%m $nDATE +%s`)/86400))
		echo
		if [[ "$nmonth" = "$hmonth" && "$nday" = "$hday" ]]
		then
                    echo $hMsg
		elif [[ "$nmonth" = "$christmasmonth" && "$nday" = "$christmasday" ]]
		then
                    echo $christmasMsg
		elif [[ "$nmonth" = "$stpmonth" && "$nday" = "$stpday" ]]
		then
                    echo $stpMsg
		elif [[ "$nmonth" = "$canmonth" && "$nday" = "$canday" ]]
		then
                    echo $canMsg
		fi    
	    elif [[ "$bmonth" > "$nmonth" ]]
	    then
		echo The current date is $cdate
                echo The date with the offset of $offset days is $nDATE
		echo
		echo There is a birthday to come this year even with the offset.
		echo Days until next birthday: $(((`date -jf %Y-%d-%m $d6 +%s` - `date -jf %Y-%d-%m $nDATE +%s`)/86400))
		echo
		if [[ "$nmonth" = "$hmonth" && "$cday" = "$nday" ]]
		then
                    echo $hMsg
		elif [[ "$nmonth" = "$christmasmonth" && "$nday" = "$christmasday" ]]
		then
                    echo $christmasMsg
		elif [[ "$nmonth" = "$stpmonth" && "$nday" = "$stpday" ]]
		then
                    echo $stpMsg
		    elif [[ "$nmonth" = "$canmonth" && "$nday" = "$canday" ]]
		then
                    echo $canMsg
		else
                    echo no holidays
		fi
	    else
		if [[ "$nmonth" = "$hmonth" && "$cday" = "$nday" ]]
                then
                    echo $hMsg
                elif [[ "$nmonth" = "$christmasmonth" && "$nday" = "$christmasday" ]]
                then
                    echo $christmasMsg
                elif [[ "$nmonth" = "$stpmonth" && "$nday" = "$stpday" ]]
                then
                    echo $stpMsg
                elif [[ "$nmonth" = "$canmonth" && "$nday" = "$canday" ]]
                then
                    echo $canMsg
                else
                    echo no holidays
                fi
	    fi
	    echo ---------
	elif [[ $offset>5475 ]]
	then
	    echo number too large for offset, exceeds 15 years.
	elif [[ $offset<=0 ]]
	then
	    echo offset not a positive number
	else
	    echo Invalid argument, please give me a number from 1-5475
	fi
    else #no arguments given so we can assume no offset requires
	echo The number of arguments given is $#
#If the birth month has past, the next birthday is next year
	if [[ "$bmonth" < "$cmonth" ]]
	then
	    echo Todays date is $cdate
	    echo My birthday is $bdate
	    echo
	    echo Birthday is next year.
	    echo Days until next birthday: $(((`date -jf %Y-%d-%m $d3 +%s` - `date -jf %Y-%d-%m $cdate +%s`)/86400))
	    echo
	    if [[ "$bmonth" = "$hmonth" && "$bday" = "$hday" ]]
	    then
		echo $hMsg    
	    elif [[ "$bmonth" = "$christmasmonth" && "$bday" = "$christmasday" ]]
	    then
		echo $christmasMsg
	    elif [[ "$bmonth" = "$stpmonth" && "$bday" = "$stpday" ]]
	    then
		echo $stpMsg
	    elif [[ "$bmonth" = "$canmonth" && "$bday" = "$canday" ]]
	    then
		echo $canMsg
	    fi
	elif [[ "$bmonth" = "$cmonth" && "$bday" = "$cday" ]]
	then 
	    echo Days until next birthday: 0
	    echo Today is your birthday !!!
	    echo
	    let age=$cyear-$byear
            echo You are $age years old now.
	    if [[ "$cmonth" = "$hmonth" && "$cday" = "$hday" ]]
	    then
		echo $hMsg
	    elif [[ "$cmonth" = "$christmasmonth" && "$cday" = "$christmasday" ]]
	    then
		echo $christmasMsg
	    elif [[ "$cmonth" = "$stpmonth" && "$cday" = "$stpday" ]]
	    then
		echo $stpMsg
	    elif [[ "$cmonth" = "$canmonth" && "$cday" = "$canday" ]]
	    then
		echo $canMsg
	    else
		echo "There is no holiday today :("
	    fi
#if the birth month has not past, then there is a birthday this year
	else
	    echo Todays date is $cdate
	    echo My birthday is $bdate
	    echo 
	    echo There is a birthday to come this year.
#	    echo Days until next birthday: $(((`date -jf %Y-%d-%m $d4 +%s` - `date -jf %Y-%d-%m $cdate +%s`)/86400)) 
	    echo Days until next birthday: $(((`date -jf %Y-%d-%m $d4 +%s` - `date -jf %Y-%d-%m $cdate +%s`)/86400))

	    
  	    if [[ "$bmonth" = "$hmonth" && "$bday" = "$hday" ]]
	    then
		echo $hMsg
	    elif [[ "$bmonth" = "$christmasmonth" && "$bday" = "$christmasday" ]]
	    then
		echo $christmasMsg    
	    elif [[ "$bmonth" = "$stpmonth" && "$bday" = "$stpday" ]]
	    then
		echo $stpMsg
	    elif [[ "$bmonth" -eq "$canmonth" && "$bday" -eq "$canday" ]]
	    then
		echo $canMsg
	    fi
	fi
    fi
    echo
    echo "choose [y]es to continue and [n]o to exit (y/n) "
    read decision
    choose=$decision
    echo ---------------------------------
done         #while loop end