----------------------------------------------------------------------------------------
-- SMITE GODS DATABASE
-- by Nicholas Barranco
-- Tested on Postgres 9.6.1
-- Working as of 12/8/16
----------------------------------------------------------------------------------------


DROP TABLE IF EXISTS GodSelect CASCADE;
DROP TABLE IF EXISTS Items CASCADE;
DROP TABLE IF EXISTS Inventory CASCADE;
DROP TABLE IF EXISTS Players CASCADE;
DROP TABLE IF EXISTS Abilities CASCADE;
DROP TABLE IF EXISTS Gods CASCADE;

--------------
--Gods Table--
--------------
--
--God table for all the playable characters in which it shows the name of the God
--the type of God they are (Greek, Roman, Norse, etc.) the Class which is the battle type
--and the number of abilities each God can use.
--
CREATE TABLE Gods (GodName				text not null primary key,
				   Pantheon				text not null,
				   Class				text not null,
				   numAbilities       	int
);


---------------
-- Abilities --
---------------
--
--Table for where the Ability for a God in which it displays what the ability name
--is, the God that has the ability, the type of power (whether or not its melee or ranged),
--the ability type (magical or physical), and finally the type of ability.(Cone, Debuff, etc.)
--
CREATE TABLE Abilities (AbilityName			text not null primary key,
						GodName				text not null references Gods (GodName),
						PowerType			text not null,
						AbilityType			text not null,
						TypeOfAbility	    text not null
);

-------------
-- Players --
-------------
--
--The player which is the most important table shows what the UsersName is
--and what their Real Name is. Their level for their profile, as well as the
--number of wins and losses the player has.
--
CREATE TABLE Players (UserName				text not null unique primary key,
					  RealName				text,
					  SmiteLvl		    	int,
					  numWins				int,
		              numLoss				int
);


----------------
-- God Select -- 
----------------
--
--Shows what the player chose in terms of what God they chose to play.
--
CREATE TABLE GodSelect (UserName			text not null references Players (UserName),
					    GodName				text not null references Gods (GodName)
);


---------------
-- Inventory --
--------------- 
--
--Shows the users inventory id as well as the max amount of items
--the user can have in one game as well as the current amount of items
--the user is holding currently
--
CREATE TABLE Inventory (invid				serial primary key,
						UserName 			text not null references Players (UserName),
						ItemSlotsMax		int,
						numItems			int
);



-----------
-- Items --
-----------
--
--All the item names and the amount of times it can be user as well as
--the tier in which the item can be found at within the game. Sorted by
--the invid in which each player holds that item currently and finally
--if the item can be traded.
--
CREATE TABLE Items (itemName	 		text not null primary key,
				    invid				int references Inventory (invid),
					NumOfUses			int,
					Tier				int,
					TradeItem			boolean not null
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
--
--I'd Like to note that Trumpler is my actual username in another MOBA... not even for Smite but go with it
--

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
					 ('TheRealDanielCraig', 6, 1),
					 ('PinheadLarry', 6,  2),
					 ('Wheatley', 6, 4);

					 
-----------
-- Items --
-----------
INSERT INTO Items(itemName, invid, NumOfUses, Tier, TradeItem)
		   VALUES('Boots', 1, 0, 1, true),
				 ('Ancient Blade', 2, 0, 1, true),
				 ('Tiny Trincket', 2, 1, 1, false),
				 ('Mace', 3, 0, 1, true),
				 ('Steel Mail', 4, 0, 2, false),
				 ('Spell Focus', 5, 3, 2, false),
				 ('Rod of Healing', 1, 0, 2, true),
				 ('Doom Orb', 3, 0, 2, false),
				 ('Stone Gaia', 4, 0, 3, true),
				 ('Ancile', 4, 0, 3, false),
				 ('Odysseus Bow', 2, 0, 3, true),
				 ('Malice', 5, 0, 3, true);

				 
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
ORDER BY GodName ASC;

CREATE VIEW InventoryAndItems AS
Select i.itemName, i.invid, i.NumOfUses, i.Tier,
       n.UserName, n.ItemSlotsMax, n.numItems
    FROM Items i
    Join Inventory n
    On i.invid = i.invid;
    
SELECT * FROM InventoryAndItems
WHERE NumOfUses = 3;
ORDER BY username ASC;

------------------------------
-- Reports and Test Queries --
------------------------------

--
-- Orders it by type of God (ie. Greek, Roman, etc.)
--
SELECT * FROM Gods
ORDER BY Pantheon ASC;

--
--Class is interchangable with any of the four classes
--So 'Guardian' can be changed with Warrior Hunter or Assassin.
--
SELECT * FROM Gods
WHERE Class = 'Guardian'
ORDER BY GodName ASC;

--
--Orders it by type of power whether its Melee or Ranged God
--
SELECT * FROM Abilities
ORDER BY PowerType ASC;

--
--Selects the abilities that a line type of ability and sorts them 
--by melee first then magical.
--
SELECT * FROM Abilities
Where TypeOfAbility = 'Line'
ORDER BY PowerType ASC;

--
--Orders it by the users name in order
--
SELECT * FROM Players
Order By UserName ASC;

--
--Selects the User with less than 100 wins.
--
Select * FROM Players
WHERE numWins <= 100
ORDER BY numWins ASC;

--
--Orders it by which God the User Selected.
--
SELECT * FROM GodSelect
ORDER BY GodName ASC;

--
--Selects the God if it is selected
--
Select * FROM GodSelect
WHERE GodName = 'Ra';
--
--We know its obvious why DanielCriag has such a crappy winrate, dont blame the God.
--Although the one below will not display because no one chose the God. (Just as an example.)
--
Select * FROM GodSelect
WHERE GodName = 'Cupid';

--
--Orders it by the users invid.
--
SELECT * FROM Inventory
ORDER BY invid ASC;

--
--Selects the user with a empty inventory
--
SELECT * FROM Inventory
WHERE numItems = 0;
--Cause Daniel Craig can't even get any items cause he sucks.

--
--Orders by the invid.
--
SELECT * FROM Items
ORDER BY invid ASC;

--
--Selects the Item that is the third tier of items
--
SELECT * FROM Items
Where tier = 3;


-----------------------
-- STORED PROCEDURES --
-----------------------
CREATE OR REPLACE FUNCTION tradeItems()
				  RETURNS trigger AS $$
				  DECLARE
				  BEGIN
				  DROP TABLE Items;
				  end;
				  $$ language plpgsql;

SELECT tradeItems();


--------------
-- TRIGGERS --
--------------
DROP TRIGGER IF EXISTS endGame ON Items;
CREATE TRIGGER endGame
after DELETE on Inventory
FOR EACH ROW EXECUTE PROCEDURE tradeItems();
--------------
-- SECURITY --
--------------
Create ROLE Player;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA PUBLIC TO Player;

CREATE ROLE admin WITH LOGIN PASSWORD 'alpaca';
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA PUBLIC TO admin;

CREATE ROLE superadmin WITH LOGIN PASSWORD 'thecakeisalie';
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA PUBLIC TO superadmin;
