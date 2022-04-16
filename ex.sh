menu_choice=""
record_file="bookRecords.ldb"
temp_file=/tmp/ldb.$$
touch $temp_file; chmod 644 $temp_file
trap 'rm -f $temp_file' EXIT

set_menu_choice(){
clear
printf 'Options:-'
printf '\n'
printf '\t1) Add new Books records\n'
printf '\t2) Find Books\n'
printf '\t3) Remove Books\n'
printf '\t4) View Books\n'
printf '\t5) quit\n'
return
}

insert_record(){
echo $* >>$record_file
return
}


#!!!!!!!!!...........................!!!!!!!!!!!!!!!!
#This function ask user for details information about book for keeping records


add_books(){

printf 'Enter Books title: '
read tmp
liTitleNum=${tmp%%,*}
 
printf 'Enter Books author: '
read tmp
liAutherNum=${tmp%%,*}
 
printf 'Enter Books year: '
read tmp
liyear=${tmp%%,*}
 
printf 'About to add new entry\n'
printf "$liTitleNum\t$liAutherNum\t$liyear\n"

insert_record $liTitleNum,$liAutherNum,$liyear
 
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
  return
}


rm -rf $temp_file
if [!-f $record_file];then
touch $record_file
fi


while true
      do
      set_menu_choice
      read menu_choice
      case "$menu_choice" in
      1) add_books;;
      2) find_books;;
      3) remove_books;;
      4) view_books;;
      5) break;;
      esac
      read -p "press enter to continue\n"
done
# Tidy up and leave
rm -f $temp_file


exit 0