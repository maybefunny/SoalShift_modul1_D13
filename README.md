# Laporan Penjelasan Soal Shift Modul 1

1. Anda diminta tolong oleh teman anda untuk mengembalikan filenya yang telah dienkripsi oleh seseorang menggunakan bash script, file yang dimaksud adalah nature.zip. Karena terlalu mudah kalian memberikan syarat akan membuka seluruh file tersebut jika pukul 14:14 pada tanggal 14 Februari atau hari tersebut adalah hari jumat pada bulan Februari.

    Hint: Base64, Hexdump

    ### Jawab :

    [Source Code](/soal1.sh)

    ### Langkah :

    1. Buat script untuk decrypt

        langkah decrypt :
        - extract file .zip
        - decode tiap file dalam folder nature menggunakan `base64 -d`
        - hexdump reverse tiap file dalam folder nature menggunakan  `xxd -r`
        - archive folder nature menjadi nature.zip
    
    2. buat cronjob yang menjalankan script decrypt dengan waktu sesuai permintaan soal
    
            14 14 *  2  5   /bin/bash /directory/to/script/soal1.sh
            14 14 14 2  *   /bin/bash /directory/to/script/soal1.sh

2. Anda merupakan pegawai magang pada sebuah perusahaan retail, dan anda diminta
untuk memberikan laporan berdasarkan file WA_Sales_Products_2012-14.csv.
Laporan yang diminta berupa:

    a. Tentukan negara dengan penjualan(quantity) terbanyak pada tahun 2012.

    b. Tentukan tiga product line yang memberikan penjualan(quantity) terbanyak pada soal poin a.

    c. Tentukan tiga product yang memberikan penjualan(quantity) terbanyak berdasarkan tiga product line yang didapatkan pada soal poin b.

    ### Jawab :

    [Source Code](/soal2.sh)

    a. hitung jumlah quantity dari negara-negara pada tahun 2012
    
    ```bash
    awk -F, '{if($7=="2012") a[$1]+=$10;} END{for(i in a) print a[i]","i}' WA_Sales_Products_2012-14.csv | sort -n -r | head -n 1 | awk -F, '{print $2}'
    ```

    #### keterangan :
    - `if($7=="2012" a[$1]+=$10;)` akan menghitung jumlah kolom 10 (quantity) tiap-tiap negara
    - `for(i in a) print a[i]"  "i` akan mencetak list negara dan jumlah quantity-nya
    - `sort -n -r` akan mengurutkan list dari terbesar ke terkecil berdasarkan jumlah quantity
    - `head -n 1` akan memotong list menjadi hanya baris pertama (negara dengan jumlah quantity terbesar)
    - `awk '{print $2" "$3}'` akan memotong list menjadi hanya nama negara

    b. Tentukan tiga product line yang memberikan penjualan(quantity) terbanyak pada soal poin a.

    ```bash
    awk -F, '{if($1=="United States" && $7=="2012") a[$4]+=$10;} END{for(i in a) print a[i]","i}' WA_Sales_Products_2012-14.csv | sort -n -r | head -n 3 | awk -F, '{print $2}'
    ```

    #### keterangan :
    - perbedaan solusi antara poin b dan a terletak pada
        - syarat penghitungan frequency, syaratnya ditambah dengan nama negara hasil poin a.
        - indeks penghitungan frequency yang awalnya kolom 1 (nama negara) sekarang menjadi kolom 4 (nama product line).
        - jumlah baris yang dicetak menjadi 3

    c. Tentukan tiga product yang memberikan penjualan(quantity) terbanyak berdasarkan tiga product line yang didapatkan pada soal poin b.

    ```bash
    awk -F, '{if($1=="United States" && $7=="2012" && ($4=="Personal Accessories" || $4=="Camping Equipment" || $4=="Outdoor Protection")) a[$6]+=$10;} END{for(i in a) print a[i]","i}' WA_Sales_Products_2012-14.csv | sort -n -r | head -n 3 | awk -F, '{print $2}'
    ```

    #### keterangan :
    - perbedaan solusi antara poin b dan c terletak pada
        - syarat penghitungan frequency, syaratnya ditambah dengan nama-nama product line pada poin b.
        - indeks penghitungan frequency yang awalnya kolom 4 (nama product line) sekarang menjadi kolom 5 (nama product).

3. Buatlah sebuah script bash yang dapat menghasilkan password secara acak
sebanyak 12 karakter yang terdapat huruf besar, huruf kecil, dan angka. Password
acak tersebut disimpan pada file berekstensi .txt dengan ketentuan pemberian nama
sebagai berikut:

    a. Jika tidak ditemukan file password1.txt maka password acak tersebut disimpan pada file bernama password1.txt
    
    b. Jika file password1.txt sudah ada maka password acak baru akan disimpan pada file bernama password2.txt dan begitu seterusnya.

    c. Urutan nama file tidak boleh ada yang terlewatkan meski filenya dihapus.

    d. Password yang dihasilkan tidak boleh sama.

    ### Jawab :

    [Source Code](/soal3.sh)

    ### langkah-langkah :
    - pastikan password baru tidak sama dengan yang sudah ada
        - generate password baru.
        - dapatkan list password yang sudah ada dengan mengambilnya dari file `password*.txt`.
        - bandingkan password baru dengan setiap password pada list, jika sama maka generate password baru dan ulangi langkah ini, jika beda maka password baru valid.
    - cari urutan nama file yang tepat.
    - generate file dengan isi password yang valid.

4. Lakukan backup file syslog setiap jam dengan format nama file “jam:menit tanggal- bulan-tahun”. Isi dari file backup terenkripsi dengan konversi huruf (string manipulation) yang disesuaikan dengan jam dilakukannya backup misalkan sebagai berikut:

    a. Huruf b adalah alfabet kedua, sedangkan saat ini waktu menunjukkan pukul 12, sehingga huruf b diganti dengan huruf alfabet yang memiliki urutan ke 12+2 = 14.

    b. Hasilnya huruf b menjadi huruf n karena huruf n adalah huruf ke empat belas, dan seterusnya.

    c. setelah huruf z akan kembali ke huruf a

    d. Backup file syslog setiap jam.

    e. dan buatkan juga bash script untuk dekripsinya.

    ### jawab :

    [Source Code](/soal4.sh)

    ### langkah-langkah :
    - backup & encrypt :
        - tentukan nama file yang valid dengan mengambil nilai waktu pada saat itu dengan menggunakan tool `date '+%H:%M %d-%m-%Y'`
        - ambil nilai jam pada saat itu untuk menjadi chiper key `date '+%H'`
        - lakukan enkripsi dengan menggunakan key yang telah diperoleh dan simpan dengan nama file yang valid.
        - buat cronjob

            ```    
            0 * * * * /bin/bash /directory/to/script/soal4.sh
            ```

    - decrypt :
        - ambil nilai jam pada nama file sebagai chiper key
        - lakukan dekripsi menggunakan key yang telah diperoleh
        - simpan hasil dekripsi

5. Buatlah sebuah script bash untuk menyimpan record dalam syslog yang memenuhi
kriteria berikut:

    a. Tidak mengandung string “sudo”, tetapi mengandung string “cron”, serta buatlah pencarian stringnya tidak bersifat case sensitive, sehingga huruf kapital atau tidak, tidak menjadi masalah.

    b. Jumlah field (number of field) pada baris tersebut berjumlah kurang dari 13.

    c. Masukkan record tadi ke dalam file logs yang berada pada direktori /home/[user]/modul1.

    d. Jalankan script tadi setiap 6 menit dari menit ke 2 hingga 30, contoh 13:02, 13:08, 13:14, dst.

    ### jawab :

    [Source Code](/soal5.sh)

    ### langkah-langkah :
    - filter syslog menggunakan awk dengan filter-filter berikut :
        - pattern matching : `!/sudo/` dan `/cron`
        - ignore case : `BEGIN{IGNORECASE=1;}`
        - number of field : `NF<13`
    - simpan hasil filter pada `~/modul1/`
    - buat cronjob
        ```
        2-30/6 * * * * /bin/bash /directory/to/script/soal5.sh
        ```