-- phpMyAdmin SQL Dump
-- version 4.6.6deb5ubuntu0.5
-- https://www.phpmyadmin.net/
--
-- Client :  localhost:3306
-- Généré le :  Ven 26 Novembre 2021 à 11:32
-- Version du serveur :  5.7.36-0ubuntu0.18.04.1
-- Version de PHP :  7.2.24-0ubuntu0.18.04.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `umbrella`
--

-- --------------------------------------------------------

--
-- Structure de la table `addon_account`
--

CREATE TABLE `addon_account` (
  `id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(60) COLLATE utf8mb4_bin NOT NULL,
  `label` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `shared` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- Contenu de la table `addon_account`
--

INSERT INTO `addon_account` (`id`, `name`, `label`, `shared`) VALUES
(0, 'society_bahamas', 'Bahamas', 1),
(1, 'caution', 'Caution', 0),
(2, 'property_black_money', 'Argent Sale Propriété', 0),
(3, 'society_ambulance', 'ambulance', 1),
(4, 'society_avocat', 'Avocat', 1),
(5, 'society_cardealer', 'Concessionnaire', 1),
(6, 'society_journaliste', 'journaliste', 1),
(7, 'society_mechanic', 'Mécano', 1),
(8, 'society_police', 'Police', 1),
(9, 'society_AgentImmo', 'Agent immobilier', 1),
(10, 'society_tabac', 'Tabac', 1),
(11, 'society_taxi', 'Taxi', 1),
(12, 'society_unicorn', 'Unicorn', 1),
(13, 'society_weedshop', 'weedman', 1),
(14, 'society_vigneron', 'vigneron', 1),
(15, 'society_label', 'label', 1),
(16, 'society_northmecano', 'NorthMecano', 1),
(17, 'property_black_money', 'Argent Sale Propriété', 0),
(18, 'society_bcso', 'BCSO', 0),
(19, 'society_Abatteur', 'Abatteur', 0),
(20, 'society_gouv', 'Gouvernement', 1),
(21, 'society_yellow', 'Yellow Jack', 1);

-- --------------------------------------------------------

--
-- Structure de la table `addon_account_data`
--

CREATE TABLE `addon_account_data` (
  `id` int(11) NOT NULL,
  `account_name` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `money` double NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- Contenu de la table `addon_account_data`
--

INSERT INTO `addon_account_data` (`id`, `account_name`, `money`, `owner`) VALUES
(0, 'society_Abatteur', 50000, NULL),
(1, 'society_northmecano', 50000, NULL),
(2, 'society_ambulance', 50000, NULL),
(3, 'society_avocat', 50000, NULL),
(4, 'society_cardealer', 50000, NULL),
(5, 'society_gouv', 50000, NULL),
(6, 'society_journaliste', 50000, NULL),
(7, 'society_mechanic', 50000, NULL),
(8, 'society_police', 50000, NULL),
(9, 'society_AgentImmo', 50000, NULL),
(10, 'society_tabac', 50000, NULL),
(11, 'society_taxi', 50000, NULL),
(12, 'society_unicorn', 50000, NULL),
(13, 'society_weedshop', 50000, NULL),
(14, 'society_yellow', 50000, NULL),
(15, 'society_vigneron', 50000, NULL),
(16, 'society_label', 50000, NULL),
(17, 'society_weedman', 50000, NULL),
(18, 'society_bahamas', 50000, NULL),
(19, 'society_bcso', 50000, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `addon_inventory`
--

CREATE TABLE `addon_inventory` (
  `name` varchar(60) NOT NULL,
  `label` varchar(100) NOT NULL,
  `shared` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Contenu de la table `addon_inventory`
--

INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
('property', 'Propriété', 0),
('society_Abatteur', 'Abatteur', 1),
('society_AgentImmo', 'Agent Immo', 1),
('society_ambulance', 'Ambulance', 1),
('society_avocat', 'Avocat', 1),
('society_bahamas', 'bahamas', 1),
('society_bahamas_fridge', 'bahamas (frigo)', 1),
('society_bahama_mamas', 'Bahama Mamas', 1),
('society_bahama_mamas_fridge', 'Bahama Mamas (frigo)', 1),
('society_bcso', 'BCSO', 1),
('society_cardealer', 'Concesionnaire', 1),
('society_gouv', 'Gouvernement', 1),
('society_label', 'label', 1),
('society_mechanic', 'Mécano', 1),
('society_northmecano', 'NorthMecano', 1),
('society_police', 'Police', 1),
('society_tabac', 'Tabac', 1),
('society_taxi', 'Taxi', 1),
('society_unicorn', 'unicorn', 1),
('society_unicorn_fridge', 'Unicorn (frigo)', 1),
('society_vigneron', 'vigneron', 1),
('society_weedshop', 'weed', 1),
('society_yellow', 'yellow', 1),
('society_yellow_fridge', 'yellow (frigo)', 1);

-- --------------------------------------------------------

--
-- Structure de la table `addon_inventory_items`
--

CREATE TABLE `addon_inventory_items` (
  `id` int(11) NOT NULL,
  `inventory_name` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `count` int(11) NOT NULL,
  `owner` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `armes`
--

CREATE TABLE `armes` (
  `id` int(11) NOT NULL,
  `identifier` varchar(255) DEFAULT NULL,
  `nomarmes` varchar(3000) DEFAULT NULL,
  `munitions` int(11) DEFAULT NULL,
  `numero_serie` varchar(255) DEFAULT NULL,
  `components` varchar(255) DEFAULT NULL,
  `createurbase` varchar(255) DEFAULT NULL,
  `jobdepart` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `baninfo`
--

CREATE TABLE `baninfo` (
  `id` int(11) NOT NULL,
  `license` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `identifier` varchar(25) COLLATE utf8mb4_bin DEFAULT NULL,
  `liveid` varchar(21) COLLATE utf8mb4_bin DEFAULT NULL,
  `xblid` varchar(21) COLLATE utf8mb4_bin DEFAULT NULL,
  `discord` varchar(30) COLLATE utf8mb4_bin DEFAULT NULL,
  `playerip` varchar(25) COLLATE utf8mb4_bin DEFAULT NULL,
  `playername` varchar(32) COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Structure de la table `banlist`
--

CREATE TABLE `banlist` (
  `id` int(11) NOT NULL,
  `identifier` varchar(25) COLLATE utf8mb4_bin DEFAULT NULL,
  `license` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `liveid` varchar(21) COLLATE utf8mb4_bin DEFAULT NULL,
  `xblid` varchar(21) COLLATE utf8mb4_bin DEFAULT NULL,
  `discord` varchar(30) COLLATE utf8mb4_bin DEFAULT NULL,
  `playerip` varchar(25) COLLATE utf8mb4_bin DEFAULT NULL,
  `targetplayername` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `sourceplayername` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `reason` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `timeat` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `added` datetime DEFAULT CURRENT_TIMESTAMP,
  `expiration` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `permanent` int(1) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `datastore`
--

CREATE TABLE `datastore` (
  `id` int(11) NOT NULL,
  `name` varchar(60) NOT NULL,
  `label` varchar(100) NOT NULL,
  `shared` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Contenu de la table `datastore`
--

INSERT INTO `datastore` (`id`, `name`, `label`, `shared`) VALUES
(1, 'user_bags', 'Sac', 0),
(2, 'user_bracelets', 'Bracelets', 0),
(3, 'user_chain', 'Chaine', 0),
(4, 'user_ears', 'Ears', 0),
(5, 'user_glasses', 'Glasses', 0),
(6, 'user_helmet', 'Helmet', 0),
(7, 'user_mask', 'Mask', 0),
(8, 'user_watches', 'Watches', 0),
(9, 'property', 'Propriété', 0),
(10, 'society_ambulance', 'Ambulance', 1),
(11, 'society_aviator', 'Pilote', 1),
(12, 'society_avocat', 'Avocat', 1),
(16, 'society_immo', 'Immo', 1),
(18, 'society_police', 'Police', 1),
(22, 'society_tabac', 'Tabac', 1),
(23, 'society_taxi', 'Taxi', 1),
(24, 'society_unicorn', 'Unicorn', 1),
(26, 'society_vigneron', 'Vigneron', 1),
(36, 'society_weedshop', 'weedman', 1),
(70, 'society_bahamas', 'bahamas', 1),
(71, 'society_yellow', 'yellow', 1),
(75, 'society_tabac', 'tabac', 1),
(76, 'society_label', 'label', 1),
(90, 'society_northmecano', 'NorthMecano', 1),
(99, 'property', 'Propriété', 0),
(104, 'society_Abatteur', 'Abatteur', 1);

-- --------------------------------------------------------

--
-- Structure de la table `datastore_data`
--

CREATE TABLE `datastore_data` (
  `id` int(11) NOT NULL,
  `name` varchar(60) NOT NULL,
  `owner` varchar(60) DEFAULT NULL,
  `data` longtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `eventsPresets`
--

CREATE TABLE `eventsPresets` (
  `id` int(11) NOT NULL,
  `createdBy` text NOT NULL,
  `label` varchar(50) NOT NULL,
  `presetInfos` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `eventsPresets`
--

INSERT INTO `eventsPresets` (`id`, `createdBy`, `label`, `presetInfos`) VALUES
(2, 'Extasy', 'Chinatown', '{\"name\":\"Chinatown\",\"vehicleModel\":\"shotaro\",\"message\":\"Un réstaurant chinois dois ce faire livré au plus vite !\",\"rewardType\":1,\"from\":{\"y\":-674.3279418945313,\"z\":28.73404121398925,\"x\":751.04638671875},\"spawns\":[{\"heading\":91.18396759033203,\"pos\":{\"y\":-667.8463134765625,\"z\":27.78842735290527,\"x\":748.0647583007813}}],\"reward\":\"1500\",\"dests\":[{\"y\":-914.8202514648438,\"z\":23.91180419921875,\"x\":-656.7597045898438}]}'),
(3, 'Extasy', 'Algé', '{\"dests\":[{\"x\":-127.00464630126953,\"y\":2792.32763671875,\"z\":53.10770416259765}],\"name\":\"Algé\",\"spawns\":[{\"pos\":{\"x\":-933.1708984375,\"y\":-2644.6328125,\"z\":39.10507202148437},\"heading\":149.35459899902345}],\"vehicleModel\":\"dominator6\",\"from\":{\"x\":-927.7879028320313,\"y\":-2649.642822265625,\"z\":39.1051025390625},\"reward\":\"5000\",\"message\":\"Une mission pas comme les autres... Attention a la LSPD cette voiture est déclarer volée !\",\"rewardType\":2}'),
(4, 'Extasy', 'Families', '{\"vehicleModel\":\"chino\",\"name\":\"Families\",\"spawns\":[{\"pos\":{\"y\":-1461.9744873046876,\"x\":-67.66026306152344,\"z\":32.00420379638672},\"heading\":206.74766540527345}],\"message\":\"Efféctuer une mission pour un gang. (25 000$)\",\"reward\":\"25000\",\"dests\":[{\"y\":-1068.026123046875,\"x\":-1211.197509765625,\"z\":8.35049819946289}],\"rewardType\":2,\"from\":{\"y\":-1449.558349609375,\"x\":-64.30872344970703,\"z\":32.52491760253906}}'),
(5, 'Txsa | Clinton Riggs', 'Cuba', '{\"vehicleModel\":\"dloader\",\"spawns\":[{\"pos\":{\"x\":2818.927490234375,\"z\":2.35310649871826,\"y\":-636.6289672851563},\"heading\":154.7110595703125}],\"message\":\"Une quantitée importante de cocaine a été aperçue échoué sur une plage. Terminez la livraison\",\"rewardType\":2,\"dests\":[{\"x\":1218.165283203125,\"z\":5.80219459533691,\"y\":-3229.192138671875}],\"name\":\"Cuba\",\"from\":{\"x\":2834.804931640625,\"z\":1.81374084949493,\"y\":-636.18603515625},\"reward\":\"25000\"}'),
(9, 'Extasy', 'GoFast Extasy', '{\"reward\":\"50000\",\"spawns\":[{\"heading\":222.78952026367188,\"pos\":{\"z\":28.67526054382324,\"x\":232.1774444580078,\"y\":-1771.999267578125}}],\"dests\":[{\"z\":48.15181350708008,\"x\":2342.16162109375,\"y\":3052.25537109375}],\"message\":\"Récupérer la voiture et allez jusu\'au point d\'arrivée sans vous faire chopez.  RECOMPENSE: 50 000$\",\"vehicleModel\":\"macla\",\"name\":\"GoFast Extasy\",\"rewardType\":2,\"from\":{\"z\":28.69512557983398,\"x\":227.964599609375,\"y\":-1762.735595703125}}'),
(10, 'Melvin', 'GoFast', '{\"message\":\"Des véhicules remplis de coke sont stationnés ici. J\'ai besoin que tu me les ramènes !\",\"vehicleModel\":\"t20\",\"from\":{\"x\":-767.2656860351563,\"z\":87.86895751953125,\"y\":366.50531005859377},\"dests\":[{\"x\":-804.7775268554688,\"z\":34.51657104492187,\"y\":5390.888671875},{\"x\":-797.5576782226563,\"z\":34.2715835571289,\"y\":5390.8173828125}],\"name\":\"GoFast\",\"rewardType\":2,\"reward\":\"25000\",\"spawns\":[{\"heading\":358.15484619140627,\"pos\":{\"x\":-770.2265014648438,\"z\":87.87608337402344,\"y\":373.5126647949219}},{\"heading\":178.5658721923828,\"pos\":{\"x\":-773.655029296875,\"z\":87.87611389160156,\"y\":373.5889892578125}},{\"heading\":179.2454376220703,\"pos\":{\"x\":-777.0831298828125,\"z\":87.87611389160156,\"y\":373.6720886230469}}]}'),
(11, 'Melvin', 'GoFastMoto', '{\"dests\":[{\"y\":6626.55322265625,\"x\":110.72379302978516,\"z\":31.7872314453125}],\"name\":\"GoFastMoto\",\"from\":{\"y\":-1649.3883056640626,\"x\":-631.48095703125,\"z\":25.97494888305664},\"vehicleModel\":\"manchez2\",\"spawns\":[{\"pos\":{\"y\":-1651.568603515625,\"x\":-634.3568725585938,\"z\":25.82507705688476},\"heading\":241.81268310546876},{\"pos\":{\"y\":-1655.7552490234376,\"x\":-636.6971435546875,\"z\":25.82507705688476},\"heading\":241.3411407470703},{\"pos\":{\"y\":-1661.825927734375,\"x\":-627.335205078125,\"z\":25.82507705688476},\"heading\":60.72887420654297},{\"pos\":{\"y\":-1657.665283203125,\"x\":-625.0291137695313,\"z\":25.82507705688476},\"heading\":59.6695556640625}],\"reward\":\"20000\",\"rewardType\":2,\"message\":\"Des petites quantités de drogue sont stockés dans les moto ici. Amenez-les nous le plus rapidement !\"}');

-- --------------------------------------------------------

--
-- Structure de la table `gangs`
--

CREATE TABLE `gangs` (
  `id` int(11) NOT NULL,
  `name` varchar(20) DEFAULT NULL,
  `chest` varchar(20) DEFAULT NULL,
  `wear` varchar(20) DEFAULT NULL,
  `garage` varchar(20) DEFAULT NULL,
  `gspawn` varchar(20) DEFAULT NULL,
  `gdelete` varchar(20) DEFAULT NULL,
  `vehicles` varchar(20) DEFAULT NULL,
  `ranks` varchar(20) DEFAULT NULL,
  `activity` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `hotel_rooms`
--

CREATE TABLE `hotel_rooms` (
  `identifier` varchar(80) NOT NULL,
  `expiration` int(11) NOT NULL,
  `safe` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `items`
--

CREATE TABLE `items` (
  `name` varchar(50) NOT NULL,
  `label` varchar(50) NOT NULL,
  `rare` int(11) NOT NULL DEFAULT '0',
  `can_remove` int(11) NOT NULL DEFAULT '1',
  `weight` double NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Contenu de la table `items`
--

INSERT INTO `items` (`name`, `label`, `rare`, `can_remove`, `weight`) VALUES
('balle', 'Balle', 0, 1, 0.25),
('banana', 'banana', 0, 1, 0.25),
('bandage', 'Bandage', 0, 1, 0.12),
('beuh', 'Beuh', 0, 1, 0.25),
('bouteilledevin', 'bouteille de vin', 0, 1, 0.35),
('bread', 'Pain', 0, 1, 0.17),
('canon', 'Canon', 0, 1, 0.25),
('carotool', 'outils carosserie', 0, 1, 0.25),
('carteid', 'carte d\'identité ', 0, 1, 0.01),
('Chaise', 'Chaise de jardin vert', 0, 1, 1),
('Chaise2', 'Chaise de jardin plad', 0, 1, 1),
('Champagne', 'Champagne', 0, 1, 0.25),
('Chips', 'Chips', 0, 1, 0.25),
('clip', 'Chargeur', 0, 1, 0.25),
('cocacola', 'cocacola', 0, 1, 0.25),
('cocaine', 'Cocaine', 0, 1, 0.25),
('crack', 'Crack', 0, 1, 0.25),
('crochet', 'crochet', 0, 1, 0.2),
('croquettes', 'Croquettes', 0, 1, 0.15),
('cutted_wood', 'Bois coupé', 0, 1, 0.25),
('drpepper', 'drpepper', 0, 1, 0.25),
('fanta', 'fanta', 0, 1, 0.25),
('feuille', 'feuille', 0, 1, 0.25),
('fish', 'Poisson', 0, 1, 0.6),
('fishbait', 'Fish Bait', 0, 1, 0.5),
('fishingrod', 'Fishing Rod', 0, 1, 1),
('fixkit', 'Kit réparation', 0, 1, 0.5),
('fixtool', 'outils réparation', 0, 1, 1),
('flitres', 'filtres', 0, 1, 0.25),
('frite', 'frite', 0, 1, 0.25),
('gitanes', 'Gitanes', 0, 1, 0.25),
('grand_cru', 'Grand cru', 0, 1, 0.25),
('heroine', 'Heroine', 0, 1, 0.25),
('icetea', 'icetea', 0, 1, 0.25),
('id_card_f', 'fake carte d\'identification ', 0, 1, 0.25),
('jagerbomb', 'jagerbomb', 0, 1, 0.25),
('join', 'Join de Beuh', 0, 1, 0.35),
('jumelles', 'Jumelles', 0, 1, 0.75),
('jusfruit', 'jusfruit', 0, 1, 0.25),
('Jus_orange', 'Jus d\'orange', 0, 1, 0.17),
('jus_raisin', 'Jus de raisin', 0, 1, 0.25),
('levier', 'Levier', 0, 1, 0.25),
('limonade', 'limonade', 0, 1, 0.25),
('malbora', 'Malbora', 0, 1, 0.25),
('martini', 'martini', 0, 1, 0.25),
('meche', 'Mèche', 0, 1, 0.25),
('medikit', 'Medikit', 0, 1, 0.25),
('metaux', 'Métaux', 0, 1, 0.25),
('methamphetamine', 'Methamphetamine', 0, 1, 0.25),
('meth_pooch', 'Pochon de meth', 0, 1, 0.25),
('mojito', 'mojito', 0, 1, 0.25),
('net_cracker', 'Cracker', 0, 1, 0.25),
('opium', 'Opium', 0, 1, 0.25),
('papier', 'Papier', 0, 1, 0.45),
('permis', 'Permis', 0, 1, 0.01),
('phone', 'Téléphone', 0, 1, 0.5),
('piece', 'pièce', 0, 1, 0.3),
('Piece_arme', 'Pièce d\'arme', 0, 1, 0.35),
('piluleoubli', 'Pilule de l\'oubli', 0, 1, 0.1),
('pizza', 'pizza', 0, 1, 0.35),
('pochon_de_coke', 'Pochon de Cocaine', 0, 1, 0.25),
('pochon_de_crack', 'Pochon de Crack', 0, 1, 0.25),
('pochon_de_heroine', 'Pochon d\' Heroine', 0, 1, 0.25),
('pochon_de_methamphetamine', 'Pochon de Methamphetamine', 0, 1, 0.25),
('pochon_de_opium', 'Pochon d\'Opium', 0, 1, 0.25),
('poulet', 'Poulet', 0, 1, 0.25),
('poulet_barquette', 'Poulet en barquette', 0, 1, 0.25),
('poulet_decouper', 'Poulet Découper', 0, 1, 0.25),
('raisin', 'Raisin', 0, 1, 0.25),
('redbull', 'redbull', 0, 1, 0.25),
('rhum', 'rhum', 0, 1, 0.25),
('rhumcoca', 'rhumcoca', 0, 1, 0.25),
('rhumfruit', 'rhumfruit', 0, 1, 0.25),
('secure_card', 'fake carte de secours', 0, 1, 0.25),
('shark', 'Shark', 0, 1, 1.6),
('sprite', 'sprite', 0, 1, 0.25),
('tabac', 'tabac', 0, 1, 0.5),
('tabacblond', 'Tabac Blond', 0, 1, 0.25),
('tabacblondsec', 'Tabac Blond Séché', 0, 1, 0.25),
('tabacbrun', 'Tabac Brun', 0, 1, 0.25),
('tabacbrunsec', 'Tabac Brun Séché', 0, 1, 0.25),
('tabac_traiter', 'tabac traiter', 0, 1, 0.25),
('tel', 'telephone', 0, 1, 0.5),
('tequila', 'tequila', 0, 1, 0.25),
('thermite', 'Thermite Bombe', 0, 1, 0.85),
('turtle', 'Sea Turtle', 0, 1, 1.2),
('turtlebait', 'Turtle Bait', 0, 1, 0.95),
('viande', 'viande', 0, 1, 0.25),
('vine', 'Vin', 0, 1, 0.35),
('vodka', 'vodka', 0, 1, 0.25),
('vodkaenergy', 'vodkaenergy', 0, 1, 0.25),
('vodkafruit', 'vodkafruit', 0, 1, 0.25),
('water', 'Eau', 0, 1, 0.35),
('weed', 'Weed', 0, 1, 0.25),
('whiskycoca', 'whiskycoca', 0, 1, 0.25),
('wood', 'Bois', 0, 1, 0.25),
('wool', 'Laine', 0, 1, 0.25);

-- --------------------------------------------------------

--
-- Structure de la table `jobs`
--

CREATE TABLE `jobs` (
  `name` varchar(50) NOT NULL,
  `label` varchar(50) DEFAULT NULL,
  `whitelisted` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Contenu de la table `jobs`
--

INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
('Abatteur', 'Abatteur', 1),
('AgentImmo', 'Agent immobilier', 1),
('ambulance', 'Ambulance', 1),
('avocat', 'Avocat', 1),
('bahamas', 'Bahamas', 0),
('bcso', 'Bcso', 1),
('cardealer', 'Concessionnaire', 1),
('gouv', 'Gouvernement', 1),
('label', 'label', 1),
('lumberjack', 'Bucheron', 0),
('mechanic', 'Mécano', 1),
('miner', 'Mineur', 0),
('NorthMecano', 'NorthMecano', 0),
('police', 'LSPD', 1),
('tabac', 'Tabac', 1),
('taxi', 'Taxi', 1),
('unemployed', 'Chomeur', 0),
('unemployed2', 'Etat', 1),
('unicorn', 'unicorn', 1),
('vigneron', 'vigneron', 1),
('weedshop', 'WeedShop', 1),
('yellow', 'YellowJack', 1);

-- --------------------------------------------------------

--
-- Structure de la table `job_grades`
--

CREATE TABLE `job_grades` (
  `id` int(11) NOT NULL,
  `job_name` varchar(50) DEFAULT NULL,
  `grade` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `label` varchar(50) NOT NULL,
  `skin_male` longtext NOT NULL,
  `skin_female` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Contenu de la table `job_grades`
--

INSERT INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `skin_male`, `skin_female`) VALUES
(1, 'unemployed', 0, 'unemployed', 'Pole emploi', '{}', '{}'),
(2, 'AgentImmo', 0, 'location', 'Location', '{}', '{}'),
(3, 'AgentImmo', 1, 'vendeur', 'Vendeur', '{}', '{}'),
(4, 'AgentImmo', 2, 'gestion', 'Gestion', '{}', '{}'),
(5, 'AgentImmo', 3, 'boss', 'Patron', '{}', '{}'),
(6, 'ambulance', 0, 'ambulance', 'Ambulancier', '{\"age_2\":0,\"beard_1\":0,\"bags_2\":0,\"bproof_1\":0,\"eyebrows_4\":0,\"eyebrows_3\":0,\"mask_2\":0,\"hair_color_1\":0,\"blemishes_2\":0,\"sun_1\":0,\"lipstick_1\":0,\"arms\":85,\"ears_2\":0,\"sex\":0,\"bproof_2\":0,\"eyebrows_2\":0,\"glasses_1\":0,\"tshirt_1\":19,\"glasses_2\":0,\"complexion_2\":0,\"mask_1\":0,\"makeup_1\":0,\"chest_1\":0,\"pants_1\":96,\"chain_2\":0,\"eyebrows_1\":0,\"bodyb_1\":0,\"blush_1\":0,\"shoes_1\":8,\"chain_1\":30,\"complexion_1\":0,\"lipstick_4\":0,\"decals_2\":0,\"age_1\":0,\"helmet_2\":1,\"blush_2\":0,\"moles_2\":0,\"blush_3\":0,\"lipstick_3\":0,\"sun_2\":0,\"beard_3\":0,\"face\":0,\"blemishes_1\":0,\"hair_color_2\":0,\"torso_1\":250,\"hair_1\":0,\"bodyb_2\":0,\"arms_2\":0,\"beard_4\":0,\"lipstick_2\":0,\"bracelets_1\":-1,\"hair_2\":0,\"makeup_3\":0,\"tshirt_2\":0,\"chest_2\":0,\"helmet_1\":122,\"bracelets_2\":0,\"makeup_2\":0,\"eye_color\":0,\"decals_1\":0,\"bags_1\":0,\"skin\":0,\"ears_1\":-1,\"makeup_4\":0,\"watches_2\":0,\"chest_3\":0,\"beard_2\":0,\"moles_1\":0,\"torso_2\":1,\"pants_2\":1,\"shoes_2\":0,\"watches_1\":-1}', '{\"age_2\":0,\"beard_1\":0,\"bags_2\":0,\"bproof_1\":0,\"eyebrows_4\":0,\"eyebrows_3\":0,\"mask_2\":0,\"hair_color_1\":0,\"blemishes_2\":0,\"sun_1\":0,\"lipstick_1\":0,\"arms\":85,\"ears_2\":0,\"sex\":0,\"bproof_2\":0,\"eyebrows_2\":0,\"glasses_1\":0,\"tshirt_1\":19,\"glasses_2\":0,\"complexion_2\":0,\"mask_1\":0,\"makeup_1\":0,\"chest_1\":0,\"pants_1\":96,\"chain_2\":0,\"eyebrows_1\":0,\"bodyb_1\":0,\"blush_1\":0,\"shoes_1\":8,\"chain_1\":30,\"complexion_1\":0,\"lipstick_4\":0,\"decals_2\":0,\"age_1\":0,\"helmet_2\":1,\"blush_2\":0,\"moles_2\":0,\"blush_3\":0,\"lipstick_3\":0,\"sun_2\":0,\"beard_3\":0,\"face\":0,\"blemishes_1\":0,\"hair_color_2\":0,\"torso_1\":250,\"hair_1\":0,\"bodyb_2\":0,\"arms_2\":0,\"beard_4\":0,\"lipstick_2\":0,\"bracelets_1\":-1,\"hair_2\":0,\"makeup_3\":0,\"tshirt_2\":0,\"chest_2\":0,\"helmet_1\":122,\"bracelets_2\":0,\"makeup_2\":0,\"eye_color\":0,\"decals_1\":0,\"bags_1\":0,\"skin\":0,\"ears_1\":-1,\"makeup_4\":0,\"watches_2\":0,\"chest_3\":0,\"beard_2\":0,\"moles_1\":0,\"torso_2\":1,\"pants_2\":1,\"shoes_2\":0,\"watches_1\":-1}'),
(7, 'ambulance', 1, 'doctor', 'Medecin', '{\"age_2\":0,\"beard_1\":0,\"bags_2\":0,\"bproof_1\":0,\"eyebrows_4\":0,\"eyebrows_3\":0,\"mask_2\":0,\"hair_color_1\":0,\"blemishes_2\":0,\"sun_1\":0,\"lipstick_1\":0,\"arms\":85,\"ears_2\":0,\"sex\":0,\"bproof_2\":0,\"eyebrows_2\":0,\"glasses_1\":0,\"tshirt_1\":19,\"glasses_2\":0,\"complexion_2\":0,\"mask_1\":0,\"makeup_1\":0,\"chest_1\":0,\"pants_1\":96,\"chain_2\":0,\"eyebrows_1\":0,\"bodyb_1\":0,\"blush_1\":0,\"shoes_1\":8,\"chain_1\":30,\"complexion_1\":0,\"lipstick_4\":0,\"decals_2\":0,\"age_1\":0,\"helmet_2\":1,\"blush_2\":0,\"moles_2\":0,\"blush_3\":0,\"lipstick_3\":0,\"sun_2\":0,\"beard_3\":0,\"face\":0,\"blemishes_1\":0,\"hair_color_2\":0,\"torso_1\":250,\"hair_1\":0,\"bodyb_2\":0,\"arms_2\":0,\"beard_4\":0,\"lipstick_2\":0,\"bracelets_1\":-1,\"hair_2\":0,\"makeup_3\":0,\"tshirt_2\":0,\"chest_2\":0,\"helmet_1\":122,\"bracelets_2\":0,\"makeup_2\":0,\"eye_color\":0,\"decals_1\":0,\"bags_1\":0,\"skin\":0,\"ears_1\":-1,\"makeup_4\":0,\"watches_2\":0,\"chest_3\":0,\"beard_2\":0,\"moles_1\":0,\"torso_2\":1,\"pants_2\":1,\"shoes_2\":0,\"watches_1\":-1}', '{\"age_2\":0,\"beard_1\":0,\"bags_2\":0,\"bproof_1\":0,\"eyebrows_4\":0,\"eyebrows_3\":0,\"mask_2\":0,\"hair_color_1\":0,\"blemishes_2\":0,\"sun_1\":0,\"lipstick_1\":0,\"arms\":85,\"ears_2\":0,\"sex\":0,\"bproof_2\":0,\"eyebrows_2\":0,\"glasses_1\":0,\"tshirt_1\":19,\"glasses_2\":0,\"complexion_2\":0,\"mask_1\":0,\"makeup_1\":0,\"chest_1\":0,\"pants_1\":96,\"chain_2\":0,\"eyebrows_1\":0,\"bodyb_1\":0,\"blush_1\":0,\"shoes_1\":8,\"chain_1\":30,\"complexion_1\":0,\"lipstick_4\":0,\"decals_2\":0,\"age_1\":0,\"helmet_2\":1,\"blush_2\":0,\"moles_2\":0,\"blush_3\":0,\"lipstick_3\":0,\"sun_2\":0,\"beard_3\":0,\"face\":0,\"blemishes_1\":0,\"hair_color_2\":0,\"torso_1\":250,\"hair_1\":0,\"bodyb_2\":0,\"arms_2\":0,\"beard_4\":0,\"lipstick_2\":0,\"bracelets_1\":-1,\"hair_2\":0,\"makeup_3\":0,\"tshirt_2\":0,\"chest_2\":0,\"helmet_1\":122,\"bracelets_2\":0,\"makeup_2\":0,\"eye_color\":0,\"decals_1\":0,\"bags_1\":0,\"skin\":0,\"ears_1\":-1,\"makeup_4\":0,\"watches_2\":0,\"chest_3\":0,\"beard_2\":0,\"moles_1\":0,\"torso_2\":1,\"pants_2\":1,\"shoes_2\":0,\"watches_1\":-1}'),
(8, 'ambulance', 2, 'chief_doctor', 'Medecin-chef', '{\"age_2\":0,\"beard_1\":0,\"bags_2\":0,\"bproof_1\":0,\"eyebrows_4\":0,\"eyebrows_3\":0,\"mask_2\":0,\"hair_color_1\":0,\"blemishes_2\":0,\"sun_1\":0,\"lipstick_1\":0,\"arms\":85,\"ears_2\":0,\"sex\":0,\"bproof_2\":0,\"eyebrows_2\":0,\"glasses_1\":0,\"tshirt_1\":19,\"glasses_2\":0,\"complexion_2\":0,\"mask_1\":0,\"makeup_1\":0,\"chest_1\":0,\"pants_1\":96,\"chain_2\":0,\"eyebrows_1\":0,\"bodyb_1\":0,\"blush_1\":0,\"shoes_1\":8,\"chain_1\":30,\"complexion_1\":0,\"lipstick_4\":0,\"decals_2\":0,\"age_1\":0,\"helmet_2\":1,\"blush_2\":0,\"moles_2\":0,\"blush_3\":0,\"lipstick_3\":0,\"sun_2\":0,\"beard_3\":0,\"face\":0,\"blemishes_1\":0,\"hair_color_2\":0,\"torso_1\":250,\"hair_1\":0,\"bodyb_2\":0,\"arms_2\":0,\"beard_4\":0,\"lipstick_2\":0,\"bracelets_1\":-1,\"hair_2\":0,\"makeup_3\":0,\"tshirt_2\":0,\"chest_2\":0,\"helmet_1\":122,\"bracelets_2\":0,\"makeup_2\":0,\"eye_color\":0,\"decals_1\":0,\"bags_1\":0,\"skin\":0,\"ears_1\":-1,\"makeup_4\":0,\"watches_2\":0,\"chest_3\":0,\"beard_2\":0,\"moles_1\":0,\"torso_2\":1,\"pants_2\":1,\"shoes_2\":0,\"watches_1\":-1}', '{\"age_2\":0,\"beard_1\":0,\"bags_2\":0,\"bproof_1\":0,\"eyebrows_4\":0,\"eyebrows_3\":0,\"mask_2\":0,\"hair_color_1\":0,\"blemishes_2\":0,\"sun_1\":0,\"lipstick_1\":0,\"arms\":85,\"ears_2\":0,\"sex\":0,\"bproof_2\":0,\"eyebrows_2\":0,\"glasses_1\":0,\"tshirt_1\":19,\"glasses_2\":0,\"complexion_2\":0,\"mask_1\":0,\"makeup_1\":0,\"chest_1\":0,\"pants_1\":96,\"chain_2\":0,\"eyebrows_1\":0,\"bodyb_1\":0,\"blush_1\":0,\"shoes_1\":8,\"chain_1\":30,\"complexion_1\":0,\"lipstick_4\":0,\"decals_2\":0,\"age_1\":0,\"helmet_2\":1,\"blush_2\":0,\"moles_2\":0,\"blush_3\":0,\"lipstick_3\":0,\"sun_2\":0,\"beard_3\":0,\"face\":0,\"blemishes_1\":0,\"hair_color_2\":0,\"torso_1\":250,\"hair_1\":0,\"bodyb_2\":0,\"arms_2\":0,\"beard_4\":0,\"lipstick_2\":0,\"bracelets_1\":-1,\"hair_2\":0,\"makeup_3\":0,\"tshirt_2\":0,\"chest_2\":0,\"helmet_1\":122,\"bracelets_2\":0,\"makeup_2\":0,\"eye_color\":0,\"decals_1\":0,\"bags_1\":0,\"skin\":0,\"ears_1\":-1,\"makeup_4\":0,\"watches_2\":0,\"chest_3\":0,\"beard_2\":0,\"moles_1\":0,\"torso_2\":1,\"pants_2\":1,\"shoes_2\":0,\"watches_1\":-1}'),
(9, 'ambulance', 3, 'boss', 'Patron EMS', '{\"age_2\":0,\"beard_1\":0,\"bags_2\":0,\"bproof_1\":0,\"eyebrows_4\":0,\"eyebrows_3\":0,\"mask_2\":0,\"hair_color_1\":0,\"blemishes_2\":0,\"sun_1\":0,\"lipstick_1\":0,\"arms\":85,\"ears_2\":0,\"sex\":0,\"bproof_2\":0,\"eyebrows_2\":0,\"glasses_1\":0,\"tshirt_1\":19,\"glasses_2\":0,\"complexion_2\":0,\"mask_1\":0,\"makeup_1\":0,\"chest_1\":0,\"pants_1\":96,\"chain_2\":0,\"eyebrows_1\":0,\"bodyb_1\":0,\"blush_1\":0,\"shoes_1\":8,\"chain_1\":30,\"complexion_1\":0,\"lipstick_4\":0,\"decals_2\":0,\"age_1\":0,\"helmet_2\":1,\"blush_2\":0,\"moles_2\":0,\"blush_3\":0,\"lipstick_3\":0,\"sun_2\":0,\"beard_3\":0,\"face\":0,\"blemishes_1\":0,\"hair_color_2\":0,\"torso_1\":250,\"hair_1\":0,\"bodyb_2\":0,\"arms_2\":0,\"beard_4\":0,\"lipstick_2\":0,\"bracelets_1\":-1,\"hair_2\":0,\"makeup_3\":0,\"tshirt_2\":0,\"chest_2\":0,\"helmet_1\":122,\"bracelets_2\":0,\"makeup_2\":0,\"eye_color\":0,\"decals_1\":0,\"bags_1\":0,\"skin\":0,\"ears_1\":-1,\"makeup_4\":0,\"watches_2\":0,\"chest_3\":0,\"beard_2\":0,\"moles_1\":0,\"torso_2\":1,\"pants_2\":1,\"shoes_2\":0,\"watches_1\":-1}', '{\"age_2\":0,\"beard_1\":0,\"bags_2\":0,\"bproof_1\":0,\"eyebrows_4\":0,\"eyebrows_3\":0,\"mask_2\":0,\"hair_color_1\":0,\"blemishes_2\":0,\"sun_1\":0,\"lipstick_1\":0,\"arms\":85,\"ears_2\":0,\"sex\":0,\"bproof_2\":0,\"eyebrows_2\":0,\"glasses_1\":0,\"tshirt_1\":19,\"glasses_2\":0,\"complexion_2\":0,\"mask_1\":0,\"makeup_1\":0,\"chest_1\":0,\"pants_1\":96,\"chain_2\":0,\"eyebrows_1\":0,\"bodyb_1\":0,\"blush_1\":0,\"shoes_1\":8,\"chain_1\":30,\"complexion_1\":0,\"lipstick_4\":0,\"decals_2\":0,\"age_1\":0,\"helmet_2\":1,\"blush_2\":0,\"moles_2\":0,\"blush_3\":0,\"lipstick_3\":0,\"sun_2\":0,\"beard_3\":0,\"face\":0,\"blemishes_1\":0,\"hair_color_2\":0,\"torso_1\":250,\"hair_1\":0,\"bodyb_2\":0,\"arms_2\":0,\"beard_4\":0,\"lipstick_2\":0,\"bracelets_1\":-1,\"hair_2\":0,\"makeup_3\":0,\"tshirt_2\":0,\"chest_2\":0,\"helmet_1\":122,\"bracelets_2\":0,\"makeup_2\":0,\"eye_color\":0,\"decals_1\":0,\"bags_1\":0,\"skin\":0,\"ears_1\":-1,\"makeup_4\":0,\"watches_2\":0,\"chest_3\":0,\"beard_2\":0,\"moles_1\":0,\"torso_2\":1,\"pants_2\":1,\"shoes_2\":0,\"watches_1\":-1}'),
(10, 'gouv', 0, 'secretary', 'Secrétaire', '{}', '{}'),
(11, 'gouv', 1, 'security', 'Garde du corps', '{}', '{}'),
(12, 'gouv', 2, 'boss', 'Gouverneur', '{}', '{}'),
(13, 'lumberjack', 0, 'employee', 'Intérimaire', '{\"age_1\":0,\"glasses_2\":0,\"beard_1\":5,\"decals_2\":0,\"beard_4\":0,\"shoes_2\":0,\"tshirt_2\":0,\"lipstick_2\":0,\"hair_2\":0,\"arms\":70,\"pants_1\":36,\"skin\":29,\"eyebrows_2\":0,\"shoes\":10,\"helmet_1\":-1,\"lipstick_1\":0,\"helmet_2\":0,\"hair_color_1\":0,\"glasses\":0,\"makeup_4\":0,\"makeup_1\":0,\"hair_1\":2,\"bproof_1\":0,\"bags_1\":0,\"mask_1\":0,\"lipstick_3\":0,\"chain_1\":0,\"eyebrows_4\":0,\"sex\":0,\"torso_1\":43,\"beard_2\":6,\"shoes_1\":12,\"decals_1\":0,\"face\":19,\"lipstick_4\":0,\"tshirt_1\":15,\"mask_2\":0,\"age_2\":0,\"eyebrows_3\":0,\"chain_2\":0,\"glasses_1\":0,\"ears_1\":-1,\"bags_2\":0,\"ears_2\":0,\"torso_2\":0,\"bproof_2\":0,\"makeup_2\":0,\"eyebrows_1\":0,\"makeup_3\":0,\"pants_2\":0,\"beard_3\":0,\"hair_color_2\":4}', '{\"age_1\":0,\"glasses_2\":0,\"beard_1\":5,\"decals_2\":0,\"beard_4\":0,\"shoes_2\":0,\"tshirt_2\":0,\"lipstick_2\":0,\"hair_2\":0,\"arms\":67,\"pants_1\":36,\"skin\":29,\"eyebrows_2\":0,\"shoes\":10,\"helmet_1\":-1,\"lipstick_1\":0,\"helmet_2\":0,\"hair_color_1\":0,\"glasses\":0,\"makeup_4\":0,\"makeup_1\":0,\"hair_1\":2,\"bproof_1\":0,\"bags_1\":0,\"mask_1\":0,\"lipstick_3\":0,\"chain_1\":0,\"eyebrows_4\":0,\"sex\":0,\"torso_1\":56,\"beard_2\":6,\"shoes_1\":12,\"decals_1\":0,\"face\":19,\"lipstick_4\":0,\"tshirt_1\":15,\"mask_2\":0,\"age_2\":0,\"eyebrows_3\":0,\"chain_2\":0,\"glasses_1\":0,\"ears_1\":-1,\"bags_2\":0,\"ears_2\":0,\"torso_2\":0,\"bproof_2\":0,\"makeup_2\":0,\"eyebrows_1\":0,\"makeup_3\":0,\"pants_2\":0,\"beard_3\":0,\"hair_color_2\":4}'),
(14, 'miner', 0, 'employee', 'Intérimaire', '{\"tshirt_2\":1,\"ears_1\":8,\"glasses_1\":15,\"torso_2\":0,\"ears_2\":2,\"glasses_2\":3,\"shoes_2\":1,\"pants_1\":75,\"shoes_1\":51,\"bags_1\":0,\"helmet_2\":0,\"pants_2\":7,\"torso_1\":71,\"tshirt_1\":59,\"arms\":2,\"bags_2\":0,\"helmet_1\":0}', '{}'),
(15, 'tabac', 0, 'recrue', 'Tabagiste', '{}', '{}'),
(16, 'tabac', 1, 'gerant', 'Gérant', '{}', '{}'),
(17, 'tabac', 2, 'boss', 'Patron', '{}', '{}'),
(18, 'taxi', 0, 'recrue', 'Recrue', '{\"decals_1\":0,\"hair_2\":0,\"eyebrows_2\":0,\"lipstick_2\":0,\"eyebrows_4\":0,\"face\":0,\"blemishes_1\":0,\"ears_1\":-1,\"hair_1\":0,\"hair_color_2\":1,\"shoes_1\":3,\"blush_1\":0,\"bproof_2\":0,\"sex\":0,\"shoes\":9,\"complexion_1\":0,\"bracelets_1\":-1,\"eye_color\":0,\"age_2\":0,\"bproof_1\":0,\"beard_2\":0,\"chest_1\":0,\"makeup_2\":0,\"eyebrows_1\":0,\"torso_1\":3,\"watches_1\":-1,\"pants_2\":5,\"helmet_1\":-1,\"decals_2\":0,\"chest_3\":0,\"sun_1\":0,\"moles_2\":0,\"bags_1\":0,\"lipstick_4\":0,\"blush_2\":0,\"shoes_2\":0,\"bodyb_2\":0,\"watches_2\":0,\"makeup_3\":0,\"sun_2\":0,\"glasses_1\":0,\"bodyb_1\":0,\"chest_2\":0,\"bracelets_2\":0,\"complexion_2\":0,\"moles_1\":0,\"makeup_1\":0,\"makeup_4\":0,\"ears_2\":0,\"chain_1\":0,\"pants_1\":24,\"blush_3\":0,\"chain_2\":0,\"arms_2\":0,\"torso_2\":0,\"beard_3\":0,\"lipstick_1\":0,\"beard_4\":0,\"arms\":17,\"eyebrows_3\":0,\"glasses_2\":0,\"tshirt_1\":12,\"blemishes_2\":0,\"bags_2\":0,\"hair_color_1\":0,\"beard_1\":0,\"tshirt_2\":0,\"mask_1\":0,\"lipstick_3\":0,\"helmet_2\":0,\"mask_2\":0,\"age_1\":0,\"skin\":4}', '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":57,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":38,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":1,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":21,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":1,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":5,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":1,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":0,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":49,\"pants_1\":11}'),
(19, 'taxi', 1, 'novice', 'Novice', '{\"decals_1\":0,\"hair_2\":0,\"eyebrows_2\":0,\"lipstick_2\":0,\"eyebrows_4\":0,\"face\":0,\"blemishes_1\":0,\"ears_1\":-1,\"hair_1\":0,\"hair_color_2\":1,\"shoes_1\":3,\"blush_1\":0,\"bproof_2\":0,\"sex\":0,\"shoes\":9,\"complexion_1\":0,\"bracelets_1\":-1,\"eye_color\":0,\"age_2\":0,\"bproof_1\":0,\"beard_2\":0,\"chest_1\":0,\"makeup_2\":0,\"eyebrows_1\":0,\"torso_1\":3,\"watches_1\":-1,\"pants_2\":5,\"helmet_1\":-1,\"decals_2\":0,\"chest_3\":0,\"sun_1\":0,\"moles_2\":0,\"bags_1\":0,\"lipstick_4\":0,\"blush_2\":0,\"shoes_2\":0,\"bodyb_2\":0,\"watches_2\":0,\"makeup_3\":0,\"sun_2\":0,\"glasses_1\":0,\"bodyb_1\":0,\"chest_2\":0,\"bracelets_2\":0,\"complexion_2\":0,\"moles_1\":0,\"makeup_1\":0,\"makeup_4\":0,\"ears_2\":0,\"chain_1\":0,\"pants_1\":24,\"blush_3\":0,\"chain_2\":0,\"arms_2\":0,\"torso_2\":0,\"beard_3\":0,\"lipstick_1\":0,\"beard_4\":0,\"arms\":17,\"eyebrows_3\":0,\"glasses_2\":0,\"tshirt_1\":12,\"blemishes_2\":0,\"bags_2\":0,\"hair_color_1\":0,\"beard_1\":0,\"tshirt_2\":0,\"mask_1\":0,\"lipstick_3\":0,\"helmet_2\":0,\"mask_2\":0,\"age_1\":0,\"skin\":4}', '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":57,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":38,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":1,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":21,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":1,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":5,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":1,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":0,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":49,\"pants_1\":11}'),
(20, 'taxi', 2, 'experimente', 'Experimente', '{\"decals_1\":0,\"hair_2\":0,\"eyebrows_2\":0,\"lipstick_2\":0,\"eyebrows_4\":0,\"face\":0,\"blemishes_1\":0,\"ears_1\":-1,\"hair_1\":0,\"hair_color_2\":1,\"shoes_1\":3,\"blush_1\":0,\"bproof_2\":0,\"sex\":0,\"shoes\":9,\"complexion_1\":0,\"bracelets_1\":-1,\"eye_color\":0,\"age_2\":0,\"bproof_1\":0,\"beard_2\":0,\"chest_1\":0,\"makeup_2\":0,\"eyebrows_1\":0,\"torso_1\":3,\"watches_1\":-1,\"pants_2\":5,\"helmet_1\":-1,\"decals_2\":0,\"chest_3\":0,\"sun_1\":0,\"moles_2\":0,\"bags_1\":0,\"lipstick_4\":0,\"blush_2\":0,\"shoes_2\":0,\"bodyb_2\":0,\"watches_2\":0,\"makeup_3\":0,\"sun_2\":0,\"glasses_1\":0,\"bodyb_1\":0,\"chest_2\":0,\"bracelets_2\":0,\"complexion_2\":0,\"moles_1\":0,\"makeup_1\":0,\"makeup_4\":0,\"ears_2\":0,\"chain_1\":0,\"pants_1\":24,\"blush_3\":0,\"chain_2\":0,\"arms_2\":0,\"torso_2\":0,\"beard_3\":0,\"lipstick_1\":0,\"beard_4\":0,\"arms\":17,\"eyebrows_3\":0,\"glasses_2\":0,\"tshirt_1\":12,\"blemishes_2\":0,\"bags_2\":0,\"hair_color_1\":0,\"beard_1\":0,\"tshirt_2\":0,\"mask_1\":0,\"lipstick_3\":0,\"helmet_2\":0,\"mask_2\":0,\"age_1\":0,\"skin\":4}', '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":57,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":38,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":1,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":21,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":1,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":5,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":1,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":0,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":49,\"pants_1\":11}'),
(21, 'taxi', 3, 'uber', 'Uber', '{\"decals_1\":0,\"hair_2\":0,\"eyebrows_2\":0,\"lipstick_2\":0,\"eyebrows_4\":0,\"face\":0,\"blemishes_1\":0,\"ears_1\":-1,\"hair_1\":0,\"hair_color_2\":1,\"shoes_1\":3,\"blush_1\":0,\"bproof_2\":0,\"sex\":0,\"shoes\":9,\"complexion_1\":0,\"bracelets_1\":-1,\"eye_color\":0,\"age_2\":0,\"bproof_1\":0,\"beard_2\":0,\"chest_1\":0,\"makeup_2\":0,\"eyebrows_1\":0,\"torso_1\":3,\"watches_1\":-1,\"pants_2\":5,\"helmet_1\":-1,\"decals_2\":0,\"chest_3\":0,\"sun_1\":0,\"moles_2\":0,\"bags_1\":0,\"lipstick_4\":0,\"blush_2\":0,\"shoes_2\":0,\"bodyb_2\":0,\"watches_2\":0,\"makeup_3\":0,\"sun_2\":0,\"glasses_1\":0,\"bodyb_1\":0,\"chest_2\":0,\"bracelets_2\":0,\"complexion_2\":0,\"moles_1\":0,\"makeup_1\":0,\"makeup_4\":0,\"ears_2\":0,\"chain_1\":0,\"pants_1\":24,\"blush_3\":0,\"chain_2\":0,\"arms_2\":0,\"torso_2\":0,\"beard_3\":0,\"lipstick_1\":0,\"beard_4\":0,\"arms\":17,\"eyebrows_3\":0,\"glasses_2\":0,\"tshirt_1\":12,\"blemishes_2\":0,\"bags_2\":0,\"hair_color_1\":0,\"beard_1\":0,\"tshirt_2\":0,\"mask_1\":0,\"lipstick_3\":0,\"helmet_2\":0,\"mask_2\":0,\"age_1\":0,\"skin\":4}', '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":57,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":38,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":1,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":21,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":1,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":5,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":1,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":0,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":49,\"pants_1\":11}'),
(22, 'taxi', 4, 'boss', 'Patron', '{\"decals_1\":0,\"hair_2\":0,\"eyebrows_2\":0,\"lipstick_2\":0,\"eyebrows_4\":0,\"face\":0,\"blemishes_1\":0,\"ears_1\":-1,\"hair_1\":0,\"hair_color_2\":1,\"shoes_1\":3,\"blush_1\":0,\"bproof_2\":0,\"sex\":0,\"shoes\":9,\"complexion_1\":0,\"bracelets_1\":-1,\"eye_color\":0,\"age_2\":0,\"bproof_1\":0,\"beard_2\":0,\"chest_1\":0,\"makeup_2\":0,\"eyebrows_1\":0,\"torso_1\":3,\"watches_1\":-1,\"pants_2\":5,\"helmet_1\":-1,\"decals_2\":0,\"chest_3\":0,\"sun_1\":0,\"moles_2\":0,\"bags_1\":0,\"lipstick_4\":0,\"blush_2\":0,\"shoes_2\":0,\"bodyb_2\":0,\"watches_2\":0,\"makeup_3\":0,\"sun_2\":0,\"glasses_1\":0,\"bodyb_1\":0,\"chest_2\":0,\"bracelets_2\":0,\"complexion_2\":0,\"moles_1\":0,\"makeup_1\":0,\"makeup_4\":0,\"ears_2\":0,\"chain_1\":0,\"pants_1\":24,\"blush_3\":0,\"chain_2\":0,\"arms_2\":0,\"torso_2\":0,\"beard_3\":0,\"lipstick_1\":0,\"beard_4\":0,\"arms\":17,\"eyebrows_3\":0,\"glasses_2\":0,\"tshirt_1\":12,\"blemishes_2\":0,\"bags_2\":0,\"hair_color_1\":0,\"beard_1\":0,\"tshirt_2\":0,\"mask_1\":0,\"lipstick_3\":0,\"helmet_2\":0,\"mask_2\":0,\"age_1\":0,\"skin\":4}', '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":57,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":38,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":1,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":21,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":1,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":5,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":1,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":0,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":49,\"pants_1\":11}'),
(23, 'cardealer', 0, 'recruit', 'Recrue', '{}', '{}'),
(24, 'cardealer', 1, 'novice', 'Novice', '{}', '{}'),
(25, 'cardealer', 2, 'experienced', 'Experimente', '{}', '{}'),
(26, 'cardealer', 3, 'boss', 'Patron', '{}', '{}'),
(65, 'unicorn', 0, 'barman', 'Barman', '{}', '{}'),
(66, 'unicorn', 1, 'dancer', 'Danseur', '{}', '{}'),
(67, 'unicorn', 2, 'viceboss', 'Co-gérant', '{}', '{}'),
(68, 'unicorn', 3, 'boss', 'Gérant', '{}', '{}'),
(69, 'avocat', 0, 'recruit', 'Recrue', '{\"tshirt_1\":57,\"torso_1\":55,\"arms\":0,\"pants_1\":35,\"glasses\":0,\"decals_2\":0,\"hair_color_2\":0,\"helmet_2\":0,\"hair_color_1\":5,\"face\":19,\"glasses_2\":1,\"torso_2\":0,\"shoes\":24,\"hair_1\":2,\"skin\":34,\"sex\":0,\"glasses_1\":0,\"pants_2\":0,\"hair_2\":0,\"decals_1\":0,\"tshirt_2\":0,\"helmet_1\":8}', '{\"tshirt_1\":34,\"torso_1\":48,\"shoes\":24,\"pants_1\":34,\"torso_2\":0,\"decals_2\":0,\"hair_color_2\":0,\"glasses\":0,\"helmet_2\":0,\"hair_2\":3,\"face\":21,\"decals_1\":0,\"glasses_2\":1,\"hair_1\":11,\"skin\":34,\"sex\":1,\"glasses_1\":5,\"pants_2\":0,\"arms\":14,\"hair_color_1\":10,\"tshirt_2\":0,\"helmet_1\":57}'),
(70, 'avocat', 1, 'boss', 'Patron', '{\"tshirt_1\":58,\"torso_1\":55,\"shoes\":24,\"pants_1\":35,\"pants_2\":0,\"decals_2\":3,\"hair_color_2\":0,\"face\":19,\"helmet_2\":0,\"hair_2\":0,\"arms\":41,\"torso_2\":0,\"hair_color_1\":5,\"hair_1\":2,\"skin\":34,\"sex\":0,\"glasses_1\":0,\"glasses_2\":1,\"decals_1\":8,\"glasses\":0,\"tshirt_2\":0,\"helmet_1\":11}', '{\"tshirt_1\":35,\"torso_1\":48,\"arms\":44,\"pants_1\":34,\"pants_2\":0,\"decals_2\":3,\"hair_color_2\":0,\"face\":21,\"helmet_2\":0,\"hair_2\":3,\"decals_1\":7,\"torso_2\":0,\"hair_color_1\":10,\"hair_1\":11,\"skin\":34,\"sex\":1,\"glasses_1\":5,\"glasses_2\":1,\"shoes\":24,\"glasses\":0,\"tshirt_2\":0,\"helmet_1\":57}'),
(256, 'unemployed2', 0, 'rsa', 'Civil', '{}', '{}'),
(281, 'mechanic', 0, 'recrue', 'Recrue', '{\"decals_2\":0,\"beard_3\":0,\"hair_color_2\":1,\"shoes_2\":0,\"moles_2\":0,\"makeup_3\":0,\"chest_3\":0,\"bags_2\":0,\"helmet_1\":-1,\"eyebrows_1\":0,\"lipstick_1\":0,\"makeup_2\":0,\"mask_1\":0,\"watches_2\":0,\"lipstick_3\":0,\"bracelets_1\":-1,\"makeup_4\":0,\"bodyb_1\":0,\"arms\":17,\"shoes_1\":24,\"age_1\":0,\"arms_2\":0,\"bags_1\":0,\"chest_1\":0,\"complexion_1\":0,\"bproof_2\":0,\"eyebrows_3\":0,\"eye_color\":0,\"lipstick_4\":0,\"glasses_1\":0,\"bracelets_2\":0,\"sex\":0,\"torso_2\":23,\"beard_2\":0,\"blush_2\":0,\"torso_1\":251,\"bodyb_2\":0,\"blemishes_2\":0,\"mask_2\":0,\"beard_4\":0,\"sun_2\":0,\"hair_2\":0,\"tshirt_1\":89,\"skin\":4,\"ears_1\":-1,\"ears_2\":0,\"decals_1\":0,\"eyebrows_2\":0,\"moles_1\":0,\"lipstick_2\":0,\"hair_1\":0,\"blush_1\":0,\"makeup_1\":0,\"helmet_2\":0,\"shoes\":9,\"blush_3\":0,\"pants_1\":98,\"complexion_2\":0,\"tshirt_2\":0,\"pants_2\":17,\"glasses_2\":0,\"watches_1\":-1,\"beard_1\":0,\"eyebrows_4\":0,\"face\":0,\"chest_2\":0,\"age_2\":0,\"blemishes_1\":0,\"chain_1\":0,\"sun_1\":0,\"bproof_1\":0,\"hair_color_1\":0,\"chain_2\":0}', '{}'),
(282, 'mechanic', 1, 'novice', 'Novice', '{\"decals_2\":0,\"beard_3\":0,\"hair_color_2\":1,\"shoes_2\":0,\"moles_2\":0,\"makeup_3\":0,\"chest_3\":0,\"bags_2\":0,\"helmet_1\":-1,\"eyebrows_1\":0,\"lipstick_1\":0,\"makeup_2\":0,\"mask_1\":0,\"watches_2\":0,\"lipstick_3\":0,\"bracelets_1\":-1,\"makeup_4\":0,\"bodyb_1\":0,\"arms\":17,\"shoes_1\":24,\"age_1\":0,\"arms_2\":0,\"bags_1\":0,\"chest_1\":0,\"complexion_1\":0,\"bproof_2\":0,\"eyebrows_3\":0,\"eye_color\":0,\"lipstick_4\":0,\"glasses_1\":0,\"bracelets_2\":0,\"sex\":0,\"torso_2\":23,\"beard_2\":0,\"blush_2\":0,\"torso_1\":251,\"bodyb_2\":0,\"blemishes_2\":0,\"mask_2\":0,\"beard_4\":0,\"sun_2\":0,\"hair_2\":0,\"tshirt_1\":89,\"skin\":4,\"ears_1\":-1,\"ears_2\":0,\"decals_1\":0,\"eyebrows_2\":0,\"moles_1\":0,\"lipstick_2\":0,\"hair_1\":0,\"blush_1\":0,\"makeup_1\":0,\"helmet_2\":0,\"shoes\":9,\"blush_3\":0,\"pants_1\":98,\"complexion_2\":0,\"tshirt_2\":0,\"pants_2\":17,\"glasses_2\":0,\"watches_1\":-1,\"beard_1\":0,\"eyebrows_4\":0,\"face\":0,\"chest_2\":0,\"age_2\":0,\"blemishes_1\":0,\"chain_1\":0,\"sun_1\":0,\"bproof_1\":0,\"hair_color_1\":0,\"chain_2\":0}', '{}'),
(283, 'mechanic', 2, 'experimente', 'Experimente', '{\"decals_2\":0,\"beard_3\":0,\"hair_color_2\":1,\"shoes_2\":0,\"moles_2\":0,\"makeup_3\":0,\"chest_3\":0,\"bags_2\":0,\"helmet_1\":-1,\"eyebrows_1\":0,\"lipstick_1\":0,\"makeup_2\":0,\"mask_1\":0,\"watches_2\":0,\"lipstick_3\":0,\"bracelets_1\":-1,\"makeup_4\":0,\"bodyb_1\":0,\"arms\":17,\"shoes_1\":24,\"age_1\":0,\"arms_2\":0,\"bags_1\":0,\"chest_1\":0,\"complexion_1\":0,\"bproof_2\":0,\"eyebrows_3\":0,\"eye_color\":0,\"lipstick_4\":0,\"glasses_1\":0,\"bracelets_2\":0,\"sex\":0,\"torso_2\":23,\"beard_2\":0,\"blush_2\":0,\"torso_1\":251,\"bodyb_2\":0,\"blemishes_2\":0,\"mask_2\":0,\"beard_4\":0,\"sun_2\":0,\"hair_2\":0,\"tshirt_1\":89,\"skin\":4,\"ears_1\":-1,\"ears_2\":0,\"decals_1\":0,\"eyebrows_2\":0,\"moles_1\":0,\"lipstick_2\":0,\"hair_1\":0,\"blush_1\":0,\"makeup_1\":0,\"helmet_2\":0,\"shoes\":9,\"blush_3\":0,\"pants_1\":98,\"complexion_2\":0,\"tshirt_2\":0,\"pants_2\":17,\"glasses_2\":0,\"watches_1\":-1,\"beard_1\":0,\"eyebrows_4\":0,\"face\":0,\"chest_2\":0,\"age_2\":0,\"blemishes_1\":0,\"chain_1\":0,\"sun_1\":0,\"bproof_1\":0,\"hair_color_1\":0,\"chain_2\":0}', '{}'),
(284, 'mechanic', 3, 'chief', 'Chef d\'équipe', '{\"decals_2\":0,\"beard_3\":0,\"hair_color_2\":1,\"shoes_2\":0,\"moles_2\":0,\"makeup_3\":0,\"chest_3\":0,\"bags_2\":0,\"helmet_1\":-1,\"eyebrows_1\":0,\"lipstick_1\":0,\"makeup_2\":0,\"mask_1\":0,\"watches_2\":0,\"lipstick_3\":0,\"bracelets_1\":-1,\"makeup_4\":0,\"bodyb_1\":0,\"arms\":17,\"shoes_1\":24,\"age_1\":0,\"arms_2\":0,\"bags_1\":0,\"chest_1\":0,\"complexion_1\":0,\"bproof_2\":0,\"eyebrows_3\":0,\"eye_color\":0,\"lipstick_4\":0,\"glasses_1\":0,\"bracelets_2\":0,\"sex\":0,\"torso_2\":23,\"beard_2\":0,\"blush_2\":0,\"torso_1\":251,\"bodyb_2\":0,\"blemishes_2\":0,\"mask_2\":0,\"beard_4\":0,\"sun_2\":0,\"hair_2\":0,\"tshirt_1\":89,\"skin\":4,\"ears_1\":-1,\"ears_2\":0,\"decals_1\":0,\"eyebrows_2\":0,\"moles_1\":0,\"lipstick_2\":0,\"hair_1\":0,\"blush_1\":0,\"makeup_1\":0,\"helmet_2\":0,\"shoes\":9,\"blush_3\":0,\"pants_1\":98,\"complexion_2\":0,\"tshirt_2\":0,\"pants_2\":17,\"glasses_2\":0,\"watches_1\":-1,\"beard_1\":0,\"eyebrows_4\":0,\"face\":0,\"chest_2\":0,\"age_2\":0,\"blemishes_1\":0,\"chain_1\":0,\"sun_1\":0,\"bproof_1\":0,\"hair_color_1\":0,\"chain_2\":0}', '{}'),
(285, 'mechanic', 4, 'boss', 'Patron', '{\"decals_2\":0,\"beard_3\":0,\"hair_color_2\":1,\"shoes_2\":0,\"moles_2\":0,\"makeup_3\":0,\"chest_3\":0,\"bags_2\":0,\"helmet_1\":-1,\"eyebrows_1\":0,\"lipstick_1\":0,\"makeup_2\":0,\"mask_1\":0,\"watches_2\":0,\"lipstick_3\":0,\"bracelets_1\":-1,\"makeup_4\":0,\"bodyb_1\":0,\"arms\":17,\"shoes_1\":24,\"age_1\":0,\"arms_2\":0,\"bags_1\":0,\"chest_1\":0,\"complexion_1\":0,\"bproof_2\":0,\"eyebrows_3\":0,\"eye_color\":0,\"lipstick_4\":0,\"glasses_1\":0,\"bracelets_2\":0,\"sex\":0,\"torso_2\":23,\"beard_2\":0,\"blush_2\":0,\"torso_1\":251,\"bodyb_2\":0,\"blemishes_2\":0,\"mask_2\":0,\"beard_4\":0,\"sun_2\":0,\"hair_2\":0,\"tshirt_1\":89,\"skin\":4,\"ears_1\":-1,\"ears_2\":0,\"decals_1\":0,\"eyebrows_2\":0,\"moles_1\":0,\"lipstick_2\":0,\"hair_1\":0,\"blush_1\":0,\"makeup_1\":0,\"helmet_2\":0,\"shoes\":9,\"blush_3\":0,\"pants_1\":98,\"complexion_2\":0,\"tshirt_2\":0,\"pants_2\":17,\"glasses_2\":0,\"watches_1\":-1,\"beard_1\":0,\"eyebrows_4\":0,\"face\":0,\"chest_2\":0,\"age_2\":0,\"blemishes_1\":0,\"chain_1\":0,\"sun_1\":0,\"bproof_1\":0,\"hair_color_1\":0,\"chain_2\":0}', '{}'),
(485, 'police', 0, 'recruit', 'Recrue', '{}', '{}'),
(486, 'police', 1, 'recruit', 'Cadet', '{}', '{}'),
(487, 'police', 2, 'officer', 'Officier', '{}', '{}'),
(488, 'police', 3, 'sergent', 'Sergent', '{}', '{}'),
(489, 'police', 4, 'lieutenant', 'Lieutenant', '{}', '{}'),
(490, 'police', 5, 'capitaine', 'Capitaine', '{}', '{}'),
(491, 'police', 6, 'boss', 'Commandant', '{}', '{}'),
(539, 'bahamas', 0, 'barman', 'Agent d\'accueil', '{}', '{}'),
(540, 'bahamas', 1, 'dancer', 'Barman / Danseur', '{}', '{}'),
(541, 'bahamas', 2, 'viceboss', 'Manager', '{}', '{}'),
(542, 'bahamas', 3, 'boss', 'Gérant', '{}', '{}'),
(543, 'yellow', 0, 'barman', 'Barman', '{}', '{}'),
(544, 'yellow', 1, 'dancer', 'Danseur', '{}', '{}'),
(545, 'yellow', 2, 'viceboss', 'Co-gérant', '{}', '{}'),
(546, 'yellow', 3, 'boss', 'Gérant', '{}', '{}'),
(547, 'weedshop', 0, 'recrue', 'recrue', 'null', 'null'),
(549, 'weedshop', 1, 'experimenter', 'experimenter', 'null', 'null'),
(550, 'weedshop', 2, 'boss', 'Chef', 'null', 'null'),
(557, 'vigneron', 0, 'recrue', 'Intérimaire', '{\"tshirt_1\":59,\"tshirt_2\":0,\"torso_1\":12,\"torso_2\":5,\"shoes_1\":7,\"shoes_2\":2,\"pants_1\":9, \"pants_2\":7, \"arms\":1, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}', '{\"tshirt_1\":0,\"tshirt_2\":0,\"torso_1\":56,\"torso_2\":0,\"shoes_1\":27,\"shoes_2\":0,\"pants_1\":36, \"pants_2\":0, \"arms\":63, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}'),
(558, 'vigneron', 1, 'novice', 'vigneron', '{\"tshirt_1\":57,\"tshirt_2\":0,\"torso_1\":13,\"torso_2\":5,\"shoes_1\":7,\"shoes_2\":2,\"pants_1\":9, \"pants_2\":7, \"arms\":11, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}', '{\"tshirt_1\":0,\"tshirt_2\":0,\"torso_1\":56,\"torso_2\":0,\"shoes_1\":27,\"shoes_2\":0,\"pants_1\":36, \"pants_2\":0, \"arms\":63, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}'),
(559, 'vigneron', 2, 'cdisenior', 'Chef de chai', '{\"tshirt_1\":57,\"tshirt_2\":0,\"torso_1\":13,\"torso_2\":5,\"shoes_1\":7,\"shoes_2\":2,\"pants_1\":9, \"pants_2\":7, \"arms\":11, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}', '{\"tshirt_1\":0,\"tshirt_2\":0,\"torso_1\":56,\"torso_2\":0,\"shoes_1\":27,\"shoes_2\":0,\"pants_1\":36, \"pants_2\":0, \"arms\":63, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}'),
(560, 'vigneron', 3, 'boss', 'Patron', '{\"tshirt_1\":57,\"tshirt_2\":0,\"torso_1\":13,\"torso_2\":5,\"shoes_1\":7,\"shoes_2\":2,\"pants_1\":9, \"pants_2\":7, \"arms\":11, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}', '{\"tshirt_1\":15,\"tshirt_2\":0,\"torso_1\":14,\"torso_2\":15,\"shoes_1\":12,\"shoes_2\":0,\"pants_1\":9, \"pants_2\":5, \"arms\":1, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}'),
(565, 'label', 0, 'recrue', 'Musiciens label', '{}', '{}'),
(566, 'label', 1, 'gerant', 'Employés label', '{}', '{}'),
(567, 'label', 2, 'boss', 'PDG label', '{}', '{}'),
(597, 'NorthMecano', 0, 'recrue', 'Recrue', '{}', '{}'),
(598, 'NorthMecano', 1, 'novice', 'Novice', '{}', '{}'),
(599, 'NorthMecano', 2, 'experimente', 'Experimente', '{}', '{}'),
(600, 'NorthMecano', 3, 'chief', 'Chef d\'équipe', '{}', '{}'),
(601, 'NorthMecano', 4, 'boss', 'Patron', '{}', '{}'),
(608, 'bcso', 0, 'Junior', 'Junior', '{}', '{}'),
(609, 'bcso', 1, 'Major', 'Major', '{}', '{}'),
(610, 'bcso', 2, 'SheriffAdjoint', 'Sheriff Adjoint', '{}', '{}'),
(611, 'bcso', 3, 'boss', 'Sheriff', '{}', '{}'),
(613, 'Abatteur', 0, 'Abatteur', 'Abatteur', '{}', '{}'),
(614, 'Abatteur', 1, 'boss', 'Patron', '{}', '{}');

-- --------------------------------------------------------

--
-- Structure de la table `leboncoin`
--

CREATE TABLE `leboncoin` (
  `id` int(11) NOT NULL,
  `license` varchar(80) NOT NULL,
  `name` text NOT NULL,
  `description` varchar(150) NOT NULL,
  `model` text NOT NULL,
  `price` int(10) NOT NULL,
  `createdAt` text NOT NULL,
  `plate` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `licenses`
--

CREATE TABLE `licenses` (
  `type` varchar(60) COLLATE utf8mb4_bin NOT NULL,
  `label` varchar(60) COLLATE utf8mb4_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- Contenu de la table `licenses`
--

INSERT INTO `licenses` (`type`, `label`) VALUES
('dmv', 'Code de la route'),
('drive', 'Permis de conduire'),
('drive_bike', 'Permis moto'),
('drive_truck', 'Permis camion'),
('weapon', 'Permis de port d\'arme');

-- --------------------------------------------------------

--
-- Structure de la table `lottery`
--

CREATE TABLE `lottery` (
  `id` int(11) NOT NULL,
  `expireDate` int(11) NOT NULL DEFAULT '0',
  `totalMoney` int(11) NOT NULL DEFAULT '5000',
  `participationCount` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `lottery`
--

INSERT INTO `lottery` (`id`, `expireDate`, `totalMoney`, `participationCount`) VALUES
(1, 1638004633, 159000, 4);

-- --------------------------------------------------------

--
-- Structure de la table `owned_properties`
--

CREATE TABLE `owned_properties` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `price` double NOT NULL,
  `rented` int(11) NOT NULL,
  `owner` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `owned_rented`
--

CREATE TABLE `owned_rented` (
  `id` int(11) NOT NULL,
  `identifier` varchar(255) NOT NULL DEFAULT '0',
  `plate` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Structure de la table `owned_vehicles`
--

CREATE TABLE `owned_vehicles` (
  `owner` varchar(60) NOT NULL,
  `state` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'State of the car',
  `plate` varchar(12) NOT NULL,
  `vehicle` longtext,
  `vehicleName` varchar(30) DEFAULT 'Voiture',
  `type` varchar(20) NOT NULL DEFAULT 'car',
  `isShared` varchar(55) DEFAULT 'no',
  `isBuyed` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `phone_app_chat`
--

CREATE TABLE `phone_app_chat` (
  `id` int(11) NOT NULL,
  `channel` varchar(20) NOT NULL,
  `message` varchar(255) NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `phone_calls`
--

CREATE TABLE `phone_calls` (
  `id` int(11) NOT NULL,
  `owner` varchar(10) NOT NULL COMMENT 'Num tel proprio',
  `num` varchar(10) NOT NULL COMMENT 'Num reférence du contact',
  `incoming` int(11) NOT NULL COMMENT 'Défini si on est à l''origine de l''appels',
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `accepts` int(11) NOT NULL COMMENT 'Appels accepter ou pas'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `phone_messages`
--

CREATE TABLE `phone_messages` (
  `id` int(11) NOT NULL,
  `transmitter` varchar(10) NOT NULL,
  `receiver` varchar(10) NOT NULL,
  `message` varchar(255) NOT NULL DEFAULT '0',
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isRead` int(11) NOT NULL DEFAULT '0',
  `owner` int(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `phone_users_contacts`
--

CREATE TABLE `phone_users_contacts` (
  `id` int(11) NOT NULL,
  `identifier` varchar(60) CHARACTER SET utf8mb4 DEFAULT NULL,
  `number` varchar(10) CHARACTER SET utf8mb4 DEFAULT NULL,
  `display` varchar(64) CHARACTER SET utf8mb4 NOT NULL DEFAULT '-1'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `properties`
--

CREATE TABLE `properties` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `entering` varchar(255) DEFAULT NULL,
  `exit` varchar(255) DEFAULT NULL,
  `inside` varchar(255) DEFAULT NULL,
  `outside` varchar(255) DEFAULT NULL,
  `ipls` varchar(255) DEFAULT '[]',
  `gateway` varchar(255) DEFAULT NULL,
  `is_single` int(11) DEFAULT NULL,
  `is_room` int(11) DEFAULT NULL,
  `is_gateway` int(11) DEFAULT NULL,
  `room_menu` varchar(255) DEFAULT NULL,
  `price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `properties`
--

INSERT INTO `properties` (`id`, `name`, `label`, `entering`, `exit`, `inside`, `outside`, `ipls`, `gateway`, `is_single`, `is_room`, `is_gateway`, `room_menu`, `price`) VALUES
(1, 'WhispymoundDrive', '2677 Whispymound Drive', '{\"y\":564.89,\"z\":182.959,\"x\":119.384}', '{\"x\":117.347,\"y\":559.506,\"z\":183.304}', '{\"y\":557.032,\"z\":183.301,\"x\":118.037}', '{\"y\":567.798,\"z\":182.131,\"x\":119.249}', '[]', NULL, 1, 1, 0, '{\"x\":118.748,\"y\":566.573,\"z\":175.697}', 1500000),
(2, 'NorthConkerAvenue2045', '2045 North Conker Avenue', '{\"x\":372.796,\"y\":428.327,\"z\":144.685}', '{\"x\":373.548,\"y\":422.982,\"z\":144.907},', '{\"y\":420.075,\"z\":145.904,\"x\":372.161}', '{\"x\":372.454,\"y\":432.886,\"z\":143.443}', '[]', NULL, 1, 1, 0, '{\"x\":377.349,\"y\":429.422,\"z\":137.3}', 1500000),
(3, 'RichardMajesticApt2', 'Richard Majestic, Apt 2', '{\"y\":-379.165,\"z\":37.961,\"x\":-936.363}', '{\"y\":-365.476,\"z\":113.274,\"x\":-913.097}', '{\"y\":-367.637,\"z\":113.274,\"x\":-918.022}', '{\"y\":-382.023,\"z\":37.961,\"x\":-943.626}', '[]', NULL, 1, 1, 0, '{\"x\":-927.554,\"y\":-377.744,\"z\":112.674}', 1700000),
(4, 'NorthConkerAvenue2044', '2044 North Conker Avenue', '{\"y\":440.8,\"z\":146.702,\"x\":346.964}', '{\"y\":437.456,\"z\":148.394,\"x\":341.683}', '{\"y\":435.626,\"z\":148.394,\"x\":339.595}', '{\"x\":350.535,\"y\":443.329,\"z\":145.764}', '[]', NULL, 1, 1, 0, '{\"x\":337.726,\"y\":436.985,\"z\":140.77}', 1500000),
(5, 'WildOatsDrive', '3655 Wild Oats Drive', '{\"y\":502.696,\"z\":136.421,\"x\":-176.003}', '{\"y\":497.817,\"z\":136.653,\"x\":-174.349}', '{\"y\":495.069,\"z\":136.666,\"x\":-173.331}', '{\"y\":506.412,\"z\":135.0664,\"x\":-177.927}', '[]', NULL, 1, 1, 0, '{\"x\":-174.725,\"y\":493.095,\"z\":129.043}', 1500000),
(6, 'HillcrestAvenue2862', '2862 Hillcrest Avenue', '{\"y\":596.58,\"z\":142.641,\"x\":-686.554}', '{\"y\":591.988,\"z\":144.392,\"x\":-681.728}', '{\"y\":590.608,\"z\":144.392,\"x\":-680.124}', '{\"y\":599.019,\"z\":142.059,\"x\":-689.492}', '[]', NULL, 1, 1, 0, '{\"x\":-680.46,\"y\":588.6,\"z\":136.769}', 1500000),
(7, 'LowEndApartment', 'Appartement de base', '{\"y\":-1078.735,\"z\":28.4031,\"x\":292.528}', '{\"y\":-1007.152,\"z\":-102.002,\"x\":265.845}', '{\"y\":-1002.802,\"z\":-100.008,\"x\":265.307}', '{\"y\":-1078.669,\"z\":28.401,\"x\":296.738}', '[]', NULL, 1, 1, 0, '{\"x\":265.916,\"y\":-999.38,\"z\":-100.008}', 562500),
(8, 'MadWayneThunder', '2113 Mad Wayne Thunder', '{\"y\":454.955,\"z\":96.462,\"x\":-1294.433}', '{\"x\":-1289.917,\"y\":449.541,\"z\":96.902}', '{\"y\":446.322,\"z\":96.899,\"x\":-1289.642}', '{\"y\":455.453,\"z\":96.517,\"x\":-1298.851}', '[]', NULL, 1, 1, 0, '{\"x\":-1287.306,\"y\":455.901,\"z\":89.294}', 1500000),
(9, 'HillcrestAvenue2874', '2874 Hillcrest Avenue', '{\"x\":-853.346,\"y\":696.678,\"z\":147.782}', '{\"y\":690.875,\"z\":151.86,\"x\":-859.961}', '{\"y\":688.361,\"z\":151.857,\"x\":-859.395}', '{\"y\":701.628,\"z\":147.773,\"x\":-855.007}', '[]', NULL, 1, 1, 0, '{\"x\":-858.543,\"y\":697.514,\"z\":144.253}', 1500000),
(10, 'HillcrestAvenue2868', '2868 Hillcrest Avenue', '{\"y\":620.494,\"z\":141.588,\"x\":-752.82}', '{\"y\":618.62,\"z\":143.153,\"x\":-759.317}', '{\"y\":617.629,\"z\":143.153,\"x\":-760.789}', '{\"y\":621.281,\"z\":141.254,\"x\":-750.919}', '[]', NULL, 1, 1, 0, '{\"x\":-762.504,\"y\":618.992,\"z\":135.53}', 1500000),
(11, 'TinselTowersApt12', 'Tinsel Towers, Apt 42', '{\"y\":37.025,\"z\":42.58,\"x\":-618.299}', '{\"y\":58.898,\"z\":97.2,\"x\":-603.301}', '{\"y\":58.941,\"z\":97.2,\"x\":-608.741}', '{\"y\":30.603,\"z\":42.524,\"x\":-620.017}', '[]', NULL, 1, 1, 0, '{\"x\":-622.173,\"y\":54.585,\"z\":96.599}', 1700000),
(12, 'MiltonDrive', 'Milton Drive', '{\"x\":-775.17,\"y\":312.01,\"z\":84.658}', NULL, NULL, '{\"x\":-775.346,\"y\":306.776,\"z\":84.7}', '[]', NULL, 0, 0, 1, NULL, 0),
(13, 'Modern1Apartment', 'Appartement Moderne 1', NULL, '{\"x\":-784.194,\"y\":323.636,\"z\":210.997}', '{\"x\":-779.751,\"y\":323.385,\"z\":210.997}', NULL, '[\"apa_v_mp_h_01_a\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-766.661,\"y\":327.672,\"z\":210.396}', 1300000),
(14, 'Modern2Apartment', 'Appartement Moderne 2', NULL, '{\"x\":-786.8663,\"y\":315.764,\"z\":186.913}', '{\"x\":-781.808,\"y\":315.866,\"z\":186.913}', NULL, '[\"apa_v_mp_h_01_c\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-795.735,\"y\":326.757,\"z\":186.313}', 1300000),
(15, 'Modern3Apartment', 'Appartement Moderne 3', NULL, '{\"x\":-774.012,\"y\":342.042,\"z\":195.686}', '{\"x\":-779.057,\"y\":342.063,\"z\":195.686}', NULL, '[\"apa_v_mp_h_01_b\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-765.386,\"y\":330.782,\"z\":195.08}', 1300000),
(16, 'Mody1Apartment', 'Appartement Mode 1', NULL, '{\"x\":-784.194,\"y\":323.636,\"z\":210.997}', '{\"x\":-779.751,\"y\":323.385,\"z\":210.997}', NULL, '[\"apa_v_mp_h_02_a\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-766.615,\"y\":327.878,\"z\":210.396}', 1300000),
(17, 'Mody2Apartment', 'Appartement Mode 2', NULL, '{\"x\":-786.8663,\"y\":315.764,\"z\":186.913}', '{\"x\":-781.808,\"y\":315.866,\"z\":186.913}', NULL, '[\"apa_v_mp_h_02_c\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-795.297,\"y\":327.092,\"z\":186.313}', 1300000),
(18, 'Mody3Apartment', 'Appartement Mode 3', NULL, '{\"x\":-774.012,\"y\":342.042,\"z\":195.686}', '{\"x\":-779.057,\"y\":342.063,\"z\":195.686}', NULL, '[\"apa_v_mp_h_02_b\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-765.303,\"y\":330.932,\"z\":195.085}', 1300000),
(19, 'Vibrant1Apartment', 'Appartement Vibrant 1', NULL, '{\"x\":-784.194,\"y\":323.636,\"z\":210.997}', '{\"x\":-779.751,\"y\":323.385,\"z\":210.997}', NULL, '[\"apa_v_mp_h_03_a\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-765.885,\"y\":327.641,\"z\":210.396}', 1300000),
(20, 'Vibrant2Apartment', 'Appartement Vibrant 2', NULL, '{\"x\":-786.8663,\"y\":315.764,\"z\":186.913}', '{\"x\":-781.808,\"y\":315.866,\"z\":186.913}', NULL, '[\"apa_v_mp_h_03_c\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-795.607,\"y\":327.344,\"z\":186.313}', 1300000),
(21, 'Vibrant3Apartment', 'Appartement Vibrant 3', NULL, '{\"x\":-774.012,\"y\":342.042,\"z\":195.686}', '{\"x\":-779.057,\"y\":342.063,\"z\":195.686}', NULL, '[\"apa_v_mp_h_03_b\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-765.525,\"y\":330.851,\"z\":195.085}', 1300000),
(22, 'Sharp1Apartment', 'Appartement Persan 1', NULL, '{\"x\":-784.194,\"y\":323.636,\"z\":210.997}', '{\"x\":-779.751,\"y\":323.385,\"z\":210.997}', NULL, '[\"apa_v_mp_h_04_a\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-766.527,\"y\":327.89,\"z\":210.396}', 1300000),
(23, 'Sharp2Apartment', 'Appartement Persan 2', NULL, '{\"x\":-786.8663,\"y\":315.764,\"z\":186.913}', '{\"x\":-781.808,\"y\":315.866,\"z\":186.913}', NULL, '[\"apa_v_mp_h_04_c\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-795.642,\"y\":326.497,\"z\":186.313}', 1300000),
(24, 'Sharp3Apartment', 'Appartement Persan 3', NULL, '{\"x\":-774.012,\"y\":342.042,\"z\":195.686}', '{\"x\":-779.057,\"y\":342.063,\"z\":195.686}', NULL, '[\"apa_v_mp_h_04_b\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-765.503,\"y\":331.318,\"z\":195.085}', 1300000),
(25, 'Monochrome1Apartment', 'Appartement Monochrome 1', NULL, '{\"x\":-784.194,\"y\":323.636,\"z\":210.997}', '{\"x\":-779.751,\"y\":323.385,\"z\":210.997}', NULL, '[\"apa_v_mp_h_05_a\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-766.289,\"y\":328.086,\"z\":210.396}', 1300000),
(26, 'Monochrome2Apartment', 'Appartement Monochrome 2', NULL, '{\"x\":-786.8663,\"y\":315.764,\"z\":186.913}', '{\"x\":-781.808,\"y\":315.866,\"z\":186.913}', NULL, '[\"apa_v_mp_h_05_c\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-795.692,\"y\":326.762,\"z\":186.313}', 1300000),
(27, 'Monochrome3Apartment', 'Appartement Monochrome 3', NULL, '{\"x\":-774.012,\"y\":342.042,\"z\":195.686}', '{\"x\":-779.057,\"y\":342.063,\"z\":195.686}', NULL, '[\"apa_v_mp_h_05_b\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-765.094,\"y\":330.976,\"z\":195.085}', 1300000),
(28, 'Seductive1Apartment', 'Appartement Séduisant 1', NULL, '{\"x\":-784.194,\"y\":323.636,\"z\":210.997}', '{\"x\":-779.751,\"y\":323.385,\"z\":210.997}', NULL, '[\"apa_v_mp_h_06_a\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-766.263,\"y\":328.104,\"z\":210.396}', 1300000),
(29, 'Seductive2Apartment', 'Appartement Séduisant 2', NULL, '{\"x\":-786.8663,\"y\":315.764,\"z\":186.913}', '{\"x\":-781.808,\"y\":315.866,\"z\":186.913}', NULL, '[\"apa_v_mp_h_06_c\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-795.655,\"y\":326.611,\"z\":186.313}', 1300000),
(30, 'Seductive3Apartment', 'Appartement Séduisant 3', NULL, '{\"x\":-774.012,\"y\":342.042,\"z\":195.686}', '{\"x\":-779.057,\"y\":342.063,\"z\":195.686}', NULL, '[\"apa_v_mp_h_06_b\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-765.3,\"y\":331.414,\"z\":195.085}', 1300000),
(31, 'Regal1Apartment', 'Appartement Régal 1', NULL, '{\"x\":-784.194,\"y\":323.636,\"z\":210.997}', '{\"x\":-779.751,\"y\":323.385,\"z\":210.997}', NULL, '[\"apa_v_mp_h_07_a\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-765.956,\"y\":328.257,\"z\":210.396}', 1300000),
(32, 'Regal2Apartment', 'Appartement Régal 2', NULL, '{\"x\":-786.8663,\"y\":315.764,\"z\":186.913}', '{\"x\":-781.808,\"y\":315.866,\"z\":186.913}', NULL, '[\"apa_v_mp_h_07_c\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-795.545,\"y\":326.659,\"z\":186.313}', 1300000),
(33, 'Regal3Apartment', 'Appartement Régal 3', NULL, '{\"x\":-774.012,\"y\":342.042,\"z\":195.686}', '{\"x\":-779.057,\"y\":342.063,\"z\":195.686}', NULL, '[\"apa_v_mp_h_07_b\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-765.087,\"y\":331.429,\"z\":195.123}', 1300000),
(34, 'Aqua1Apartment', 'Appartement Aqua 1', NULL, '{\"x\":-784.194,\"y\":323.636,\"z\":210.997}', '{\"x\":-779.751,\"y\":323.385,\"z\":210.997}', NULL, '[\"apa_v_mp_h_08_a\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-766.187,\"y\":328.47,\"z\":210.396}', 1300000),
(35, 'Aqua2Apartment', 'Appartement Aqua 2', NULL, '{\"x\":-786.8663,\"y\":315.764,\"z\":186.913}', '{\"x\":-781.808,\"y\":315.866,\"z\":186.913}', NULL, '[\"apa_v_mp_h_08_c\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-795.658,\"y\":326.563,\"z\":186.313}', 1300000),
(36, 'Aqua3Apartment', 'Appartement Aqua 3', NULL, '{\"x\":-774.012,\"y\":342.042,\"z\":195.686}', '{\"x\":-779.057,\"y\":342.063,\"z\":195.686}', NULL, '[\"apa_v_mp_h_08_b\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-765.287,\"y\":331.084,\"z\":195.086}', 1300000),
(37, 'IntegrityWay', '4 Integrity Way', '{\"x\":-47.804,\"y\":-585.867,\"z\":36.956}', NULL, NULL, '{\"x\":-54.178,\"y\":-583.762,\"z\":35.798}', '[]', NULL, 0, 0, 1, NULL, 0),
(38, 'IntegrityWay28', '4 Integrity Way - Apt 28', NULL, '{\"x\":-31.409,\"y\":-594.927,\"z\":79.03}', '{\"x\":-26.098,\"y\":-596.909,\"z\":79.03}', NULL, '[]', 'IntegrityWay', 0, 1, 0, '{\"x\":-11.923,\"y\":-597.083,\"z\":78.43}', 1700000),
(39, 'IntegrityWay30', '4 Integrity Way - Apt 30', NULL, '{\"x\":-17.702,\"y\":-588.524,\"z\":89.114}', '{\"x\":-16.21,\"y\":-582.569,\"z\":89.114}', NULL, '[]', 'IntegrityWay', 0, 1, 0, '{\"x\":-26.327,\"y\":-588.384,\"z\":89.123}', 1700000),
(40, 'DellPerroHeights', 'Dell Perro Heights', '{\"x\":-1447.06,\"y\":-538.28,\"z\":33.74}', NULL, NULL, '{\"x\":-1440.022,\"y\":-548.696,\"z\":33.74}', '[]', NULL, 0, 0, 1, NULL, 0),
(41, 'DellPerroHeightst4', 'Dell Perro Heights - Apt 28', NULL, '{\"x\":-1452.125,\"y\":-540.591,\"z\":73.044}', '{\"x\":-1455.435,\"y\":-535.79,\"z\":73.044}', NULL, '[]', 'DellPerroHeights', 0, 1, 0, '{\"x\":-1467.058,\"y\":-527.571,\"z\":72.443}', 1700000),
(42, 'DellPerroHeightst7', 'Dell Perro Heights - Apt 30', NULL, '{\"x\":-1451.562,\"y\":-523.535,\"z\":55.928}', '{\"x\":-1456.02,\"y\":-519.209,\"z\":55.929}', NULL, '[]', 'DellPerroHeights', 0, 1, 0, '{\"x\":-1457.026,\"y\":-530.219,\"z\":55.937}', 1700000),
(667, 'creator', 'Creation de personnage', '{\"x\":-23433.86,\"y\":-233001.328,\"z\":24.959}', NULL, '{\"x\":-235.53,\"y\":-2003.1,\"z\":24.80}', '{\"x\":-235.53,\"y\":-2003.1,\"z\":24.80}', '[]', NULL, 1, 1, 0, NULL, 0);

-- --------------------------------------------------------

--
-- Structure de la table `rented_vehicles`
--

CREATE TABLE `rented_vehicles` (
  `vehicle` varchar(60) NOT NULL,
  `plate` varchar(12) NOT NULL,
  `player_name` varchar(255) NOT NULL,
  `base_price` int(11) NOT NULL,
  `rent_price` int(11) NOT NULL,
  `owner` varchar(22) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `trunk_inventory`
--

CREATE TABLE `trunk_inventory` (
  `id` int(11) NOT NULL,
  `plate` varchar(8) NOT NULL,
  `data` text NOT NULL,
  `owned` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `boutique_id` int(11) NOT NULL,
  `identifier` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `license` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_bin DEFAULT '',
  `skin` longtext COLLATE utf8mb4_bin,
  `job` varchar(255) COLLATE utf8mb4_bin DEFAULT 'unemployed',
  `job_grade` int(11) DEFAULT '0',
  `job2` varchar(255) COLLATE utf8mb4_bin DEFAULT 'unemployed2',
  `job2_grade` int(11) DEFAULT '0',
  `loadout` longtext COLLATE utf8mb4_bin,
  `position` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `group` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `firstname` varchar(50) COLLATE utf8mb4_bin DEFAULT '',
  `lastname` varchar(50) COLLATE utf8mb4_bin DEFAULT '',
  `dateofbirth` varchar(25) COLLATE utf8mb4_bin DEFAULT '',
  `sex` varchar(10) COLLATE utf8mb4_bin DEFAULT '',
  `height` varchar(5) COLLATE utf8mb4_bin DEFAULT '',
  `last_property` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `phone_number` varchar(15) COLLATE utf8mb4_bin DEFAULT 'PasDeNumero',
  `is_dead` tinyint(1) DEFAULT '0',
  `skills` longtext COLLATE utf8mb4_bin,
  `tattoos` longtext COLLATE utf8mb4_bin,
  `accounts` longtext COLLATE utf8mb4_bin,
  `inventory` longtext COLLATE utf8mb4_bin,
  `origine` varchar(20) CHARACTER SET armscii8 COLLATE armscii8_bin NOT NULL DEFAULT 'Los Santos',
  `pet` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `PetName` varchar(15) COLLATE utf8mb4_bin NOT NULL DEFAULT 'Roger',
  `roue` int(11) NOT NULL DEFAULT '1',
  `report` int(11) NOT NULL DEFAULT '0',
  `TimeToWait` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Structure de la table `user_accessories`
--

CREATE TABLE `user_accessories` (
  `identifier` varchar(255) NOT NULL,
  `id` int(11) NOT NULL,
  `mask` varchar(30) NOT NULL,
  `type` varchar(30) NOT NULL,
  `label` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `user_licenses`
--

CREATE TABLE `user_licenses` (
  `id` int(11) NOT NULL,
  `Voiture` varchar(5) NOT NULL DEFAULT 'NON',
  `Armes` varchar(10) NOT NULL DEFAULT 'NON',
  `PPACHECK` int(11) NOT NULL DEFAULT '0',
  `Chasse` varchar(5) NOT NULL DEFAULT 'NON',
  `Camion` varchar(5) NOT NULL DEFAULT 'NON',
  `Moto` varchar(5) DEFAULT 'NON',
  `taille` varchar(20) DEFAULT NULL,
  `owner` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `user_lottery`
--

CREATE TABLE `user_lottery` (
  `id` int(11) NOT NULL,
  `identifier` varchar(55) NOT NULL,
  `nickname` varchar(20) NOT NULL,
  `amount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `user_tenue`
--

CREATE TABLE `user_tenue` (
  `id` int(11) NOT NULL,
  `identifier` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `tenue` longtext COLLATE utf8mb4_bin NOT NULL,
  `label` varchar(55) COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Structure de la table `vape_ban`
--

CREATE TABLE `vape_ban` (
  `license` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `identifier` varchar(25) COLLATE utf8mb4_bin DEFAULT NULL,
  `liveid` varchar(21) COLLATE utf8mb4_bin DEFAULT NULL,
  `xblid` varchar(21) COLLATE utf8mb4_bin DEFAULT NULL,
  `discord` varchar(30) COLLATE utf8mb4_bin DEFAULT NULL,
  `playerip` varchar(25) COLLATE utf8mb4_bin DEFAULT NULL,
  `targetplayername` varchar(32) COLLATE utf8mb4_bin DEFAULT NULL,
  `sourceplayername` varchar(32) COLLATE utf8mb4_bin DEFAULT NULL,
  `reason` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `timeat` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `expiration` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `permanent` int(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- Index pour les tables exportées
--

--
-- Index pour la table `addon_account`
--
ALTER TABLE `addon_account`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `addon_account_data`
--
ALTER TABLE `addon_account_data`
  ADD PRIMARY KEY (`id`),
  ADD KEY `owner` (`owner`(191)),
  ADD KEY `account_name` (`account_name`(191)),
  ADD KEY `id` (`id`);

--
-- Index pour la table `addon_inventory`
--
ALTER TABLE `addon_inventory`
  ADD PRIMARY KEY (`name`);

--
-- Index pour la table `addon_inventory_items`
--
ALTER TABLE `addon_inventory_items`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `armes`
--
ALTER TABLE `armes`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Index pour la table `baninfo`
--
ALTER TABLE `baninfo`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `banlist`
--
ALTER TABLE `banlist`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `identifier` (`identifier`,`license`,`liveid`,`xblid`,`discord`) USING BTREE;

--
-- Index pour la table `datastore`
--
ALTER TABLE `datastore`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `datastore_data`
--
ALTER TABLE `datastore_data`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `index_datastore_data_name_owner` (`name`,`owner`),
  ADD KEY `index_datastore_data_name` (`name`);

--
-- Index pour la table `eventsPresets`
--
ALTER TABLE `eventsPresets`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `gangs`
--
ALTER TABLE `gangs`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `hotel_rooms`
--
ALTER TABLE `hotel_rooms`
  ADD PRIMARY KEY (`identifier`);

--
-- Index pour la table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`name`);

--
-- Index pour la table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`name`);

--
-- Index pour la table `job_grades`
--
ALTER TABLE `job_grades`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `leboncoin`
--
ALTER TABLE `leboncoin`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `lottery`
--
ALTER TABLE `lottery`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `owned_properties`
--
ALTER TABLE `owned_properties`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `owned_rented`
--
ALTER TABLE `owned_rented`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `plate` (`plate`) USING BTREE,
  ADD KEY `id` (`id`) USING BTREE;

--
-- Index pour la table `owned_vehicles`
--
ALTER TABLE `owned_vehicles`
  ADD PRIMARY KEY (`plate`);

--
-- Index pour la table `phone_calls`
--
ALTER TABLE `phone_calls`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `phone_messages`
--
ALTER TABLE `phone_messages`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `phone_users_contacts`
--
ALTER TABLE `phone_users_contacts`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `properties`
--
ALTER TABLE `properties`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `rented_vehicles`
--
ALTER TABLE `rented_vehicles`
  ADD PRIMARY KEY (`plate`);

--
-- Index pour la table `trunk_inventory`
--
ALTER TABLE `trunk_inventory`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`identifier`),
  ADD UNIQUE KEY `boutique_id` (`boutique_id`);

--
-- Index pour la table `user_accessories`
--
ALTER TABLE `user_accessories`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `user_licenses`
--
ALTER TABLE `user_licenses`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `user_lottery`
--
ALTER TABLE `user_lottery`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `user_tenue`
--
ALTER TABLE `user_tenue`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `vape_ban`
--
ALTER TABLE `vape_ban`
  ADD PRIMARY KEY (`license`);

--
-- AUTO_INCREMENT pour les tables exportées
--

--
-- AUTO_INCREMENT pour la table `addon_account_data`
--
ALTER TABLE `addon_account_data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7840;
--
-- AUTO_INCREMENT pour la table `addon_inventory_items`
--
ALTER TABLE `addon_inventory_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT pour la table `armes`
--
ALTER TABLE `armes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `baninfo`
--
ALTER TABLE `baninfo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `banlist`
--
ALTER TABLE `banlist`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT pour la table `datastore`
--
ALTER TABLE `datastore`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=106;
--
-- AUTO_INCREMENT pour la table `datastore_data`
--
ALTER TABLE `datastore_data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `eventsPresets`
--
ALTER TABLE `eventsPresets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT pour la table `gangs`
--
ALTER TABLE `gangs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT pour la table `job_grades`
--
ALTER TABLE `job_grades`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=615;
--
-- AUTO_INCREMENT pour la table `leboncoin`
--
ALTER TABLE `leboncoin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `lottery`
--
ALTER TABLE `lottery`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT pour la table `owned_properties`
--
ALTER TABLE `owned_properties`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `owned_rented`
--
ALTER TABLE `owned_rented`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `phone_calls`
--
ALTER TABLE `phone_calls`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `phone_messages`
--
ALTER TABLE `phone_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `phone_users_contacts`
--
ALTER TABLE `phone_users_contacts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `properties`
--
ALTER TABLE `properties`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=668;
--
-- AUTO_INCREMENT pour la table `trunk_inventory`
--
ALTER TABLE `trunk_inventory`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `boutique_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;
--
-- AUTO_INCREMENT pour la table `user_accessories`
--
ALTER TABLE `user_accessories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `user_licenses`
--
ALTER TABLE `user_licenses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `user_lottery`
--
ALTER TABLE `user_lottery`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=410;
--
-- AUTO_INCREMENT pour la table `user_tenue`
--
ALTER TABLE `user_tenue`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
