function applyDarkMode() {
    const elements = document.querySelectorAll('*');
    elements.forEach(element => {
        const style = window.getComputedStyle(element);
        const bgColor = style.backgroundColor;
        const color = style.color;

        // Ubah background putih dan semi-transparan putih jadi hitam dan hitam transparan
        if (bgColor === 'rgb(255, 255, 255)' || bgColor === 'rgba(255, 255, 255, 0.5)') {
            element.style.backgroundColor = bgColor === 'rgb(255, 255, 255)' ? '#000000' : 'rgba(0, 0, 0, 0.5)';
        }

        // Ubah teks gray-600 menjadi putih
        if (color === 'rgb(74, 74, 74)') {
            element.style.color = '#ffffff';
        }
        // Pastikan teks putih tetap putih
        if (color === 'rgb(255, 255, 255)') {
            element.style.color = '#ffffff';
        }
    });
}

// Cek preferensi mode gelap pengguna
if (window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches) {
    applyDarkMode();
}

// Pantau perubahan preferensi color scheme
window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', event => {
    if (event.matches) {
        applyDarkMode();
    } else {
        location.reload(); // Reload halaman untuk kembali ke mode terang
    }
});