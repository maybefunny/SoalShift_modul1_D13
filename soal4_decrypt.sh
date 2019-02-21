upper=ABCDEFGHIJKLMNOPQRSTUVWXYZ
lower=abcdefghijklmnopqrstuvwxyz
n=`echo "$1" | awk -F: '{print $1}'`
cd ~/modul1
tr "${upper:n}${upper:0:n}${lower:n}${lower:0:n}" "$upper$lower" <<< `cat "$1"` > ~/modul1/"$1_decrypted"