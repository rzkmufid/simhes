-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 06, 2024 at 05:32 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `simhes`
--

-- --------------------------------------------------------

--
-- Table structure for table `apd`
--

CREATE TABLE `apd` (
  `id_apd` int(11) NOT NULL,
  `nama_apd` varchar(100) NOT NULL,
  `jumlah` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `apd`
--

INSERT INTO `apd` (`id_apd`, `nama_apd`, `jumlah`) VALUES
(1, 'Safety Helmet', 21),
(2, 'Safety Glasses', 22),
(3, 'Masker', 23),
(4, 'Safety Gloves', 24),
(5, 'Safety Shoes', 21),
(6, 'Faceshield', 22),
(7, 'Celemek/Apron', 21);

-- --------------------------------------------------------

--
-- Table structure for table `insiden_kerja`
--

CREATE TABLE `insiden_kerja` (
  `id` int(11) NOT NULL,
  `id_karyawan` int(11) NOT NULL,
  `tanggal` date NOT NULL,
  `nama_karyawan` varchar(255) NOT NULL,
  `nobadge` int(9) NOT NULL,
  `jabatan` varchar(100) NOT NULL,
  `uraian` text NOT NULL,
  `penyebab` text NOT NULL,
  `tingkat_insiden` varchar(100) NOT NULL,
  `nlti` varchar(100) NOT NULL,
  `tli` varchar(100) NOT NULL,
  `day_lost` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `insiden_kerja`
--

INSERT INTO `insiden_kerja` (`id`, `id_karyawan`, `tanggal`, `nama_karyawan`, `nobadge`, `jabatan`, `uraian`, `penyebab`, `tingkat_insiden`, `nlti`, `tli`, `day_lost`) VALUES
(1, 6, '2024-06-03', 'Yessi Lestari', 0, 'HES Officer', 'Test Uraian', 'Test Penyebab', 'Tingakat Insiden', 'NLTI', 'TLI', 5);

-- --------------------------------------------------------

--
-- Table structure for table `karyawan`
--

CREATE TABLE `karyawan` (
  `id_karyawan` int(11) NOT NULL,
  `nobadge` int(9) NOT NULL,
  `nama_karyawan` varchar(255) NOT NULL,
  `tempat_lahir` varchar(20) NOT NULL,
  `tanggal_lahir` date NOT NULL,
  `jabatan` varchar(20) NOT NULL,
  `jenis_kelamin` varchar(20) NOT NULL,
  `alamat` varchar(20) NOT NULL,
  `riwayat_penyakit` text NOT NULL,
  `pernah_kecelakaan` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `karyawan`
--

INSERT INTO `karyawan` (`id_karyawan`, `nobadge`, `nama_karyawan`, `tempat_lahir`, `tanggal_lahir`, `jabatan`, `jenis_kelamin`, `alamat`, `riwayat_penyakit`, `pernah_kecelakaan`) VALUES
(4, 0, 'Walfadila Yurizal', 'Pekanbaru', '1997-09-30', 'Admin', 'Laki-Laki', 'Jl. Teluk Leok', '-', ''),
(6, 0, 'Yessi Lestari', 'Pekanbaru', '1995-11-12', 'HES Officer', 'Perempuan', 'Jl. Limbungan Baru', '-', 'tidak');

-- --------------------------------------------------------

--
-- Table structure for table `observasi`
--

CREATE TABLE `observasi` (
  `id` int(11) NOT NULL,
  `tanggal` date NOT NULL,
  `id_karyawan` int(11) NOT NULL,
  `observasi_diri_sendiri` enum('1','0') NOT NULL,
  `coach` enum('1','0') NOT NULL,
  `lokasi_observasi` text NOT NULL,
  `jumlah_observasi` int(255) NOT NULL,
  `golongan_observasi` enum('karyawan','kontraktor') NOT NULL,
  `organisasi_observasi` text DEFAULT NULL,
  `perusahaan_kontraktor` text DEFAULT NULL,
  `1.1` enum('1','0') DEFAULT NULL,
  `1.2` enum('1','0') DEFAULT NULL,
  `1.3` enum('1','0') DEFAULT NULL,
  `1.4` enum('1','0') DEFAULT NULL,
  `1.5` enum('1','0') DEFAULT NULL,
  `2.1` enum('1','0') DEFAULT NULL,
  `2.2` enum('1','0') DEFAULT NULL,
  `2.3` enum('1','0') DEFAULT NULL,
  `2.4` enum('1','0') DEFAULT NULL,
  `3.1` enum('1','0') DEFAULT NULL,
  `3.2` enum('1','0') DEFAULT NULL,
  `4.1` enum('1','0') DEFAULT NULL,
  `4.2` enum('1','0') DEFAULT NULL,
  `4.3` enum('1','0') DEFAULT NULL,
  `4.4` enum('1','0') DEFAULT NULL,
  `4.5` enum('1','0') DEFAULT NULL,
  `4.7` enum('1','0') DEFAULT NULL,
  `5.1` enum('1','0') DEFAULT NULL,
  `5.2` enum('1','0') DEFAULT NULL,
  `5.3` enum('1','0') DEFAULT NULL,
  `6.1` enum('1','0') DEFAULT NULL,
  `6.2` enum('1','0') DEFAULT NULL,
  `6.3` enum('1','0') DEFAULT NULL,
  `6.4` enum('1','0') DEFAULT NULL,
  `6.5` enum('1','0') DEFAULT NULL,
  `6.6` enum('1','0') DEFAULT NULL,
  `6.7` enum('1','0') DEFAULT NULL,
  `6.8` enum('1','0') DEFAULT NULL,
  `6.9` enum('1','0') DEFAULT NULL,
  `6.10` enum('1','0') DEFAULT NULL,
  `7.1` enum('1','0') DEFAULT NULL,
  `7.2` enum('1','0') DEFAULT NULL,
  `7.3` enum('1','0') DEFAULT NULL,
  `8.1` enum('1','0') DEFAULT NULL,
  `8.2` enum('1','0') DEFAULT NULL,
  `8.3` enum('1','0') DEFAULT NULL,
  `8.4` enum('1','0') DEFAULT NULL,
  `8.5` enum('1','0') DEFAULT NULL,
  `8.6` enum('1','0') DEFAULT NULL,
  `8.7` enum('1','0') DEFAULT NULL,
  `8.8` enum('1','0') DEFAULT NULL,
  `8.9` enum('1','0') DEFAULT NULL,
  `9.1` enum('1','0') DEFAULT NULL,
  `9.2` enum('1','0') DEFAULT NULL,
  `9.3` enum('1','0') DEFAULT NULL,
  `9.4` enum('1','0') DEFAULT NULL,
  `9.5` enum('1','0') DEFAULT NULL,
  `9.6` enum('1','0') DEFAULT NULL,
  `9.7` enum('1','0') DEFAULT NULL,
  `9.8` enum('1','0') DEFAULT NULL,
  `9.9` enum('1','0') DEFAULT NULL,
  `10.1` enum('1','0') DEFAULT NULL,
  `10.2` enum('1','0') DEFAULT NULL,
  `10.3` enum('1','0') DEFAULT NULL,
  `10.4` enum('1','0') DEFAULT NULL,
  `11.0` enum('1','0') DEFAULT NULL,
  `perilaku_selamat` text DEFAULT NULL,
  `perilaku_beresiko` text DEFAULT NULL,
  `ketika` text DEFAULT NULL,
  `ditemukan` text DEFAULT NULL,
  `sebab` text DEFAULT NULL,
  `saran` text DEFAULT NULL,
  `setuju_perilaku_terjadi` enum('1','0') DEFAULT NULL,
  `setuju_perilaku_beresiko` enum('1','0') DEFAULT NULL,
  `bentuk_perilaku_selamat` enum('mungkin','sukar','tidak_mungkin') DEFAULT NULL,
  `tindak_lanjut` enum('1','0') DEFAULT NULL,
  `komentar` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `observasi`
--

INSERT INTO `observasi` (`id`, `tanggal`, `id_karyawan`, `observasi_diri_sendiri`, `coach`, `lokasi_observasi`, `jumlah_observasi`, `golongan_observasi`, `organisasi_observasi`, `perusahaan_kontraktor`, `1.1`, `1.2`, `1.3`, `1.4`, `1.5`, `2.1`, `2.2`, `2.3`, `2.4`, `3.1`, `3.2`, `4.1`, `4.2`, `4.3`, `4.4`, `4.5`, `4.7`, `5.1`, `5.2`, `5.3`, `6.1`, `6.2`, `6.3`, `6.4`, `6.5`, `6.6`, `6.7`, `6.8`, `6.9`, `6.10`, `7.1`, `7.2`, `7.3`, `8.1`, `8.2`, `8.3`, `8.4`, `8.5`, `8.6`, `8.7`, `8.8`, `8.9`, `9.1`, `9.2`, `9.3`, `9.4`, `9.5`, `9.6`, `9.7`, `9.8`, `9.9`, `10.1`, `10.2`, `10.3`, `10.4`, `11.0`, `perilaku_selamat`, `perilaku_beresiko`, `ketika`, `ditemukan`, `sebab`, `saran`, `setuju_perilaku_terjadi`, `setuju_perilaku_beresiko`, `bentuk_perilaku_selamat`, `tindak_lanjut`, `komentar`) VALUES
(2, '2024-06-02', 6, '1', '1', 'Kantor', 4, 'kontraktor', 'XCV', 'ABC', '1', '1', '0', '0', '1', '1', '0', '0', '1', '1', '0', '0', '1', '1', '0', '0', '1', '1', '0', '0', '1', '1', '0', '0', '1', '1', '0', '0', '1', '1', '0', '0', '1', '1', '0', '0', '1', '1', '0', '0', '1', '1', '0', '0', '1', '1', '0', '0', '1', '1', '0', '0', '1', '1', '0', '0', 'TIdak memakai helm', 'tidak lengkap memakai alat', 'Bekerja', 'ruang makan', 'lalai dalam kelengkapan bekerja', 'diberikan pelatihan tambahan', '0', '0', 'sukar', '1', 'sesegera mungkin diadakan pelatihan yang lebih intensif'),
(3, '2024-06-02', 6, '1', '1', 'Kantor', 4, 'kontraktor', 'XCV', 'ABC', '1', '1', '0', '0', '1', '1', '0', '0', '1', '1', '0', '0', '1', '1', '0', '0', '1', '1', '0', '0', '1', '1', '0', '0', '1', '1', '0', '0', '1', '1', '0', '0', '1', '1', '0', '0', '1', '1', '0', '0', '1', '1', '0', '0', '1', '1', '0', '0', '1', '1', '0', '0', '1', '1', '0', '0', 'TIdak memakai helm', 'tidak lengkap memakai alat', 'Bekerja', 'ruang makan', 'lalai dalam kelengkapan bekerja', 'diberikan pelatihan tambahan', '0', '0', 'sukar', '1', 'sesegera mungkin diadakan pelatihan yang lebih intensif'),
(4, '2024-06-03', 4, '1', '0', 'Kantor', 6, 'karyawan', 'XYZ', 'ABC', '1', '1', '0', '0', '1', '1', '0', '0', '1', '1', '0', '0', '1', '1', '0', '0', '1', '1', '0', '0', '1', '1', '0', '0', '1', '1', '0', '0', '1', '1', '0', '0', '1', '1', '0', '0', '1', '1', '0', '0', '1', '1', '0', '0', '1', '1', '0', '0', '1', '1', '0', '0', '1', '1', '0', '0', 'Tidak Memakai Helm', 'tidak mematuhi aturan keselamatan kerja', 'bekerja', 'Kantin', 'tidak berpakaian lengkap', 'adakan pelatihan keselamatan kerja', '0', '1', 'sukar', '1', 'test123');

-- --------------------------------------------------------

--
-- Table structure for table `pengajuan`
--

CREATE TABLE `pengajuan` (
  `id_pengajuan` int(11) NOT NULL,
  `nama_karyawan` int(11) NOT NULL,
  `nama_apd` int(11) NOT NULL,
  `jumlah` int(20) NOT NULL,
  `tanggal` date NOT NULL,
  `keterangan` text NOT NULL,
  `status` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `pengajuan`
--

INSERT INTO `pengajuan` (`id_pengajuan`, `nama_karyawan`, `nama_apd`, `jumlah`, `tanggal`, `keterangan`, `status`) VALUES
(1, 4, 2, 10, '2024-05-13', 'okee', 'Diproses');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `id_karyawan` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `level` enum('hes','hescoordinator') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `id_karyawan`, `nama`, `username`, `password`, `level`) VALUES
(2, 6, 'HES Officer', 'yessi_hesofficer', '12345', 'hes'),
(3, 4, 'Walfadila', 'walfadila', '123', 'hescoordinator');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `apd`
--
ALTER TABLE `apd`
  ADD PRIMARY KEY (`id_apd`) USING BTREE;

--
-- Indexes for table `insiden_kerja`
--
ALTER TABLE `insiden_kerja`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `id_karyawan` (`id_karyawan`) USING BTREE;

--
-- Indexes for table `karyawan`
--
ALTER TABLE `karyawan`
  ADD PRIMARY KEY (`id_karyawan`) USING BTREE;

--
-- Indexes for table `observasi`
--
ALTER TABLE `observasi`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `id_karyawan2` (`id_karyawan`) USING BTREE;

--
-- Indexes for table `pengajuan`
--
ALTER TABLE `pengajuan`
  ADD PRIMARY KEY (`id_pengajuan`) USING BTREE,
  ADD KEY `nama_karyawan` (`nama_karyawan`) USING BTREE,
  ADD KEY `nama_apd` (`nama_apd`) USING BTREE;

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `id_karyawan3` (`id_karyawan`) USING BTREE;

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `apd`
--
ALTER TABLE `apd`
  MODIFY `id_apd` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `insiden_kerja`
--
ALTER TABLE `insiden_kerja`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `karyawan`
--
ALTER TABLE `karyawan`
  MODIFY `id_karyawan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `observasi`
--
ALTER TABLE `observasi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `pengajuan`
--
ALTER TABLE `pengajuan`
  MODIFY `id_pengajuan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `insiden_kerja`
--
ALTER TABLE `insiden_kerja`
  ADD CONSTRAINT `id_karyawan` FOREIGN KEY (`id_karyawan`) REFERENCES `karyawan` (`id_karyawan`);

--
-- Constraints for table `observasi`
--
ALTER TABLE `observasi`
  ADD CONSTRAINT `id_karyawan2` FOREIGN KEY (`id_karyawan`) REFERENCES `karyawan` (`id_karyawan`);

--
-- Constraints for table `pengajuan`
--
ALTER TABLE `pengajuan`
  ADD CONSTRAINT `nama_apd` FOREIGN KEY (`nama_apd`) REFERENCES `apd` (`id_apd`),
  ADD CONSTRAINT `nama_karyawan` FOREIGN KEY (`nama_karyawan`) REFERENCES `karyawan` (`id_karyawan`);

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `id_karyawan3` FOREIGN KEY (`id_karyawan`) REFERENCES `karyawan` (`id_karyawan`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
