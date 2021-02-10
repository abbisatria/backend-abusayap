-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 10 Feb 2021 pada 18.05
-- Versi server: 10.4.11-MariaDB
-- Versi PHP: 7.4.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `backend-abusayap`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `amount_transaction`
--

CREATE TABLE `amount_transaction` (
  `id` int(11) NOT NULL,
  `idUser` int(11) NOT NULL,
  `income` int(11) DEFAULT NULL,
  `expense` int(11) DEFAULT NULL,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatedAt` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `amount_transaction`
--

INSERT INTO `amount_transaction` (`id`, `idUser`, `income`, `expense`, `createdAt`, `updatedAt`) VALUES
(3, 16, 80000, 120000, '2021-02-10 15:41:05', '2021-02-10 16:19:08'),
(4, 17, 120000, 80000, '2021-02-10 15:41:05', '2021-02-10 16:19:08');

-- --------------------------------------------------------

--
-- Struktur dari tabel `transactions`
--

CREATE TABLE `transactions` (
  `id` int(11) NOT NULL,
  `idSender` int(11) NOT NULL,
  `idReceiver` int(11) NOT NULL,
  `amount` int(11) NOT NULL,
  `notes` text NOT NULL,
  `status` varchar(50) NOT NULL,
  `dateTransaction` datetime NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updatedAt` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `transactions`
--

INSERT INTO `transactions` (`id`, `idSender`, `idReceiver`, `amount`, `notes`, `status`, `dateTransaction`, `createdAt`, `updatedAt`) VALUES
(2, 16, 17, 100000, 'transfer cuy', 'transfer', '2021-02-10 22:12:15', '2021-02-10 15:41:05', '0000-00-00 00:00:00'),
(4, 16, 17, 20000, 'transfer cuy', 'transfer', '2021-02-10 22:12:15', '2021-02-10 15:49:56', '0000-00-00 00:00:00'),
(5, 17, 16, 20000, 'transfer aja', 'transfer', '2021-02-10 22:12:15', '2021-02-10 15:52:25', '0000-00-00 00:00:00'),
(6, 17, 16, 20000, 'transfer aja', 'transfer', '2021-02-10 22:12:15', '2021-02-10 16:13:58', '0000-00-00 00:00:00'),
(7, 17, 16, 20000, 'transfer aja', 'transfer', '2021-02-10 22:12:15', '2021-02-10 16:16:54', '0000-00-00 00:00:00'),
(8, 17, 16, 20000, 'transfer aja', 'transfer', '2021-02-10 22:12:15', '2021-02-10 16:19:08', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `firstname` varchar(50) NOT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(60) NOT NULL,
  `phoneNumber` varchar(15) DEFAULT NULL,
  `pin` varchar(60) DEFAULT NULL,
  `balance` int(11) NOT NULL,
  `picture` varchar(100) DEFAULT NULL,
  `role` int(11) NOT NULL,
  `status` varchar(50) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatedAt` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `password`, `phoneNumber`, `pin`, `balance`, `picture`, `role`, `status`, `createdAt`, `updatedAt`) VALUES
(16, 'abbi', 'satria', 'abbisatria98@gmail.com', '$2b$10$9UltJvpymNQSlB4sY6p.au77uXBwk8jLTr22StUjtQvIJRhJYCX2O', '085811588248', '$2b$10$zBXudvOEGfmw84NjEw8pMOyKDH4UvdW1shLI8v6wUIDiPS5vNSfNe', 0, 'profile-picture-1612968135647.jpg', 2, 'active', '2021-02-10 06:21:41', '2021-02-10 15:49:56'),
(17, 'Ridho', NULL, 'ridho@gmail.com', '$2b$10$WJFexHTs/gAVUHlDnNk.FeXiSiBkkwLn9TZQkILnzO.kcQNFIWHe2', NULL, '$2b$10$Ps8HTjtVCy5oZyUVivu0OuGi979PZWe80G6uC32OIQ5EIWCASmxj2', 40000, NULL, 2, 'active', '2021-02-10 15:10:36', '2021-02-10 16:19:08');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `amount_transaction`
--
ALTER TABLE `amount_transaction`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idUser` (`idUser`);

--
-- Indeks untuk tabel `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idReceiver` (`idReceiver`),
  ADD KEY `transactions_ibfk_2` (`idSender`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `amount_transaction`
--
ALTER TABLE `amount_transaction`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `amount_transaction`
--
ALTER TABLE `amount_transaction`
  ADD CONSTRAINT `amount_transaction_ibfk_1` FOREIGN KEY (`idUser`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`idReceiver`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `transactions_ibfk_2` FOREIGN KEY (`idSender`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
