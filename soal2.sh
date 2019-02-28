echo "negara dgn penjualan terbanyak: "
negara=$(awk -F, '{if($7=="2012") a[$1]+=$10;} END{for(i in a) print a[i]","i}' WA_Sales_Products_2012-14.csv | sort -n -r | head -n 1)
echo $negara
negara=$(awk -F, '{print $2}' <<< "$negara")
echo ""
echo "tiga product line dgn penjualan terbanyak: "
product=$(awk -F, -v neg="$negara" '{if($1==neg && $7=="2012") a[$4]+=$10;} END{for(i in a) print a[i]","i}' WA_Sales_Products_2012-14.csv | sort -n -r | head -n 3 )
awk '{print $0}' <<< "$product"
product1=$(awk -F, '{if(NR==1) print $2}' <<< "$product")
product2=$(awk -F, '{if(NR==2) print $2}' <<< "$product")
product3=$(awk -F, '{if(NR==3) print $2}' <<< "$product")
echo ""
echo "tiga product dgn penjualan terbanyak: "
awk -F, -v prod1="$product1" -v prod2="$product2" -v prod3="$product3" -v neg="$negara" '{if($1==neg && $7=="2012" && ($4==prod1 || $4==prod2 || $4==prod3)) a[$6]+=$10;} END{for(i in a) print a[i]","i}' WA_Sales_Products_2012-14.csv | sort -n -r | head -n 3 
