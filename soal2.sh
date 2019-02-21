echo "negara dgn penjualan terbanyak: "
awk -F, '{if($7=="2012") a[$1]+=$10;} END{for(i in a) print a[i]","i}' WA_Sales_Products_2012-14.csv | sort -n -r | head -n 1 | awk -F, '{print $2}'
echo ""
echo "tiga product line dgn penjualan terbanyak: "
awk -F, '{if($1=="United States" && $7=="2012") a[$4]+=$10;} END{for(i in a) print a[i]","i}' WA_Sales_Products_2012-14.csv | sort -n -r | head -n 3 | awk -F, '{print $2}'
echo ""
echo "tiga product dgn penjualan terbanyak: "
awk -F, '{if($1=="United States" && $7=="2012" && ($4=="Personal Accessories" || $4=="Camping Equipment" || $4=="Outdoor Protection")) a[$6]+=$10;} END{for(i in a) print a[i]","i}' WA_Sales_Products_2012-14.csv | sort -n -r | head -n 3 | awk -F, '{print $2}'
