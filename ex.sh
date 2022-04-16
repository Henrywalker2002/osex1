menu_choice=""
record_file="bookRecords.ldb"
temp_file=/tmp/ldb.$$
touch $temp_file; chmod 644 $temp_file
trap 'rm -f $temp_file' EXIT

set_menu_choice(){
clear
printf 'Options:-'
printf '\n'
printf '\ta) Add new Books records\n'
printf '\tb) Find Books\n'
printf '\tc) Remove Books\n'
printf '\td) View Books\n'
printf '\tf) quit\n'
return
}

insert_record(){
echo $* >>$record_file
return
}


#!!!!!!!!!...........................!!!!!!!!!!!!!!!!
#This function ask user for details information about book for keeping records

add_books(){

printf 'Enter Books category:-'
read tmp
liCatNum=${tmp%%,*}
 
printf 'Enter Books title:-'
read tmp
liTitleNum=${tmp%%,*}
 
printf 'Enter Auther Name:-'
read tmp
liAutherNum=${tmp%%,*}
 
printf 'About to add new entry\n'
printf "$liCatNum\t$liTitleNum\t$liAutherNum\n"

insert_record $liCatNum,$liTitleNum,$liAutherNum
 
return
}

find_books(){
  echo "Enter book title to find:"
  read book2find
  grep $book2find $record_file > $temp_file

  # set $(wc -l $temp_file)
  # linesfound=$1
  linesfound=`cat $temp_file|wc -l`

  case `echo $linesfound` in
  0)    echo "Sorry, nothing found"
        get_return
        return 0
        ;;
  *)    echo "Found the following"
        cat $temp_file
        get_return
        return 0
  esac
return
}

remove_books() {
  linesfound=`cat $record_file|wc -l`

   case `echo $linesfound` in
   0)    echo "Sorry, nothing found\n"
         get_return
         return 0
         ;;
   *)    echo "Found the following\n"
         cat $record_file ;;
        esac
 printf "Type the books titel which you want to delete\n"
 read searchstr

  if [ "$searchstr" = "" ]; then
      return 0
   fi
 grep -v "$searchstr" $record_file > $temp_file
 mv $temp_file $record_file
 printf "Book has been removed\n"
 get_return
return
}

view_books(){
  printf "List of books are\n"
  
  cat $record_file
  get_return
  sleep 3
  return
}


rm -f $temp_file
if [!-f $record_file];then
touch $record_file
fi


quit="n"
while [ "$quit" != "y" ];
      do
      set_menu_choice
      read menu_choice
      case "$menu_choice" in
      a) add_books;;
      b) find_books;;
      c) remove_books;;
      d) view_books;;
      *) exit;;
      esac
done
# Tidy up and leave

rm -f $temp_file

exit 0