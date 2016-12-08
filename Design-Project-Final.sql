----------------------------------------------------------------------------------------
-- SMITE GODS DATABASE
-- by Nicholas Barranco
-- Tested on Postgres 9.6.1
----------------------------------------------------------------------------------------


DROP TABLE IF EXISTS GodSelect;
DROP TABLE IF EXISTS Items;
DROP TABLE IF EXISTS Inventory;
DROP TABLE IF EXISTS Players;
DROP TABLE IF EXISTS Abilities CASCADE;
DROP TABLE IF EXISTS Gods CASCADE;

--------------
--Gods Table--
--------------
CREATE TABLE Gods (GodName				text not null,
				   Pantheon				text not null,
				   Class				text not null,
				   numAbilities       	int,
				   primary key (GodName)
);


---------------
-- Abilities --
---------------
CREATE TABLE Abilities (AbilityName			text not null,
						GodName				text not null references Gods (GodName),
						PowerType			text not null,
						AbilityType			text not null,
						TypeOfAbility	    text,
						primary key(AbilityName)
);

-------------
-- Players --
-------------
CREATE TABLE Players (UserName				text not null unique,
					  RealName				text,
					  SmiteLvl		    	int,
					  numWins				int,
		              numLoss				int,
	                  primary key(UserName)
);


----------------
-- God Select -- 
----------------
CREATE TABLE GodSelect (UserName			text not null references Players (UserName),
					    GodName				text not null references Gods (GodName)
);


---------------
-- Inventory --
--------------- 
CREATE TABLE Inventory (invid				serial primary key,
						UserName 			text not null references Players (UserName),
						ItemSlotsMax		int,
						numItems			int
);



-----------
-- Items --
-----------
CREATE TABLE Items (Name	 			text not null,
				    invid				int references Inventory (invid),
					NumOfUses			int,
					Tier				int,
					primary key(Name)
);

-----------------------------------
-- POPULATING THE SMITE DATABASE --
-----------------------------------


----------
-- Gods --
----------
INSERT INTO Gods (GodName, Pantheon, Class, numAbilities)
		   VALUES('Sun Wukong', 'Chinese', 'Warrior', 4),
				 ('Guan Yu', 'Chinese', 'Warrior', 4),
				 ('Ao Kuang', 'Chinese', 'Mage', 4),
				 ('Hou Yi', 'Chinese', 'Hunter', 4),
				 ('Anubis', 'Egyptian', 'Mage', 4),
				 ('Ra', 'Egyptian', 'Mage', 4),
				 ('Neith', 'Egyptian', 'Hunter', 4),
				 ('Sobek', 'Egyptian', 'Guardian', 4),
				 ('Apollo', 'Greek', 'Hunter', 4),
				 ('Arachne', 'Greek', 'Assassin', 4),
				 ('Zeus', 'Greek', 'Mage', 4),
				 ('Poseidon', 'Greek', 'Mage', 4),
				 ('Rama', 'Hindu', 'Hunter', 4),
				 ('Kumbhakarna', 'Hindu', 'Guardian', 4),
				 ('Vamana', 'Hindu', 'Warrior', 4),
				 ('Kali', 'Hindu', 'Assassin', 4),
				 ('Raijin', 'Japanese', 'Mage', 4),
				 ('Amaterasu', 'Japanese', 'Warrior', 4),
				 ('Izanami', 'Japanese', 'Hunter', 4),
				 ('Susano', 'Japanese', 'Assassin', 4),
				 ('Awilix', 'Mayan', 'Assassin', 4),
				 ('Hun Batz', 'Mayan', 'Assassin', 4),
				 ('Chaac', 'Mayan', 'Warrior', 4),
				 ('Cabrakan', 'Mayan', 'Guardian', 4),
				 ('Odin', 'Norse', 'Warrior', 4),
				 ('Loki', 'Norse', 'Assassin', 4),
				 ('Ymir', 'Norse', 'Guardian', 4),
				 ('Sol', 'Norse', 'Mage', 4),
				 ('Nox', 'Roman', 'Mage', 4),
				 ('Hercules', 'Roman', 'Warrior', 4),
				 ('Mercury', 'Roman', 'Guardian', 4),
				 ('Cupid', 'Roman', 'Hunter', 4);

	
---------------
-- Abilities --
---------------
INSERT INTO Abilities (AbilityName, GodName, PowerType, AbilityType, TypeOfAbility)
				VALUES('The Magic Cudgel', 'Sun Wukong', 'Melee', 'Physical', 'Line'),
					  ('Conviction', 'Guan Yu', 'Melee', 'Magical', 'Area'),
					  ('Mark of the Golden Crow', 'Hou Yi', 'Ranged', 'Physical', 'Debuff'),
					  ('Plague of Locususts', 'Anubis', 'Melee', 'Magical', 'Cone'),
					  ('Heart Bomb', 'Cupid', 'Ranged', 'Physical', 'Projectile'),
					  ('Percussive Storm', 'Raijin', 'Ranged', 'Magical', 'Line'),
					  ('Mitgate Wounds', 'Hercules', 'Melee', 'Phyiscal', 'Buff'),
					  ('Gungnirs Might', 'Odin', 'Melee', 'Physical', 'Area'),
					  ('Trident', 'Poseidon', 'Ranged', 'Magical', 'Buff'),
					  ('Groggy Strike', 'Kumbhakarna', 'Melee', 'Magical', 'Line');
					  

-------------
-- Players --
-------------
INSERT INTO Players (UserName, RealName, SmiteLvl, numWins, numLoss)
			  VALUES('420YoloScope', 'Booker DeWitt', 30, 420, 421),
					('Trumpler', 'Nicholas Barranco', 30, 919, 910),
					('TheRealDanielCraig', 'Daniel Craig', 2, 0, 60),
					('PinheadLarry', 'Hideo Kojima', 12, 28, 32),
					('Wheatley', 'Stephen Merchant', 30, 62, 41);


----------------
-- God Select --
----------------					
INSERT INTO GodSelect (UserName, GodName)
				VALUES('420YoloScope', 'Nox'),
					  ('Trumpler', 'Ymir'),
					  ('TheRealDanielCraig', 'Ra'),
					  ('PinheadLarry', 'Hercules'),
					  ('Wheatley', 'Izanami');
						  
						  
---------------
-- Inventory --
---------------
INSERT INTO Inventory(UserName, ItemSlotsMax, numItems)
			   VALUES('420YoloScope', 6, 6),
					 ('Trumpler', 6, 5),
					 ('TheRealDanielCraig', 6, null),
					 ('PinheadLarry', 6,  2),
					 ('Wheatley', 6, 4);

					 
-----------
-- Items --
-----------
INSERT INTO Items(Name, invid, NumOfUses, Tier)
		   VALUES('Boots', 2, 0, 1),
				 ('Ancient Blade', 3, 0, 1),
				 ('Tiny Trincket', 2, 1, 1),
				 ('Mace', 3, 0, 1),
				 ('Steel Mail', 2, 0, 2),
				 ('Spell Focus', 1, 3, 2),
				 ('Rod of Healing', 1, 0, 2),
				 ('Doom Orb', 2, 0, 2),
				 ('Stone Gaia', 3, 0, 3),
				 ('Ancile', 3, 0, 3),
				 ('Odysseus Bow', 2, 0, 3),
				 ('Malice', 1, 0, 3);
				 
				 
-----------
-- VIEWS --
-----------
CREATE VIEW GodsAndAbilities AS
	 SELECT g.GodName, g.Class, g.numAbilities,
			a.AbilityName, a.PowerType, a.AbilityType, a.TypeOfAbility
	 FROM Gods g
	 JOIN Abilities a
	 ON g.GodName = a.GodName;
	 
SELECT * FROM GodsAndAbilities
WHERE GodName = 'Anubis'
ORDER BY AbilityName ASC;

-------------
-- REPORTS --
-------------
SELECT * FROM Gods
WHERE Class = 'Guardian'
ORDER BY GodName ASC;

-----------------------
-- STORED PROCEDURES --
-----------------------

--------------
-- TRIGGERS --
--------------

--------------
-- SECURITY --
--------------
