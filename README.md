<div align="center">
  <h1>SnakeGameS</h1>
  <img src="https://github.com/ahmadzainulmufid/SnakeGames/assets/116527439/5efd922b-dbea-48df-9e0b-e91a9b01c525" alt="Animation">
</div>

# Anggota
Dalam pembuatan permainan ular ini, terlibat 5 orang anggota, antara lain:
1. 2207412028  Laila Syalwa Salsabila
2. 2207412030  Muhammad Yusul Ilham AbdulHadi
3. 2207412038  Rico Mesias Tamba
4. 2207412044  Zahra Annisa Fakhira
5. 2207412045  Ahmad Zainul Mufid

## Deskripsi
Snake Game adalah permainan klasik di mana pemain mengontrol seekor ular untuk memakan buah-buahan dan menghindari bom-bom. Jika mengenai bomnya akan terjadi pengurangan skor dan live akan berkurang. Game ini dibangun menggunakan bahasa pemrograman java dengan aplikasi Processing dan memanfaatkan beberapa pustaka, termasuk Minim untuk pemrosesan audio.

## Petunjuk Permainan

### Kontrol
- **Gerakkan Ular:** Anda dapat menggerakkan kepala ular dengan mengarahkannya menggunakan mouse.
- **Mulai Permainan:** Klik di dalam layar untuk memulai permainan setelah ular mati.
  
### Tujuan
- Makan buah-buahan untuk mendapatkan poin dan meningkatkan panjang ular.
- Hindari bom-bom, karena mereka dapat mengurangi panjang ular dan nyawa.

### Skor
- Skor Anda ditampilkan di bagian kiri atas layar.
- Nyawa Anda ditampilkan di bagian kiri bawah layar.

### Game Over
- Permainan berakhir jika ular menabrak dinding atau menabrak dirinya sendiri.
- Permainan juga berakhir jika nyawa habis akibat menabrak bom.

## Struktur Kode

### Library
- **Minim Library:** Untuk pemrosesan audio, seperti memainkan suara game, suara game over, dan suara makanan.
  
### Variabel Utama
- `grid`: Ukuran setiap kotak grid dalam permainan.
- `food`: Posisi buah yang harus dimakan oleh ular.
- `speed`: Kecepatan gerak ular.
- `dead`: Status apakah pemain hidup atau mati.
- `highscore`: Skor tertinggi yang pernah dicapai.
- `snake`: Objek yang merepresentasikan ular.
- `bomb`: Posisi bom yang harus dihindari oleh ular.

...

## Cara Menjalankan Code
1. Pastikan Anda sudah menginstal [Processing](https://processing.org/).
2. Buka Processing dan buat proyek baru.
3. Salin seluruh code ke dalam proyek baru Anda.
4. Pastikan Anda memiliki file gambar (background.jpg, fruit.png, bomb.png) dan file suara (Kevin MacLeod - 8bit Dungeon Boss.mp3, videogame-death-sound-43894.mp3, 570636__bsp7176__food.mp3) di direktori yang sama dengan proyek Anda.
5. Jalankan proyek.

Selamat bermain!
