﻿package classes
{
import classes.BodyParts.Antennae;
import classes.BodyParts.Arms;
import classes.BodyParts.Ears;
import classes.BodyParts.Eyes;
import classes.BodyParts.Face;
import classes.BodyParts.Gills;
import classes.BodyParts.Hair;
import classes.BodyParts.Horns;
import classes.BodyParts.ISexyPart;
import classes.BodyParts.LowerBody;
import classes.BodyParts.RearBody;
import classes.BodyParts.Skin;
import classes.BodyParts.Tail;
import classes.BodyParts.Tongue;
import classes.BodyParts.Wings;
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.GlobalFlags.kFLAGS;
import classes.Items.Armor;
import classes.Items.ArmorLib;
import classes.Items.Jewelry;
import classes.Items.JewelryLib;
import classes.Items.Mutations;
import classes.Items.Shield;
import classes.Items.ShieldLib;
import classes.Items.Undergarment;
import classes.Items.UndergarmentLib;
import classes.Items.Weapon;
import classes.Items.WeaponLib;
import classes.Items.WeaponRange;
import classes.Items.WeaponRangeLib;
import classes.Scenes.Areas.Forest.KitsuneScene;
import classes.Scenes.Places.TelAdre.UmasShop;
import classes.Scenes.Pregnancy;
import classes.Scenes.SceneLib;
import classes.StatusEffects.VampireThirstEffect;
import classes.internals.Utils;
import classes.lists.BreastCup;

use namespace CoC;

	/**
	 * ...
	 * @author Yoffy
	 */
	public class Player extends Character {
		
		public function Player() {
			//Item things
			itemSlot1 = new ItemSlotClass();
			itemSlot2 = new ItemSlotClass();
			itemSlot3 = new ItemSlotClass();
			itemSlot4 = new ItemSlotClass();
			itemSlot5 = new ItemSlotClass();
			itemSlot6 = new ItemSlotClass();
			itemSlot7 = new ItemSlotClass();
			itemSlot8 = new ItemSlotClass();
			itemSlot9 = new ItemSlotClass();
			itemSlot10 = new ItemSlotClass();
			itemSlots = [itemSlot1, itemSlot2, itemSlot3, itemSlot4, itemSlot5, itemSlot6, itemSlot7, itemSlot8, itemSlot9, itemSlot10];
		}
		
		protected final function outputText(text:String, clear:Boolean = false):void
		{
			if (clear) EngineCore.clearOutputTextOnly();
			EngineCore.outputText(text);
		}
		
		public var startingRace:String = "human";
		
		//Autosave
		public var slotName:String = "VOID";
		public var autoSave:Boolean = false;

		//Lust vulnerability
		//TODO: Kept for backwards compatibility reasons but should be phased out.
		public var lustVuln:Number = 1;

		//Teasing attributes
		public var teaseLevel:Number = 0;
		public var teaseXP:Number = 0;
		
		//Prison stats
		public var hunger:Number = 0; //Also used in survival and realistic mode
		public var obey:Number = 0;
		public var esteem:Number = 0;
		public var will:Number = 0;
		
		public var obeySoftCap:Boolean = true;
		
		//Perks used to store 'queued' perk buys
		public var perkPoints:Number = 0;
		public var statPoints:Number = 0;
		public var ascensionPerkPoints:Number = 0;

		public var tempStr:Number = 0;
		public var tempTou:Number = 0;
		public var tempSpe:Number = 0;
		public var tempInt:Number = 0;
		public var tempWis:Number = 0;
		public var tempLib:Number = 0;
		//Number of times explored for new areas
		public var explored:Number = 0;
		public var exploredForest:Number = 0;
		public var exploredDesert:Number = 0;
		public var exploredMountain:Number = 0;
		public var exploredLake:Number = 0;

		//Player pregnancy variables and functions
		private var pregnancy:Pregnancy = new Pregnancy();
		override public function pregnancyUpdate():Boolean {
			return pregnancy.updatePregnancy(); //Returns true if we need to make sure pregnancy texts aren't hidden
		}

		// Inventory
		public var itemSlot1:ItemSlotClass;
		public var itemSlot2:ItemSlotClass;
		public var itemSlot3:ItemSlotClass;
		public var itemSlot4:ItemSlotClass;
		public var itemSlot5:ItemSlotClass;
		public var itemSlot6:ItemSlotClass;
		public var itemSlot7:ItemSlotClass;
		public var itemSlot8:ItemSlotClass;
		public var itemSlot9:ItemSlotClass;
		public var itemSlot10:ItemSlotClass;
		public var itemSlots:Array;
		
		public var prisonItemSlots:Array = [];
		public var previouslyWornClothes:Array = []; //For tracking achievement.
		
		private var _weapon:Weapon = WeaponLib.FISTS;
		private var _weaponRange:WeaponRange = WeaponRangeLib.NOTHING;
		private var _armor:Armor = ArmorLib.COMFORTABLE_UNDERCLOTHES;
		private var _jewelry:Jewelry = JewelryLib.NOTHING;
		private var _shield:Shield = ShieldLib.NOTHING;
		private var _upperGarment:Undergarment = UndergarmentLib.NOTHING;
		private var _lowerGarment:Undergarment = UndergarmentLib.NOTHING;
		private var _modArmorName:String = "";

		//override public function set armors
		override public function set armorValue(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.armorValue.");
		}

		override public function set armorName(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.armorName.");
		}

		override public function set armorDef(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.armorDef.");
		}

		override public function set armorPerk(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.armorPerk.");
		}

		//override public function set weapons
		override public function set weaponName(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponName.");
		}

		override public function set weaponVerb(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponVerb.");
		}

		override public function set weaponAttack(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponAttack.");
		}

		override public function set weaponPerk(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponPerk.");
		}

		override public function set weaponValue(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponValue.");
		}

		//override public function set weapons
		override public function set weaponRangeName(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponRangeName.");
		}

		override public function set weaponRangeVerb(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponRangeVerb.");
		}

		override public function set weaponRangeAttack(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponRangeAttack.");
		}

		override public function set weaponRangePerk(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponRangePerk.");
		}

		override public function set weaponRangeValue(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponRangeValue.");
		}

		//override public function set jewelries
		override public function set jewelryName(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.jewelryName.");
		}
		
		override public function set jewelryEffectId(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.jewelryEffectId.");
		}
		
		override public function set jewelryEffectMagnitude(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.jewelryEffectMagnitude.");
		}
				
		override public function set jewelryPerk(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.jewelryPerk.");
		}
		
		override public function set jewelryValue(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.jewelryValue.");
		}

		//override public function set shields
		override public function set shieldName(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.shieldName.");
		}
		
		override public function set shieldBlock(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.shieldBlock.");
		}
		
		override public function set shieldPerk(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.shieldPerk.");
		}
		
		override public function set shieldValue(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.shieldValue.");
		}
		
		//override public function set undergarments
		override public function set upperGarmentName(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.upperGarmentName.");
		}
		
		override public function set upperGarmentPerk(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.upperGarmentPerk.");
		}
		
		override public function set upperGarmentValue(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.upperGarmentValue.");
		}

		override public function set lowerGarmentName(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.lowerGarmentName.");
		}
		
		override public function set lowerGarmentPerk(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.lowerGarmentPerk.");
		}
		
		override public function set lowerGarmentValue(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.lowerGarmentValue.");
		}
		
		
		public function get modArmorName():String
		{
			if (_modArmorName == null) _modArmorName = "";
			return _modArmorName;
		}

		public function set modArmorName(value:String):void
		{
			if (value == null) value = "";
			_modArmorName = value;
		}
		public function isWearingArmor():Boolean {
			return armor != ArmorLib.COMFORTABLE_UNDERCLOTHES && armor != ArmorLib.NOTHING;
		}
		//override public function get armors
		override public function get armorName():String {
			if (_modArmorName.length > 0) return modArmorName;
			else if (_armor.name == "nothing" && lowerGarmentName != "nothing") return lowerGarmentName;
			else if (_armor.name == "nothing" && lowerGarmentName == "nothing") return "gear";
			return _armor.name;
		}
		override public function get armorDef():Number {
			var newGamePlusMod:int = this.newGamePlusMod()+1;
			var armorDef:Number = _armor.def;
			armorDef += upperGarment.armorDef;
			armorDef += lowerGarment.armorDef;
			//Blacksmith history!
			if (armorDef > 0 && (findPerk(PerkLib.HistorySmith) >= 0 || findPerk(PerkLib.PastLifeSmith) >= 0)) {
				armorDef = Math.round(armorDef * 1.1);
				armorDef += 1;
			}
			//Konstantine buff
			if (hasStatusEffect(StatusEffects.KonstantinArmorPolishing)) {
				armorDef = Math.round(armorDef * (1 + (statusEffectv2(StatusEffects.KonstantinArmorPolishing) / 100)));
				armorDef += 1;
			}
			//Skin armor perk
			if (findPerk(PerkLib.ThickSkin) >= 0) {
				armorDef += (2 * newGamePlusMod);
			}
			//Stacks on top of Thick Skin perk.
			var p:Boolean = skin.isCoverLowMid();
			if (skin.hasFur()) armorDef += (p?1:2)*newGamePlusMod;
			if (skin.hasChitin()) armorDef += (p?2:4)*newGamePlusMod;
			if (skin.hasScales()) armorDef += (p?3:6)*newGamePlusMod; //bee-morph (), mantis-morph (), scorpion-morph (wpisane), spider-morph (wpisane)
			if (skin.hasBark() || skin.hasDragonScales()) armorDef += (p?4:8)*newGamePlusMod; //może do 10 podnieść jak doda sie scales dla smoków?
			if (skin.hasBaseOnly(Skin.STONE)) armorDef += (10 * newGamePlusMod);//może do 10 podnieść jak doda sie scales dla smoków?
			//'Thick' dermis descriptor adds 1!
			if (skinAdj == "smooth") armorDef += (1 * newGamePlusMod);
			//Plant score bonuses
			if (plantScore() >= 4) {
				if (plantScore() >= 7) armorDef += (10 * newGamePlusMod);
				else if (plantScore() == 6) armorDef += (8 * newGamePlusMod);
				else if (plantScore() == 5) armorDef += (4 * newGamePlusMod);
				else armorDef += (2 * newGamePlusMod);
			}
			if (yggdrasilScore() >= 10) armorDef += (10 * newGamePlusMod);
			//Dragon score bonuses
			if (dragonScore() >= 10) {
				if (dragonScore() >= 28) armorDef += (10 * newGamePlusMod);
				else if (dragonScore() >= 20) armorDef += (4 * newGamePlusMod);
				else armorDef += (1 * newGamePlusMod);
			}
			//Bonus defense
			if (armType == Arms.YETI) armorDef += (1 * newGamePlusMod);
			if (armType == Arms.SPIDER || armType == Arms.MANTIS || armType == Arms.BEE || armType == Arms.SALAMANDER) armorDef += (2 * newGamePlusMod);
			if (armType == Arms.GARGOYLE) armorDef += (8 * newGamePlusMod);
			if (armType == Arms.GARGOYLE_2) armorDef += (5 * newGamePlusMod);
			if (tailType == Tail.SPIDER_ADBOMEN || tailType == Tail.MANTIS_ABDOMEN || tailType == Tail.BEE_ABDOMEN) armorDef += (2 * newGamePlusMod);
			if (tailType == Tail.GARGOYLE) armorDef += (8 * newGamePlusMod);
			if (tailType == Tail.GARGOYLE_2) armorDef += (5 * newGamePlusMod);
			if (wingType == Wings.GARGOYLE_LIKE_LARGE) armorDef += (8 * newGamePlusMod);
			if (lowerBody == LowerBody.YETI) armorDef += (1 * newGamePlusMod);
			if (lowerBody == LowerBody.CHITINOUS_SPIDER_LEGS || lowerBody == LowerBody.BEE || lowerBody == LowerBody.MANTIS || lowerBody == LowerBody.SALAMANDER) armorDef += (2 * newGamePlusMod);
			if (lowerBody == LowerBody.DRAGON) armorDef += (3 * newGamePlusMod);
			if (lowerBody == LowerBody.DRIDER) armorDef += (4 * newGamePlusMod);
			if (lowerBody == LowerBody.GARGOYLE) armorDef += (8 * newGamePlusMod);
			if (lowerBody == LowerBody.GARGOYLE_2) armorDef += (5 * newGamePlusMod);
			//Soul Cultivators bonuses
			if (findPerk(PerkLib.BodyCultivator) >= 0) {
				armorDef += (1 * newGamePlusMod);
			}
			if (findPerk(PerkLib.FleshBodyApprenticeStage) >= 0) {
				if (findPerk(PerkLib.SoulApprentice) >= 0) armorDef += 2 * newGamePlusMod;
				if (findPerk(PerkLib.SoulPersonage) >= 0) armorDef += 2 * newGamePlusMod;
				if (findPerk(PerkLib.SoulWarrior) >= 0) armorDef += 2 * newGamePlusMod;
			}
			if (findPerk(PerkLib.FleshBodyWarriorStage) >= 0) {
				if (findPerk(PerkLib.SoulSprite) >= 0) armorDef += 3 * newGamePlusMod;
				if (findPerk(PerkLib.SoulScholar) >= 0) armorDef += 3 * newGamePlusMod;
				if (findPerk(PerkLib.SoulElder) >= 0) armorDef += 3 * newGamePlusMod;
			}
			if (findPerk(PerkLib.FleshBodyElderStage) >= 0) {
				if (findPerk(PerkLib.SoulExalt) >= 0) armorDef += 4 * newGamePlusMod;
				if (findPerk(PerkLib.SoulOverlord) >= 0) armorDef += 4 * newGamePlusMod;
				if (findPerk(PerkLib.SoulTyrant) >= 0) armorDef += 4 * newGamePlusMod;
			}
			if (findPerk(PerkLib.FleshBodyOverlordStage) >= 0) {
				if (findPerk(PerkLib.SoulKing) >= 0) armorDef += 5 * newGamePlusMod;
				if (findPerk(PerkLib.SoulEmperor) >= 0) armorDef += 5 * newGamePlusMod;
				if (findPerk(PerkLib.SoulAncestor) >= 0) armorDef += 5 * newGamePlusMod;
			}
			if (findPerk(PerkLib.HclassHeavenTribulationSurvivor) >= 0) armorDef += 6 * newGamePlusMod;
			if (findPerk(PerkLib.GclassHeavenTribulationSurvivor) >= 0) armorDef += 9 * newGamePlusMod;
			//Agility boosts armor ratings!
			var speedBonus:int = 0;
			if (findPerk(PerkLib.Agility) >= 0) {
				if (armorPerk == "Light" || _armor.name == "nothing") {
					speedBonus += Math.round(spe / 10);
				}
				else if (armorPerk == "Medium") {
					speedBonus += Math.round(spe / 25);
				}
			}
			if (findPerk(PerkLib.ArmorMaster) >= 0) {
				if (armorPerk == "Heavy") speedBonus += Math.round(spe / 50);
			}
			armorDef += speedBonus;
			if (findPerk(PerkLib.PrestigeJobSentinel) >= 0 && armorPerk == "Heavy") armorDef += _armor.def;
			if (findPerk(PerkLib.ShieldExpertise) >= 0 && shieldName != "nothing") {
				if (shieldBlock >= 4) armorDef += Math.round(shieldBlock);
				else armorDef += 1;
			}
			//Acupuncture effect
			if (findPerk(PerkLib.ChiReflowDefense) >= 0) armorDef *= UmasShop.NEEDLEWORK_DEFENSE_DEFENSE_MULTI;
			if (findPerk(PerkLib.ChiReflowAttack) >= 0) armorDef *= UmasShop.NEEDLEWORK_ATTACK_DEFENSE_MULTI;
			armorDef = Math.round(armorDef);
			//Berzerking removes armor
			if (hasStatusEffect(StatusEffects.Berzerking) && findPerk(PerkLib.ColdFury) < 1) {
				armorDef = 0;
			}
			if (hasStatusEffect(StatusEffects.ChargeArmor) && (!isNaked() || (isNaked() && haveNaturalArmor() && findPerk(PerkLib.ImprovingNaturesBlueprintsNaturalArmor) >= 0))) armorDef += Math.round(statusEffectv1(StatusEffects.ChargeArmor));
			if (hasStatusEffect(StatusEffects.StoneSkin)) armorDef += Math.round(statusEffectv1(StatusEffects.StoneSkin));
			if (hasStatusEffect(StatusEffects.BarkSkin)) armorDef += Math.round(statusEffectv1(StatusEffects.BarkSkin));
			if (hasStatusEffect(StatusEffects.MetalSkin)) armorDef += Math.round(statusEffectv1(StatusEffects.MetalSkin));
			if (CoC.instance.monster.hasStatusEffect(StatusEffects.TailWhip)) {
				armorDef -= CoC.instance.monster.statusEffectv1(StatusEffects.TailWhip);
				if(armorDef < 0) armorDef = 0;
			}
			if (hasStatusEffect(StatusEffects.Lustzerking)) {
				armorDef = Math.round(armorDef * 1.1);
				armorDef += 1;
			}
			if (hasStatusEffect(StatusEffects.CrinosShape) && findPerk(PerkLib.ImprovingNaturesBlueprintsNaturalArmor) >= 0) {
				armorDef = Math.round(armorDef * 1.1);
				armorDef += 1;
			}
			armorDef = Math.round(armorDef);
			return armorDef;
		}
		public function get armorBaseDef():Number {
			return _armor.def;
		}
		override public function get armorPerk():String {
			return _armor.perk;
		}
		override public function get armorValue():Number {
			return _armor.value;
		}
		//override public function get weapons
		override public function get weaponName():String {
			return _weapon.name;
		}
		override public function get weaponVerb():String {
			return _weapon.verb;
		}
		override public function get weaponAttack():Number {
			var newGamePlusMod:int = this.newGamePlusMod()+1;
			var attack:Number = _weapon.attack;
			if (findPerk(PerkLib.JobBarbarian) >= 0 && weaponPerk == "Large") {
				if (findPerk(PerkLib.WeaponMastery) >= 0 && str >= 100) {
					if (findPerk(PerkLib.WeaponGrandMastery) >= 0 && str >= 140) attack *= 2;
					else attack *= 1.5;
				}
				else attack *= 1.25;
			}
			if (findPerk(PerkLib.WeaponGrandMastery) >= 0 && weaponPerk == "Dual Large" && str >= 140) {
				attack *= 2;
			}
			if (findPerk(PerkLib.HiddenMomentum) >= 0 && weaponPerk == "Large" && str >= 75 && spe >= 50) {
				attack += (((str + spe) - 100) * 0.1);
			}//30-70-110
			if (findPerk(PerkLib.HiddenDualMomentum) >= 0 && weaponPerk == "Dual Large" && str >= 150 && spe >= 100) {
				attack += (((str + spe) - 200) * 0.1);
			}//20-60-100
			if (findPerk(PerkLib.LightningStrikes) >= 0 && spe >= 60 && (weaponPerk != "Large" || weaponPerk != "Dual Large" || !isFistOrFistWeapon())) {
				attack += ((spe - 50) * 0.3);//wyjątek potem dodać dla daggers i innych assasins weapons i dać im lepszy przelicznik
			}//45-105-165
			if (findPerk(PerkLib.SteelImpact) >= 0) {
				attack += ((tou - 50) * 0.3);
			}
			if (isFistOrFistWeapon()) {
				if (findPerk(PerkLib.IronFistsI) >= 0 && str >= 50) {
					attack += 10;
				}
				if (findPerk(PerkLib.IronFistsII) >= 0 && str >= 65) {
					attack += 10;
				}
				if (findPerk(PerkLib.IronFistsIII) >= 0 && str >= 80) {
					attack += 10;
				}
				if (findPerk(PerkLib.IronFistsIV) >= 0 && str >= 95) {
					attack += 10;
				}
				if (findPerk(PerkLib.IronFistsV) >= 0 && str >= 110) {
					attack += 10;
				}
				if (findPerk(PerkLib.IronFistsVI) >= 0 && str >= 125) {
					attack += 10;
				}
				if (findPerk(PerkLib.JobBrawler) >= 0 && str >= 60) {
					attack += (5 * newGamePlusMod);
				}		// && (weaponName == "hooked gauntlets" || weaponName == "spiked gauntlet")
				if (findPerk(PerkLib.MightyFist) >= 0) {
					attack += (5 * newGamePlusMod);
				}
				if (SceneLib.combat.unarmedAttack() > 0) {
					attack += SceneLib.combat.unarmedAttack();
				}
			}
			if (armType == Arms.MANTIS && weaponName == "fists") {
				attack += (15 * newGamePlusMod);
			}
			if ((armType == Arms.YETI || armType == Arms.CAT) && weaponName == "fists") {
				attack += (5 * newGamePlusMod);
			}
			//Konstantine buff
			if (hasStatusEffect(StatusEffects.KonstantinWeaponSharpening) && weaponName != "fists") {
				attack *= 1 + (statusEffectv2(StatusEffects.KonstantinWeaponSharpening) / 100);
			}
			if (hasStatusEffect(StatusEffects.Berzerking)) attack += (15 + (15 * newGamePlusMod));
			if (hasStatusEffect(StatusEffects.Lustzerking)) attack += (15 + (15 * newGamePlusMod));
			if (hasStatusEffect(StatusEffects.ChargeWeapon)) {
				if (((weaponName == "fists" && findPerk(PerkLib.ImprovingNaturesBlueprintsNaturalWeapons) >= 0) || weaponName != "fists") && weaponPerk != "Large" && weaponPerk != "Dual Large") attack += Math.round(statusEffectv1(StatusEffects.ChargeWeapon));
				if (weaponPerk == "Large" || weaponPerk == "Dual Large") attack += Math.round(statusEffectv1(StatusEffects.ChargeWeapon));
			}
			attack = Math.round(attack);
			return attack;
		}
		public function get weaponBaseAttack():Number {
			return _weapon.attack;
		}
		override public function get weaponPerk():String {
			return _weapon.perk || "";
		}
		override public function get weaponValue():Number {
			return _weapon.value;
		}
		//override public function get weapons
		override public function get weaponRangeName():String {
			return _weaponRange.name;
		}
		override public function get weaponRangeVerb():String {
			return _weaponRange.verb;
		}
		override public function get weaponRangeAttack():Number {
			var newGamePlusMod:int = this.newGamePlusMod()+1;
			var rangeattack:Number = _weaponRange.attack;
			if (findPerk(PerkLib.Sharpshooter) >= 0 && weaponRangePerk != "Bow") {
				if (inte < 201) rangeattack *= (1 + (inte / 200));
				else rangeattack *= 2;
			}
		/*	if(findPerk(PerkLib.LightningStrikes) >= 0 && spe >= 60 && weaponRangePerk != "Large") {
				rangeattack += Math.round((spe - 50) / 3);
			}
			if(findPerk(PerkLib.IronFistsI) >= 0 && str >= 50 && weaponRangeName == "fists") {
				rangeattack += 10;
			}
			if(findPerk(PerkLib.IronFistsII) >= 0 && str >= 65 && weaponRangeName == "fists") {
				rangeattack += 10;
			}
			if(findPerk(PerkLib.IronFistsIII) >= 0 && str >= 80 && weaponRangeName == "fists") {
				rangeattack += 10;
			}
			if(findPerk(PerkLib.IronFistsIV) >= 0 && str >= 95 && weaponRangeName == "fists") {
				rangeattack += 10;
			}
			if(findPerk(PerkLib.IronFistsV) >= 0 && str >= 110 && weaponRangeName == "fists") {
				rangeattack += 10;
			}
			if(findPerk(PerkLib.JobBrawler) >= 0 && str >= 60 && weaponRangeName == "fists") {
				rangeattack += (5 * newGamePlusMod);
			}
			if(armType == MANTIS && weaponRangeName == "fists") {
				rangeattack += (15 * newGamePlusMod);
			}
			if(hasStatusEffect(StatusEffects.Berzerking)) rangeattack += (30 + (15 * newGamePlusMod));
			if(hasStatusEffect(StatusEffects.Lustzerking)) rangeattack += (30 + (15 * newGamePlusMod));
			if(findPerk(PerkLib.) >= 0) rangeattack += Math.round(statusEffectv1(StatusEffects.ChargeWeapon));
		*/	rangeattack = Math.round(rangeattack);
			return rangeattack;
		}
		public function get weaponRangeBaseAttack():Number {
			return _weaponRange.attack;
		}
		override public function get weaponRangePerk():String {
			return _weaponRange.perk || "";
		}
		override public function get weaponRangeValue():Number {
			return _weaponRange.value;
		}
		public function get ammo():int {
			return flags[kFLAGS.FLINTLOCK_PISTOL_AMMO];
		}
		public function set ammo(value:int):void {
			flags[kFLAGS.FLINTLOCK_PISTOL_AMMO] = value;
		}
		
		//override public function get jewelries.
		override public function get jewelryName():String {
			return _jewelry.name;
		}
		override public function get jewelryEffectId():Number {
			return _jewelry.effectId;
		}
		override public function get jewelryEffectMagnitude():Number {
			return _jewelry.effectMagnitude;
		}
		override public function get jewelryPerk():String {
			return _jewelry.perk;
		}
		override public function get jewelryValue():Number {
			return _jewelry.value;
		}
		
		//override public function get shields
		override public function get shieldName():String {
			return _shield.name;
		}
		override public function get shieldBlock():Number {
			var block:Number = _shield.block;
			if (findPerk(PerkLib.JobKnight) >= 0) block += 3;
			//miejce na sposoby boostowania block value like perks or status effects
			block = Math.round(block);
			return block;
		}
		override public function get shieldPerk():String {
			return _shield.perk;
		}
		override public function get shieldValue():Number {
			return _shield.value;
		}
		public function get shield():Shield
		{
			return _shield;
		}

		//override public function get undergarment
		override public function get upperGarmentName():String {
			return _upperGarment.name;
		}
		override public function get upperGarmentPerk():String {
			return _upperGarment.perk;
		}
		override public function get upperGarmentValue():Number {
			return _upperGarment.value;
		}
		public function get upperGarment():Undergarment
		{
			return _upperGarment;
		}
		
		override public function get lowerGarmentName():String {
			return _lowerGarment.name;
		}
		override public function get lowerGarmentPerk():String {
			return _lowerGarment.perk;
		}
		override public function get lowerGarmentValue():Number {
			return _lowerGarment.value;
		}
		public function get lowerGarment():Undergarment
		{
			return _lowerGarment;
		}
		
		public function get armor():Armor
		{
			return _armor;
		}
		
		public function setArmor(newArmor:Armor):Armor {
			//Returns the old armor, allowing the caller to discard it, store it or try to place it in the player's inventory
			//Can return null, in which case caller should discard.
			var oldArmor:Armor = _armor.playerRemove(); //The armor is responsible for removing any bonuses, perks, etc.
			if (newArmor == null) {
				CoC_Settings.error(short + ".armor is set to null");
				newArmor = ArmorLib.COMFORTABLE_UNDERCLOTHES;
			}
			_armor = newArmor.playerEquip(); //The armor can also choose to equip something else - useful for Ceraph's trap armor
			return oldArmor;
		}
		
		/*
		public function set armor(value:Armor):void
		{
			if (value == null){
				CoC_Settings.error(short+".armor is set to null");
				value = ArmorLib.COMFORTABLE_UNDERCLOTHES;
			}
			value.equip(this, false, false);
		}
		*/

		// in case you don't want to call the value.equip
		public function setArmorHiddenField(value:Armor):void
		{
			this._armor = value;
		}

		public function get weapon():Weapon
		{
			return _weapon;
		}
		
		public function get weaponRange():WeaponRange
		{
			return _weaponRange;
		}

		public function setWeapon(newWeapon:Weapon):Weapon {
			//Returns the old weapon, allowing the caller to discard it, store it or try to place it in the player's inventory
			//Can return null, in which case caller should discard.
			var oldWeapon:Weapon = _weapon.playerRemove(); //The weapon is responsible for removing any bonuses, perks, etc.
			if (newWeapon == null) {
				CoC_Settings.error(short + ".weapon (melee) is set to null");
				newWeapon = WeaponLib.FISTS;
			}
			_weapon = newWeapon.playerEquip(); //The weapon can also choose to equip something else
			return oldWeapon;
		}
		
		/*
		public function set weapon(value:Weapon):void
		{
			if (value == null){
				CoC_Settings.error(short+".weapon is set to null");
				value = WeaponLib.FISTS;
			}
			value.equip(this, false, false);
		}
		*/

		// in case you don't want to call the value.equip
		public function setWeaponHiddenField(value:Weapon):void
		{
			this._weapon = value;
		}
		
		public function setWeaponRange(newWeaponRange:WeaponRange):WeaponRange {
			//Returns the old shield, allowing the caller to discard it, store it or try to place it in the player's inventory
			//Can return null, in which case caller should discard.
			var oldWeaponRange:WeaponRange = _weaponRange.playerRemove();
			if (newWeaponRange == null) {
				CoC_Settings.error(short + ".weapon (range) is set to null");
				newWeaponRange = WeaponRangeLib.NOTHING;
			}
			_weaponRange = newWeaponRange.playerEquip();
			return oldWeaponRange;
		}
		
		// in case you don't want to call the value.equip
		public function setWeaponRangeHiddenField(value:WeaponRange):void
		{
			this._weaponRange = value;
		}
		
		//Jewelry, added by Kitteh6660
		public function get jewelry():Jewelry
		{
			return _jewelry;
		}

		public function setJewelry(newJewelry:Jewelry):Jewelry {
			//Returns the old jewelry, allowing the caller to discard it, store it or try to place it in the player's inventory
			//Can return null, in which case caller should discard.
			var oldJewelry:Jewelry = _jewelry.playerRemove(); //The armor is responsible for removing any bonuses, perks, etc.
			if (newJewelry == null) {
				CoC_Settings.error(short + ".jewelry is set to null");
				newJewelry = JewelryLib.NOTHING;
			}
			_jewelry = newJewelry.playerEquip(); //The jewelry can also choose to equip something else - useful for Ceraph's trap armor
			return oldJewelry;
		}
		// in case you don't want to call the value.equip
		public function setJewelryHiddenField(value:Jewelry):void
		{
			this._jewelry = value;
		}
		
		public function setShield(newShield:Shield):Shield {
			//Returns the old shield, allowing the caller to discard it, store it or try to place it in the player's inventory
			//Can return null, in which case caller should discard.
			var oldShield:Shield = _shield.playerRemove(); //The shield is responsible for removing any bonuses, perks, etc.
			if (newShield == null) {
				CoC_Settings.error(short + ".shield is set to null");
				newShield = ShieldLib.NOTHING;
			}
			_shield = newShield.playerEquip(); //The shield can also choose to equip something else.
			return oldShield;
		}
		
		// in case you don't want to call the value.equip
		public function setShieldHiddenField(value:Shield):void
		{
			this._shield = value;
		}

		public function setUndergarment(newUndergarment:Undergarment, typeOverride:int = -1):Undergarment {
			//Returns the old undergarment, allowing the caller to discard it, store it or try to place it in the player's inventory
			//Can return null, in which case caller should discard.
			var oldUndergarment:Undergarment = UndergarmentLib.NOTHING;
			if (newUndergarment.type == UndergarmentLib.TYPE_UPPERWEAR || typeOverride == 0) { 
				oldUndergarment = _upperGarment.playerRemove(); //The undergarment is responsible for removing any bonuses, perks, etc.
				if (newUndergarment == null) {
					CoC_Settings.error(short + ".upperGarment is set to null");
					newUndergarment = UndergarmentLib.NOTHING;
				}
				_upperGarment = newUndergarment.playerEquip(); //The undergarment can also choose to equip something else.
			}
			else if (newUndergarment.type == UndergarmentLib.TYPE_LOWERWEAR || typeOverride == 1) { 
				oldUndergarment = _lowerGarment.playerRemove(); //The undergarment is responsible for removing any bonuses, perks, etc.
				if (newUndergarment == null) {
					CoC_Settings.error(short + ".lowerGarment is set to null");
					newUndergarment = UndergarmentLib.NOTHING;
				}
				_lowerGarment = newUndergarment.playerEquip(); //The undergarment can also choose to equip something else.
			}
			return oldUndergarment;
		}
		
		// in case you don't want to call the value.equip
		public function setUndergarmentHiddenField(value:Undergarment, type:int):void
		{
			if (type == UndergarmentLib.TYPE_UPPERWEAR) this._upperGarment = value;
			else this._lowerGarment = value;
		}
		
		public function reduceDamage(damage:Number):Number {
			var damageMultiplier:Number = 1;
			//EZ MOAD half damage
			if (flags[kFLAGS.EASY_MODE_ENABLE_FLAG] == 1) damageMultiplier /= 2;
			//Difficulty modifier flags.
			if (flags[kFLAGS.GAME_DIFFICULTY] == 1) damageMultiplier *= 1.15;
			else if (flags[kFLAGS.GAME_DIFFICULTY] == 2) damageMultiplier *= 1.3;
			else if (flags[kFLAGS.GAME_DIFFICULTY] == 3) damageMultiplier *= 1.5;
			else if (flags[kFLAGS.GAME_DIFFICULTY] >= 4) damageMultiplier *= 2;
			
			//Opponents can critical too!
			var crit:Boolean = false;
			var critChanceMonster:int = 5;
			if (CoC.instance.monster.findPerk(PerkLib.Tactician) >= 0 && CoC.instance.monster.inte >= 50) {
				if (CoC.instance.monster.inte <= 100) critChanceMonster += (CoC.instance.monster.inte - 50) / 5;
				if (CoC.instance.monster.inte > 100) critChanceMonster += 10;
			}
			if (CoC.instance.monster.findPerk(PerkLib.VitalShot) >= 0 && CoC.instance.monster.inte >= 50) critChanceMonster += 10;
			if (rand(100) < critChanceMonster) {
				crit = true;
				damage *= 1.75;
				flags[kFLAGS.ENEMY_CRITICAL] = 1;
			}
			if (hasStatusEffect(StatusEffects.Shielding)) {
				damage -= 30;
				if (damage < 1) damage = 1;
			}
			//Apply damage resistance percentage.
			damage *= damagePercent() / 100;
			if (damageMultiplier < 0.2) damageMultiplier = 0;
			return int(damage * damageMultiplier);
		}
		public function reduceMagicDamage(damage:Number):Number {
			var magicdamageMultiplier:Number = 1;
			//EZ MOAD half damage
			if (flags[kFLAGS.EASY_MODE_ENABLE_FLAG] == 1) magicdamageMultiplier /= 2;
			//Difficulty modifier flags.
			if (flags[kFLAGS.GAME_DIFFICULTY] == 1) magicdamageMultiplier *= 1.15;
			else if (flags[kFLAGS.GAME_DIFFICULTY] == 2) magicdamageMultiplier *= 1.3;
			else if (flags[kFLAGS.GAME_DIFFICULTY] == 3) magicdamageMultiplier *= 1.5;
			else if (flags[kFLAGS.GAME_DIFFICULTY] >= 4) magicdamageMultiplier *= 2;

			//Opponents can critical too!
			var crit:Boolean = false;
			var critChanceMonster:int = 5;
			/*if (CoC.instance.monster.findPerk(PerkLib.Tactician) >= 0 && CoC.instance.monster.inte >= 50) {
				if (CoC.instance.monster.inte <= 100) critChanceMonster += (CoC.instance.monster.inte - 50) / 5;
				if (CoC.instance.monster.inte > 100) critChanceMonster += 10;
			}
			if (CoC.instance.monster.findPerk(PerkLib.VitalShot) >= 0 && CoC.instance.monster.inte >= 50) critChanceMonster += 10;
			*/if (rand(100) < critChanceMonster) {
				crit = true;
				damage *= 1.75;
				flags[kFLAGS.ENEMY_CRITICAL] = 1;
			}
			if (hasStatusEffect(StatusEffects.Shielding)) {
				damage -= 30;
				if (damage < 1) damage = 1;
			}
			//Apply magic damage resistance percentage.
			damage *= damageMagicalPercent() / 100;
			if (magicdamageMultiplier < 0.2) magicdamageMultiplier = 0;
			return int(damage * magicdamageMultiplier);
		}

		public override function lustPercent():Number {
			var lust:Number = 100;
			var minLustCap:Number = 25;
			
			//++++++++++++++++++++++++++++++++++++++++++++++++++
			//ADDITIVE REDUCTIONS
			//THESE ARE FLAT BONUSES WITH LITTLE TO NO DOWNSIDE
			//TOTAL IS LIMITED TO 75%!
			//++++++++++++++++++++++++++++++++++++++++++++++++++
			//Corrupted Libido reduces lust gain by 10%!
			if(findPerk(PerkLib.CorruptedLibido) >= 0) lust -= 10;
			//Acclimation reduces by 15%
			if(findPerk(PerkLib.Acclimation) >= 0) lust -= 15;
			//Purity blessing reduces lust gain
			if(findPerk(PerkLib.PurityBlessing) >= 0) lust -= 5;
			//Resistance = 10%
			if(findPerk(PerkLib.ResistanceI) >= 0) lust -= 5;
			if(findPerk(PerkLib.ResistanceII) >= 0) lust -= 5;
			if(findPerk(PerkLib.ResistanceIII) >= 0) lust -= 5;
			if(findPerk(PerkLib.ResistanceIV) >= 0) lust -= 5;
			if(findPerk(PerkLib.ResistanceV) >= 0) lust -= 5;
			if(findPerk(PerkLib.ResistanceVI) >= 0) lust -= 5;
			if(findPerk(PerkLib.ChiReflowLust) >= 0) lust -= UmasShop.NEEDLEWORK_LUST_LUST_RESIST;
			if(lust < minLustCap) lust = minLustCap;
			if(statusEffectv1(StatusEffects.BlackCatBeer) > 0) {
				if(lust >= 80) lust = 100;
				else lust += 20;
			}
			lust += Math.round(perkv1(PerkLib.PentUp)/2);
			//++++++++++++++++++++++++++++++++++++++++++++++++++
			//MULTIPLICATIVE REDUCTIONS
			//THESE PERKS ALSO RAISE MINIMUM LUST OR HAVE OTHER
			//DRAWBACKS TO JUSTIFY IT.
			//++++++++++++++++++++++++++++++++++++++++++++++++++
			//Bimbo body slows lust gains!
			if((hasStatusEffect(StatusEffects.BimboChampagne) || findPerk(PerkLib.BimboBody) >= 0) && lust > 0) lust *= .75;
			if(findPerk(PerkLib.BroBody) >= 0 && lust > 0) lust *= .75;
			if(findPerk(PerkLib.FutaForm) >= 0 && lust > 0) lust *= .75;
			//Omnibus' Gift reduces lust gain by 15%
			if(findPerk(PerkLib.OmnibusGift) >= 0) lust *= .85;
			//Fera Blessing reduces lust gain by 15%
			if(hasStatusEffect(StatusEffects.BlessingOfDivineFera)) lust *= .85;
			//Luststick reduces lust gain by 10% to match increased min lust
			if(findPerk(PerkLib.LuststickAdapted) >= 0) lust *= 0.9;
			if(hasStatusEffect(StatusEffects.Berzerking)) lust *= .6;
			if (findPerk(PerkLib.PureAndLoving) >= 0) lust *= 0.95;
			//Berseking reduces lust gains by 10%
			if (hasStatusEffect(StatusEffects.Berzerking)) lust *= 0.9;
			if (hasStatusEffect(StatusEffects.Overlimit)) lust *= 0.9;

			//Items
			if (jewelryEffectId == JewelryLib.PURITY) lust *= 1 - (jewelryEffectMagnitude / 100);
			if (armor == game.armors.DBARMOR) lust *= 0.9;
			if (weapon == game.weapons.HNTCANE) lust *= 0.75;
			if ((weapon == game.weapons.PURITAS) || (weapon == game.weapons.ASCENSU)) lust *= 0.9;
			// Lust mods from Uma's content -- Given the short duration and the gem cost, I think them being multiplicative is justified.
			// Changing them to an additive bonus should be pretty simple (check the static values in UmasShop.as)
			var sac:StatusEffectClass = statusEffectByType(StatusEffects.UmasMassage);
			if (sac)
			{
				if (sac.value1 == UmasShop.MASSAGE_RELIEF || sac.value1 == UmasShop.MASSAGE_LUST)
				{
					lust *= sac.value2;
				}
			}
			if(statusEffectv1(StatusEffects.Maleficium) > 0) {
				if(lust >= 50) lust = 100;
				else lust += 50;
			}
			lust = Math.round(lust);
			if (hasStatusEffect(StatusEffects.Lustzerking) && findPerk(PerkLib.ColdLust) < 1) lust = 100;
			return lust;
		}

		public override function takePhysDamage(damage:Number, display:Boolean = false):Number{
			//Round
			damage = Math.round(damage);
			// we return "1 damage received" if it is in (0..1) but deduce no HP
			var returnDamage:int = (damage>0 && damage<1)?1:damage;
			if (damage>0){
				if (hasStatusEffect(StatusEffects.ManaShield) && damage < mana) {
					mana -= damage;
					if (display) {
						if (damage > 0) outputText("<b>(<font color=\"#800000\">Absorbed " + damage + "</font>)</b>");
						else outputText("<b>(<font color=\"#000080\">Absorbed " + damage + "</font>)</b>");
					}
					game.mainView.statsView.showStatDown('mana');
					dynStats("lus", 0); //Force display arrow.
				}
				else {
					damage = reduceDamage(damage);
					//Wrath
					var gainedWrath:Number = 0;
					gainedWrath += damage / 10;
					gainedWrath = Math.round(gainedWrath);
					wrath += gainedWrath;
					if (wrath > maxWrath()) wrath = maxWrath();
					//game.HPChange(-damage, display);
					HP -= damage;
					if (display) {
						if (damage > 0) outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b>");
						else outputText("<b>(<font color=\"#000080\">" + damage + "</font>)</b>");
					}
					game.mainView.statsView.showStatDown('hp');
					dynStats("lus", 0); //Force display arrow.
				}
				if (flags[kFLAGS.MINOTAUR_CUM_REALLY_ADDICTED_STATE] > 0) {
					dynStats("lus", int(damage / 2));
				}
				//Prevent negatives
				if (HP<=0){
					HP = 0;
					//This call did nothing. There is no event 5010: if (game.inCombat) game.doNext(5010);
				}
			}
			return returnDamage;
		}
		public override function takeMagicDamage(damage:Number, display:Boolean = false):Number{
			//Round
			damage = Math.round(damage);
			// we return "1 damage received" if it is in (0..1) but deduce no HP
			var returnDamage:int = (damage>0 && damage<1)?1:damage;
			if (damage>0){
				if (hasStatusEffect(StatusEffects.ManaShield) && (damage / 2) < mana) {
					mana -= damage / 2;
					if (display) {
						if (damage > 0) outputText("<b>(<font color=\"#800000\">Absorbed " + damage + "</font>)</b>");
						else outputText("<b>(<font color=\"#000080\">Absorbed " + damage + "</font>)</b>");
					}
					game.mainView.statsView.showStatDown('mana');
					dynStats("lus", 0); //Force display arrow.
				}
				else {
					damage = reduceMagicDamage(damage);
					//Wrath
					var gainedWrath:Number = 0;
					gainedWrath += damage / 10;
					gainedWrath = Math.round(gainedWrath);
					wrath += gainedWrath;
					if (wrath > maxWrath()) wrath = maxWrath();
					//game.HPChange(-damage, display);
					HP -= damage;
					if (display) {
						if (damage > 0) outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b>");
						else outputText("<b>(<font color=\"#000080\">" + damage + "</font>)</b>");
					}
					game.mainView.statsView.showStatDown('hp');
					dynStats("lus", 0); //Force display arrow.
				}
				if (flags[kFLAGS.MINOTAUR_CUM_REALLY_ADDICTED_STATE] > 0) {
					dynStats("lus", int(damage / 2));
				}
				//Prevent negatives
				if (HP<=0){
					HP = 0;
					//This call did nothing. There is no event 5010: if (game.inCombat) game.doNext(5010);
				}
			}
			return returnDamage;
		}

		/**
		 * @return 0: did not avoid; 1-3: avoid with varying difference between
		 * speeds (1: narrowly avoid, 3: deftly avoid)
		 */
		public function speedDodge(monster:Monster):int{
			var diff:Number = spe - monster.spe;
			var rnd:int = int(Math.random() * ((diff / 4) + 80));
			if (rnd<=80) return 0;
			else if (diff<8) return 1;
			else if (diff<20) return 2;
			else return 3;
		}

		//Body Type
		public function bodyType():String
		{
			var desc:String = "";
			//OLD STUFF
			//SUPAH THIN
			if (thickness < 10)
			{
				//SUPAH BUFF
				if (tone > 90)
					desc += "a lithe body covered in highly visible muscles";
				else if (tone > 75)
					desc += "an incredibly thin, well-muscled frame";
				else if (tone > 50)
					desc += "a very thin body that has a good bit of muscle definition";
				else if (tone > 25)
					desc += "a lithe body and only a little bit of muscle definition";
				else
					desc += "a waif-thin body, and soft, forgiving flesh";
			}
			//Pretty thin
			else if (thickness < 25)
			{
				if (tone > 90)
					desc += "a thin body and incredible muscle definition";
				else if (tone > 75)
					desc += "a narrow frame that shows off your muscles";
				else if (tone > 50)
					desc += "a somewhat lithe body and a fair amount of definition";
				else if (tone > 25)
					desc += "a narrow, soft body that still manages to show off a few muscles";
				else
					desc += "a thin, soft body";
			}
			//Somewhat thin
			else if (thickness < 40)
			{
				if (tone > 90)
					desc += "a fit, somewhat thin body and rippling muscles all over";
				else if (tone > 75)
					desc += "a thinner-than-average frame and great muscle definition";
				else if (tone > 50)
					desc += "a somewhat narrow body and a decent amount of visible muscle";
				else if (tone > 25)
					desc += "a moderately thin body, soft curves, and only a little bit of muscle";
				else
					desc += "a fairly thin form and soft, cuddle-able flesh";
			}
			//average
			else if (thickness < 60)
			{
				if (tone > 90)
					desc += "average thickness and a bevy of perfectly defined muscles";
				else if (tone > 75)
					desc += "an average-sized frame and great musculature";
				else if (tone > 50)
					desc += "a normal waistline and decently visible muscles";
				else if (tone > 25)
					desc += "an average body and soft, unremarkable flesh";
				else
					desc += "an average frame and soft, untoned flesh with a tendency for jiggle";
			}
			else if (thickness < 75)
			{
				if (tone > 90)
					desc += "a somewhat thick body that's covered in slabs of muscle";
				else if (tone > 75)
					desc += "a body that's a little bit wide and has some highly-visible muscles";
				else if (tone > 50)
					desc += "a solid build that displays a decent amount of muscle";
				else if (tone > 25)
					desc += "a slightly wide frame that displays your curves and has hints of muscle underneath";
				else
					desc += "a soft, plush body with plenty of jiggle";
			}
			else if (thickness < 90)
			{
				if (tone > 90)
					desc += "a thickset frame that gives you the appearance of a wall of muscle";
				else if (tone > 75)
					desc += "a burly form and plenty of muscle definition";
				else if (tone > 50)
					desc += "a solid, thick frame and a decent amount of muscles";
				else if (tone > 25)
					desc += "a wide-set body, some soft, forgiving flesh, and a hint of muscle underneath it";
				else
				{
					desc += "a wide, cushiony body";
					if (gender >= 2 || biggestTitSize() > 3 || hipRating > 7 || buttRating > 7)
						desc += " and plenty of jiggle on your curves";
				}
			}
			//Chunky monkey
			else
			{
				if (tone > 90)
					desc += "an extremely thickset frame and so much muscle others would find you harder to move than a huge boulder";
				else if (tone > 75)
					desc += "a very wide body and enough muscle to make you look like a tank";
				else if (tone > 50)
					desc += "an extremely substantial frame packing a decent amount of muscle";
				else if (tone > 25)
				{
					desc += "a very wide body";
					if (gender >= 2 || biggestTitSize() > 4 || hipRating > 10 || buttRating > 10)
						desc += ", lots of curvy jiggles,";
					desc += " and hints of muscle underneath";
				}
				else
				{
					desc += "a thick";
					if (gender >= 2 || biggestTitSize() > 4 || hipRating > 10 || buttRating > 10)
						desc += ", voluptuous";
					desc += " body and plush, ";
					if (gender >= 2 || biggestTitSize() > 4 || hipRating > 10 || buttRating > 10)
						desc += " jiggly curves";
					else
						desc += " soft flesh";
				}
			}
			return desc;
		}

		public function race():String
		{
			//Determine race type:
			var race:String = "human";
			if (catScore() >= 4) 
			{
				if (catScore() >= 8) {
					if (isTaur() && lowerBody == LowerBody.CAT) {
						race = "cat-taur";
						if (faceType == Face.HUMAN)
							race = "sphinx-morph"; // no way to be fully feral anyway
					}
					else {
						race = "cat-morph";
						if (faceType == Face.HUMAN)
							race = "cat-" + mf("boy", "girl");
					}
				}
				else {
					if (isTaur() && lowerBody == LowerBody.CAT) {
						race = "half cat-taur";
						if (faceType == Face.HUMAN)
							race = "half sphinx-morph"; // no way to be fully feral anyway
					}
					else {
						race = " half cat-morph";
						if (faceType == Face.HUMAN)
							race = "half cat-" + mf("boy", "girl");
					}
				}
			}
			if (nekomataScore() >= 11)
			{
				race = "Nekomanta";
			}
			if (cheshireScore() >= 11)
			{
				race = "Cheshire cat";
			}
			if (lizardScore() >= 4)
			{
				if (lizardScore() >= 8) {
					if (isTaur()) race = "lizan-taur";
					else race = "lizan";
				}
				else {
					if (isTaur()) race = "half lizan-taur";
					else race = "half lizan";
				}
			}
			if (dragonScore() >= 4)
			{
				if (dragonScore() >= 28) {
					if (isTaur()) race = "ancient dragon-taur";
					else {
						race = "ancient dragon";
						if (faceType == Face.HUMAN)
							race = "ancient dragon-" + mf("man", "girl");
					}
				}
				else if (dragonScore() >= 20) {
					if (isTaur()) race = " elder dragon-taur";
					else {
						race = "elder dragon";
						if (faceType == Face.HUMAN)
							race = "elder dragon-" + mf("man", "girl");
					}
				}
				else if (dragonScore() >= 10) {
					if (isTaur()) race = "dragon-taur";
					else {
						race = "dragon";
						if (faceType == Face.HUMAN)
							race = "dragon-" + mf("man", "girl");
					}
				}
				else {
					if (isTaur()) race = "half-dragon-taur";
					else {
						race = "half-dragon";
						if (faceType == Face.HUMAN)
							race = "half-dragon-" + mf("man", "girl");
					}
				}
			}
			if (jabberwockyScore() >= 4)
			{
				if (jabberwockyScore() >= 20) {
					if (isTaur()) race = " greater jabberwocky-taur";
					else race = "greater jabberwocky";
				}
				else if (jabberwockyScore() >= 10) {
					if (isTaur()) race = "jabberwocky-taur";
					else race = "jabberwocky";
				}
				else {
					if (isTaur()) race = "half-jabberwocky-taur";
					else race = "half-jabberwocky";
				}
			}
			if (raccoonScore() >= 4)
			{
				race = "raccoon-morph";
				if (balls > 0 && ballSize > 5)
					race = "tanuki";
			}
			if (dogScore() >= 4)
			{
				if (isTaur() && lowerBody == LowerBody.DOG)
					race = "dog-taur";
				else {
					race = "dog-morph";
					if (faceType == Face.HUMAN)
						race = "dog-" + mf("man", "girl");
				}
			}
			if (wolfScore() >= 4)
			{
				if (isTaur() && lowerBody == LowerBody.WOLF)
					race = "wolf-taur";
				else if (wolfScore() >= 10)
					race = "Fenrir";
				else if (wolfScore() >= 7 && hasFur() && coatColor == "glacial white")
					race = "winter wolf";
				else if (wolfScore() >= 6)
					race = "wolf-morph";
				else
					race = "wolf-" + mf("boy", "girl");
			}
			if (foxScore() >= 4)
			{
				if (foxScore() >= 7 && isTaur() && lowerBody == LowerBody.FOX)
					race = "fox-taur";
				else if (foxScore() >= 7)
					race = "fox-morph";
				else
					race = "half fox";
			}
			if (ferretScore() >= 4)
			{
				if (hasFur())
					race = "ferret-morph";
				else
					race = "ferret-" + mf("morph", "girl");
			}
			if (kitsuneScore() >= 5)
			{
				if (tailType == 13 && tailCount >= 2 && kitsuneScore() >= 6) {
					if (kitsuneScore() >= 12) {
						if (tailCount == 9 && isTaur()) {
							race = "nine tailed kitsune-taur";
						}
						else if (tailCount == 9) {
							race = "nine tailed kitsune";
						}
						else {
							race = "kitsune";
						}
					}
					else {
						if (isTaur()) {
							race = "kitsune-taur";
						}
						else {
							race = "kitsune";
						}
					}
				}
				else {
					race = "half kitsune";
				}
			}
			if (kitshooScore() >= 6)
			{
				if (isTaur()) race = "kitshoo-taur";
				else {
					race = "kitshoo";
				}
			}
			if (horseScore() >= 4)
			{
				if (horseScore() >= 7)
					race = "equine-morph";
				else
					race = "half equine-morph";
			}
			if (unicornScore() >= 9)
			{
				if (isTaur()) race = "unicorn-taur";
				else {
					race = "unicorn";
				}
			}
			if (alicornScore() >= 11)
			{
				if (isTaur()) race = "alicorn-taur";
				else {
					race = "alicorn";
				}
			}
			if (centaurScore() >= 8)
				race = "centaur";
			if (mutantScore() >= 5 && race == "human")
				race = "corrupted mutant";
			if (minotaurScore() >= 4)
				if (minotaurScore() >= 9) race = "minotaur";
				else race = "half-minotaur";
			if (cowScore() >= 4)
			{
				if (cowScore() >= 9) {
					race = "cow-";
					race += mf("morph", "girl");
				}
				else {
					race = "half cow-";
					race += mf("morph", "girl");
				}
			}
			if (beeScore() >= 5) {
				if (beeScore() >= 9) {
					race = "bee-morph";
				}
				else {
					race = "half bee-morph";
				}
			}
			if (goblinScore() >= 4)
				race = "goblin";
			if (humanScore() >= 5 && race == "corrupted mutant")
				race = "somewhat human mutant";
			if (demonScore() >= 5)
			{
				if (demonScore() >= 11) {
					if (isTaur()) {
						race = "";
						race += mf("incubi-kintaur", "succubi-kintaur");
					}
					else {
						race = "";
						race += mf("incubi-kin", "succubi-kin");
					}
				}
				else {
					if (isTaur()) {
						race = "half ";
						race += mf("incubus-taur", "succubus-taur");
					}
					else {
						race = "half ";
						race += mf("incubus", "succubus");
					}
				}
			}
			if (devilkinScore() >= 7)
			{
				if (devilkinScore() >= 10) {
					if (devilkinScore() >= 14)  {
						if (isTaur()) race = "greater devil-taur";
						else race = "greater devil";
					}
					else {
						if (isTaur()) race = "devil-taur";
						else race = "devil";
					}
				}
				else {
					if (isTaur()) race = "half devil-taur";
					else race = "half devil";
				}
			}
			if (sharkScore() >= 4)
			{
				if (sharkScore() >= 9 && vaginas.length > 0 && cocks.length > 0) {
					if (isTaur()) race = "tigershark-taur";
					else {
						race = "tigershark-morph";
					}
				}
				else if (sharkScore() >= 8) {
					if (isTaur()) race = "shark-taur";
					else {
						race = "shark-morph";
					}
				}
				else {
					if (isTaur()) race = "half shark-taur";
					else {
						race = "half shark-morph";
					}
				}
			}
			if (orcaScore() >= 6)
			{
				if (orcaScore() >= 12) {
					if (isTaur()) race = "orca-taur";
					else {
						race = "orca-morph";
					}
				}
				else {
					if (isTaur()) race = "half orca-taur";
					else {
						race = "half orca-";
						race += mf("boy", "girl");
					}
				}
			}
			if (bunnyScore() >= 4)
				race = "bunny-" + mf("boy", "girl");
			if (harpyScore() >= 4)
			{
				if (harpyScore() >= 8) {
					if (gender >= 2) {
						race = "harpy";
					}
					else {
						race = "avian";
					}
				}
				else {
					if (gender >= 2) {
						race = "half harpy";
					}
					else {
						race = "half avian";
					}
				}
			}
			if (spiderScore() >= 4)
			{
				if (spiderScore() >= 7) {
					race = "spider-morph";
					if (mf("no", "yes") == "yes")
						race = "spider-girl";
					if (isDrider())
						race = "drider";
				}
				else {
					race = "half spider-morph";
					if (mf("no", "yes") == "yes")
						race = "half spider-girl";
					if (isDrider())
						race = "half drider";
				}
			}
			if (kangaScore() >= 4)
				race = "kangaroo-morph";
			if (mouseScore() >= 3)
			{
				if (isTaur()) race = "mouse-taur";
				else {
					if (faceType != 16)
					race = "mouse-" + mf("boy", "girl");
					else
						race = "mouse-morph";
				}
			}
			if (scorpionScore() >= 4)
			{
				if (isTaur()) race = "scorpion-taur";
				else {
					race = "scorpion-morph";
				}
			}
			if (mantisScore() >= 6)
			{
				if (mantisScore() >= 12) {
					if (isTaur()) race = "mantis-taur";
					else {
						race = "mantis-morph";
					}
				}
				else {
					if (isTaur()) race = "half mantis-taur";
					else {
						race = "half mantis-morph";
					}
				}
			}
			if (salamanderScore() >= 4)
			{
				if (salamanderScore() >= 7) {
					if (isTaur()) race = "salamander-taur";
					else race = "salamander";
				}
				else {
					if (isTaur()) race = "half salamander-taur";
					else race = "half salamander";
				}
			}
			if (yetiScore() >= 6)
			{
				if (yetiScore() >= 12) {
					if (isTaur()) race = "yeti-taur";
					else race = "yeti";
				}
				else {
					if (isTaur()) race = "half yeti-taur";
					else race = "half yeti";
				}
			}
			if (couatlScore() >= 11)
			{
				if (isTaur()) race = "couatl-taur";
				else {
					race = "couatl";
				}
			}
			if (vouivreScore() >= 11)
			{
				if (isTaur()) race = "vouivre-taur";
				else {
					race = "vouivre";
				}
			}
			if (gorgonScore() >= 11)
			{
				if (isTaur()) race = "gorgon-taur";
				else {
					race = "gorgon";
				}
			}
			if (lowerBody == 3 && nagaScore() >= 4)
			{
				if (nagaScore() >= 8) race = "naga";
				else race = "half-naga";
			}

			if (phoenixScore() >= 10)
			{
				if (isTaur()) race = "phoenix-taur";
				else race = "phoenix";
			}
			if (scyllaScore() >= 4)
			{
				if (scyllaScore() >= 12) race = "kraken";
				else if (scyllaScore() >= 7) race = "scylla";
				else race = "half scylla";
			}
			if (plantScore() >= 4)
			{
				if (isTaur()) {
					if (plantScore() >= 6) race = mf("treant-taur", "dryad-taur");
					else race = "plant-taur";
				}
				else {
					if (plantScore() >= 6) race = mf("treant", "dryad");
					else race = "plant-morph";
				}
			}
			if (alrauneScore() >= 10)
			{
				race = "Alraune";
			}
			if (yggdrasilScore() >= 10)
			{
				race = "Yggdrasil";
			}
			if (oniScore() >= 6)
			{
				if (oniScore() >= 12) {
					if (isTaur()) race = "oni-taur";
					else race = "oni";
				}
				else {
					if (isTaur()) race = "half oni-taur";
					else race = "half oni";
				}
			}
			if (elfScore() >= 5)
			{
				if (elfScore() >= 11) {
					if (isTaur()) race = "elf-taur";
					else race = "elf";
				}
				else {
					if (isTaur()) race = "half elf-taur";
					else race = "half elf";
				}
			}
			if (raijuScore() >= 5)
			{
				if (raijuScore() >= 10) {
					if (isTaur()) race = "raiju-taur";
					else race = "raiju";
				}
				else {
					if (isTaur()) race = "half raiju-taur";
					else race = "half raiju";
				}
			}
			//<mod>
			if (pigScore() >= 4) 
			{
				race = "pig-morph";
				if (faceType == Face.HUMAN)
					race = "pig-" + mf("boy", "girl");
				if (faceType == 20)
					race = "boar-morph";
			}
			if (satyrScore() >= 4)
			{
				race = "satyr";
			}
			if (rhinoScore() >= 4)
			{
				race = "rhino-morph";
				if (faceType == Face.HUMAN) race = "rhino-" + mf("man", "girl");
			}
			if (echidnaScore() >= 4)
			{
				race = "echidna";
				if (faceType == Face.HUMAN) race = "echidna-" + mf("boy", "girl");
			}
			if (deerScore() >= 4)
			{
				if (isTaur()) race = "deer-taur";
				else {
					race = "deer-morph";
					if (faceType == Face.HUMAN) race = "deer-" + mf("morph", "girl");
				}
			}
			//Special, bizarre races
			if (dragonneScore() >= 6)
			{
				if (isTaur()) race = "dragonne-taur";
				else {
					race  = "dragonne";
					if (faceType == Face.HUMAN)
						race = "dragonne-" + mf("man", "girl");
				}
			}
			if (manticoreScore() >= 6)
			{
				if (isTaur() && lowerBody == LowerBody.LION) {
					if (manticoreScore() < 12)
						race = "half manticore-taur";
					if (manticoreScore() >= 12)
						race = "manticore-taur";
				}
				else if (manticoreScore() >= 12)
					race = "manticore";
				else
					race = "half manticore";
			}
			if (redpandaScore() >= 4)
			{
				if (redpandaScore() >= 8) {
					race = "red-panda-morph";
					if (faceType == Face.HUMAN)
						race = "red-panda-" + mf("boy", "girl");
					if (isTaur())
						race = "red-panda-taur";
				}
				else {
					race = "half red-panda-morph";
					if (faceType == Face.HUMAN)
						race = "half red-panda-" + mf("boy", "girl");
					if (isTaur())
						race = "half red-panda-taur";
				}
			}
			if (sirenScore() >= 10)
			{
				if (isTaur()) race = "siren-taur";
				else race = "siren";
			}
			if (gargoyleScore() >= 21)
			{
				if (hasPerk(PerkLib.GargoyleCorrupted)) race = "corrupted gargoyle";
				else race = "gargoyle";
			}
			if (batScore() >= 6){
				race = batScore() >= 10? "bat":"half bat";
				race += mf("boy","girl");
			}
			if (vampireScore() >= 6){
				race = vampireScore() >= 10 ? "vampire" : "dhampir"
			}
			//</mod>
			if (lowerBody == LowerBody.HOOFED && isTaur() && wingType == Wings.FEATHERED_LARGE) {
				race = "pegataur";
			}
			
			if (lowerBody == LowerBody.PONY)
				race = "pony-kin";

			if (gooScore() >= 4)
			{
				if (gooScore() >= 8) {
					race = "goo-";
					race += mf("boi", "girl");
				}
				else {
					race = "half goo-";
					race += mf("boi", "girl");
				}
			}
			
			if (chimeraScore() >= 3)
			{
				race = "chimera";
			}
			
			if (grandchimeraScore() >= 3)
			{
				race = "grand chimera";
			}
			
			return race;
		}

		//Determine Human Rating
		public function humanScore():Number {
			Begin("Player","racialScore","human");
			var humanCounter:Number = 0;
			if (hasPlainSkinOnly() && skinTone != "slippery")
				humanCounter++;
			if (faceType == Face.HUMAN)
				humanCounter++;
			if (eyeType == Eyes.HUMAN)
				humanCounter++;
			if (earType == Ears.HUMAN)
				humanCounter++;
			if (earType == Ears.ELVEN)
				humanCounter -= 7;
			if (tongueType == 0)
				humanCounter++;
			if (gillType == 0)
				humanCounter++;
			if (antennae == 0)
				humanCounter++;
			if (horns == 0)
				humanCounter++;
			if (wingType == Wings.NONE)
				humanCounter++;
			if (tailType == 0)
				humanCounter++;
			if (armType == Arms.HUMAN)
				humanCounter++;
			if (lowerBody == LowerBody.HUMAN)
				humanCounter++;
			if (normalCocks() >= 1 || (hasVagina() && vaginaType() == 0))
				humanCounter++;
			if (breastRows.length == 1 && hasPlainSkinOnly() && skinTone != "slippery")
				humanCounter++;
			if (findPerk(PerkLib.BlackHeart) < 0)
				humanCounter++;
			if (findPerk(PerkLib.CatlikeNimbleness) < 0)
				humanCounter++;
			if (findPerk(PerkLib.CatlikeNimblenessEvolved) < 0)
				humanCounter++;
			if (findPerk(PerkLib.DraconicLungs) < 0)
				humanCounter++;
			if (findPerk(PerkLib.DraconicLungsEvolved) < 0)
				humanCounter++;
			if (findPerk(PerkLib.GorgonsEyes) < 0)
				humanCounter++;
			if (findPerk(PerkLib.KitsuneThyroidGland) < 0)
				humanCounter++;
			if (findPerk(PerkLib.KitsuneThyroidGlandEvolved) < 0)
				humanCounter++;
			if (findPerk(PerkLib.LizanMarrow) < 0)
				humanCounter++;
			if (findPerk(PerkLib.LizanMarrowEvolved) < 0)
				humanCounter++;
			if (findPerk(PerkLib.ManticoreMetabolism) < 0)
				humanCounter++;
			if (findPerk(PerkLib.MantislikeAgility) < 0)
				humanCounter++;
			if (findPerk(PerkLib.SalamanderAdrenalGlands) < 0)
				humanCounter++;
			if (findPerk(PerkLib.SalamanderAdrenalGlandsEvolved) < 0)
				humanCounter++;
			if (findPerk(PerkLib.ScyllaInkGlands) < 0)
				humanCounter++;
			if (findPerk(PerkLib.TrachealSystem) < 0)
				humanCounter++;
			
			End("Player","racialScore");
			return humanCounter;
		}
		
		//Determine Chimera Race Rating
		public function chimeraScore():Number {
			Begin("Player","racialScore","chimera");
			var chimeraCounter:Number = 0;
			if (catScore() >= 4)
				chimeraCounter++;
			if (lizardScore() >= 4)
				chimeraCounter++;
			if (dragonScore() >= 4)
				chimeraCounter++;
			if (raccoonScore() >= 4)
				chimeraCounter++;
			if (dogScore() >= 4)
				chimeraCounter++;
			if (wolfScore() >= 6)
				chimeraCounter++;
			if (foxScore() >= 4)
				chimeraCounter++;
			if (ferretScore() >= 4)
				chimeraCounter++;
			if (kitsuneScore() >= 5)
				chimeraCounter++;
			if (horseScore() >= 4)
				chimeraCounter++;
			if (minotaurScore() >= 4)
				chimeraCounter++;
			if (cowScore() >= 4)
				chimeraCounter++;
			if (beeScore() >= 5)
				chimeraCounter++;
			if (goblinScore() >= 4)
				chimeraCounter++;
			if (demonScore() >= 5)
				chimeraCounter++;
			if (devilkinScore() >= 7)
				chimeraCounter++;
			if (sharkScore() >= 4)
				chimeraCounter++;
			if (orcaScore() >= 6)
				chimeraCounter++;
			if (oniScore() >= 6)
				chimeraCounter++;
			if (elfScore() >= 5)
				chimeraCounter++;
			if (raijuScore() >= 5)
				chimeraCounter++;
			if (bunnyScore() >= 4)
				chimeraCounter++;
			if (harpyScore() >= 4)
				chimeraCounter++;
			if (spiderScore() >= 4)
				chimeraCounter++;
			if (kangaScore() >= 4)
				chimeraCounter++;
			if (mouseScore() >= 3)
				chimeraCounter++;
			if (scorpionScore() >= 4)
				chimeraCounter++;
			if (mantisScore() >= 6)
				chimeraCounter++;
			if (salamanderScore() >= 4)
				chimeraCounter++;
			if (nagaScore() >= 4)
				chimeraCounter++;
			if (phoenixScore() >= 10)
				chimeraCounter++;
			if (scyllaScore() >= 4)
				chimeraCounter++;
			if (plantScore() >= 6)
				chimeraCounter++;
			if (pigScore() >= 4)
				chimeraCounter++;
			if (satyrScore() >= 4)
				chimeraCounter++;
			if (rhinoScore() >= 4)
				chimeraCounter++;
			if (echidnaScore() >= 4)
				chimeraCounter++;
			if (deerScore() >= 4)
				chimeraCounter++;
			if (manticoreScore() >= 6)
				chimeraCounter++;
			if (redpandaScore() >= 4)
				chimeraCounter++;
			if (sirenScore() >= 10)
				chimeraCounter++;
			if (yetiScore() >= 6)
				chimeraCounter++;
			if (batScore() >= 6)
				chimeraCounter++;
			if (vampireScore() >= 6)
				chimeraCounter++;
			if (jabberwockyScore() >= 4)
				chimeraCounter++;
			if (gargoyleScore() >= 21)
				chimeraCounter++;
			if (gooScore() >= 4)
				chimeraCounter++;
			
			End("Player","racialScore");
			return chimeraCounter;
		}
		
		//Determine Grand Chimera Race Rating
		public function grandchimeraScore():Number {
			Begin("Player","racialScore","grandchimera");
			var grandchimeraCounter:Number = 0;
			if (catScore() >= 8)
				grandchimeraCounter++;
			if (nekomataScore() >= 11)
				grandchimeraCounter++;
			if (cheshireScore() >= 11)
				grandchimeraCounter++;
			if (lizardScore() >= 8)
				grandchimeraCounter++;
			if (dragonScore() >= 10)
				grandchimeraCounter++;
/*			if (raccoonScore() >= 4)
				grandchimeraCounter++;
			if (dogScore() >= 4)
				grandchimeraCounter++;
			if (wolfScore() >= 6)
				grandchimeraCounter++;
*/			if (foxScore() >= 7)
				grandchimeraCounter++;
//			if (ferretScore() >= 4)
//				grandchimeraCounter++;
			if (kitsuneScore() >= 6 && tailType == 13 && tailCount >= 2)
				grandchimeraCounter++;	
			if (horseScore() >= 7)
				grandchimeraCounter++;
			if (unicornScore() >= 9)
				grandchimeraCounter++;
			if (alicornScore() >= 11)
				grandchimeraCounter++;	
			if (centaurScore() >= 8)
				grandchimeraCounter++;
			if (minotaurScore() >= 9)
				grandchimeraCounter++;
			if (cowScore() >= 9)
				grandchimeraCounter++;
			if (beeScore() >= 9)
				grandchimeraCounter++;
//			if (goblinScore() >= 4)
//				grandchimeraCounter++;
			if (demonScore() >= 11)
				grandchimeraCounter++;
			if (devilkinScore() >= 10)
				grandchimeraCounter++;
			if (sharkScore() >= 8)
				grandchimeraCounter++;
			if (orcaScore() >= 12)
				grandchimeraCounter++;
			if (oniScore() >= 12)
				grandchimeraCounter++;
			if (elfScore() >= 11)
				grandchimeraCounter++;
			if (raijuScore() >= 10)
				grandchimeraCounter++;
//			if (bunnyScore() >= 4)
//				grandchimeraCounter++;
			if (harpyScore() >= 8)
				grandchimeraCounter++;
			if (spiderScore() >= 7)
				grandchimeraCounter++;
/*			if (kangaScore() >= 4)
				grandchimeraCounter++;
			if (mouseScore() >= 3)
				grandchimeraCounter++;
			if (scorpionScore() >= 4)
				grandchimeraCounter++;
*/			if (mantisScore() >= 12)
				grandchimeraCounter++;
			if (salamanderScore() >= 7)
				grandchimeraCounter++;
			if (nagaScore() >= 8)
				grandchimeraCounter++;
			if (gorgonScore() >= 11)
				grandchimeraCounter++;
			if (vouivreScore() >= 11)
				grandchimeraCounter++;
			if (couatlScore() >= 11)
				grandchimeraCounter++;
			if (phoenixScore() >= 10)
				grandchimeraCounter++;
			if (scyllaScore() >= 7)
				grandchimeraCounter++;
//			if (plantScore() >= 6)
//				grandchimeraCounter++;
			if (alrauneScore() >= 10)
				grandchimeraCounter++;
			if (yggdrasilScore() >= 10)
				grandchimeraCounter++;
/*			if (pigScore() >= 4)
				grandchimeraCounter++;
			if (satyrScore() >= 4)
				grandchimeraCounter++;
			if (rhinoScore() >= 4)
				grandchimeraCounter++;
			if (echidnaScore() >= 4)
				grandchimeraCounter++;
			if (deerScore() >= 4)
				grandchimeraCounter++;
*/			if (manticoreScore() >= 12)
				grandchimeraCounter += 2;
			if (redpandaScore() >= 8)
				grandchimeraCounter++;
			if (sirenScore() >= 10)
				grandchimeraCounter++;
			if (yetiScore() >= 12)
				grandchimeraCounter++;
			if (batScore() >= 10)
				grandchimeraCounter++;
			if (vampireScore() >= 10)
				grandchimeraCounter++;
			if (jabberwockyScore() >= 10)
				grandchimeraCounter++;
			if (gargoyleScore() >= 21)
				grandchimeraCounter++;
			if (gooScore() >= 8)
				grandchimeraCounter++;
			
			End("Player","racialScore");
			return grandchimeraCounter;
		}
		
		//Determine Inner Chimera Score
		public function internalChimeraScore():Number {
			Begin("Player","racialScore","internalChimeraScore");
			var internalChimeraCounter:Number = 0;
			if (findPerk(PerkLib.BlackHeart) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.CatlikeNimbleness) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.CatlikeNimblenessEvolved) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.DraconicLungs) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.DraconicLungsEvolved) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.GorgonsEyes) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.KitsuneThyroidGland) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.KitsuneThyroidGlandEvolved) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.LizanMarrow) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.LizanMarrowEvolved) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.ManticoreMetabolism) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.MantislikeAgility) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.MantislikeAgilityEvolved) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.SalamanderAdrenalGlands) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.SalamanderAdrenalGlandsEvolved) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.ScyllaInkGlands) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.TrachealSystem) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.TrachealSystemEvolved) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.TrachealSystemFinalForm) >= 0)
				internalChimeraCounter++;
		//	if (findPerk(PerkLib.TrachealSystemEvolved) >= 0)
		//		internalChimeraCounter++;
			
			End("Player","racialScore");
			return internalChimeraCounter;
		}
		
		//Determine Inner Chimera Rating
		public function internalChimeraRating():Number {
			Begin("Player","racialScore","internalChimeraRating");
			var internalChimeraRatingCounter:Number = 0;
			if (findPerk(PerkLib.BlackHeart) >= 0)
				internalChimeraRatingCounter++;
			if (findPerk(PerkLib.CatlikeNimbleness) >= 0)
				internalChimeraRatingCounter++;
			if (findPerk(PerkLib.CatlikeNimblenessEvolved) >= 0)
				internalChimeraRatingCounter++;
			if (findPerk(PerkLib.DraconicLungs) >= 0)
				internalChimeraRatingCounter++;
			if (findPerk(PerkLib.DraconicLungsEvolved) >= 0)
				internalChimeraRatingCounter++;
			if (findPerk(PerkLib.GorgonsEyes) >= 0)
				internalChimeraRatingCounter++;
			if (findPerk(PerkLib.KitsuneThyroidGland) >= 0)
				internalChimeraRatingCounter++;
			if (findPerk(PerkLib.KitsuneThyroidGlandEvolved) >= 0)
				internalChimeraRatingCounter++;
			if (findPerk(PerkLib.LizanMarrow) >= 0)
				internalChimeraRatingCounter++;
			if (findPerk(PerkLib.LizanMarrowEvolved) >= 0)
				internalChimeraRatingCounter++;
			if (findPerk(PerkLib.ManticoreMetabolism) >= 0)
				internalChimeraRatingCounter++;
			if (findPerk(PerkLib.MantislikeAgility) >= 0)
				internalChimeraRatingCounter++;
			if (findPerk(PerkLib.MantislikeAgilityEvolved) >= 0)
				internalChimeraRatingCounter++;
			if (findPerk(PerkLib.SalamanderAdrenalGlands) >= 0)
				internalChimeraRatingCounter++;
			if (findPerk(PerkLib.SalamanderAdrenalGlandsEvolved) >= 0)
				internalChimeraRatingCounter++;
			if (findPerk(PerkLib.ScyllaInkGlands) >= 0)
				internalChimeraRatingCounter++;
			if (findPerk(PerkLib.TrachealSystem) >= 0)
				internalChimeraRatingCounter++;
			if (findPerk(PerkLib.TrachealSystemEvolved) >= 0)
				internalChimeraRatingCounter++;
			if (findPerk(PerkLib.TrachealSystemFinalForm) >= 0)
				internalChimeraRatingCounter++;
		//	if (findPerk(PerkLib.TrachealSystemEvolved) >= 0)
		//		internalChimeraRatingCounter++;
			if (findPerk(PerkLib.ChimericalBodyInitialStage) >= 0)
				internalChimeraRatingCounter -= 2;
			if (findPerk(PerkLib.ChimericalBodyBasicStage) >= 0)
				internalChimeraRatingCounter -= 3;
			if (findPerk(PerkLib.ChimericalBodyAdvancedStage) >= 0)
				internalChimeraRatingCounter -= 4;
			if (findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0)
				internalChimeraRatingCounter -= 5;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				internalChimeraRatingCounter -= 6;
			End("Player","racialScore");
			return internalChimeraRatingCounter;
		}

		//determine demon rating
		public function demonScore():Number {
			Begin("Player","racialScore","demon");
			var demonCounter:Number = 0;
			if (hornType == Horns.DEMON && horns > 0)
				demonCounter++;
			if (cor >= 50 && hornType == Horns.DEMON && horns > 4)
				demonCounter++;
			if (tailType == Tail.DEMONIC)
				demonCounter++;
			if (wingType == Wings.BAT_LIKE_TINY)
				demonCounter++;
			if (wingType == Wings.BAT_LIKE_LARGE)
				demonCounter += 2;
			if (wingType == Wings.BAT_LIKE_LARGE_2)
				demonCounter += 4;
			if (tongueType == Tongue.DEMONIC)
				demonCounter++;
			if (cor >= 50 && hasPlainSkinOnly() && skinTone != "slippery")
				demonCounter++;
			if (cor >= 50 && faceType == Face.HUMAN)
				demonCounter++;
			if (cor >= 50 && armType == Arms.HUMAN)
				demonCounter++;
			if (lowerBody == LowerBody.DEMONIC_HIGH_HEELS || lowerBody == LowerBody.DEMONIC_CLAWS)
				demonCounter++;
			if (demonCocks() > 0)
				demonCounter++;
			if (findPerk(PerkLib.BlackHeart) >= 0)
				demonCounter++;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && demonCounter >= 5)
				demonCounter += 1;
			if (findPerk(PerkLib.BlackHeart) >= 0 && findPerk(PerkLib.ChimericalBodyAdvancedStage) >= 0)
				demonCounter++;
			if (hornType == Horns.GOAT)
				demonCounter -= 10;
			if (findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0)
				demonCounter += 10;
			if (hasPerk(PerkLib.DemonicLethicite))
				demonCounter+=1;
			End("Player","racialScore");
			return demonCounter;
		}

		//determine devil/infernal goat rating
		public function devilkinScore():Number {
			Begin("Player","racialScore","devil");
			var devilkinCounter:Number = 0;
			if (lowerBody == LowerBody.HOOFED)
				devilkinCounter++;
			if (tailType == Tail.GOAT || tailType == Tail.DEMONIC)
				devilkinCounter++;
			if (wingType == Wings.BAT_LIKE_TINY || wingType == Wings.BAT_LIKE_LARGE)
				devilkinCounter += 4;
			if (armType == Arms.DEVIL)
				devilkinCounter++;
			if (hornType == Horns.GOAT)
				devilkinCounter++;
			if (earType == Ears.GOAT)
				devilkinCounter++;
			if (faceType == Face.DEVIL_FANGS)
				devilkinCounter++;
			if (eyeType == Eyes.DEVIL)
				devilkinCounter++;
			if (tallness < 48)
				devilkinCounter++;
			if (cor >= 60)
				devilkinCounter++;
			End("Player","racialScore");
			return devilkinCounter;
		}

		//Determine minotaur rating
		public function minotaurScore():Number {
			Begin("Player","racialScore","minotaur");
			var minoCounter:Number = 0;
			if (faceType == Face.HUMAN || faceType == Face.COW_MINOTAUR)
				minoCounter++;
			if (earType == Ears.COW)
				minoCounter++;
			if (tailType == Tail.COW)
				minoCounter++;
			if (lowerBody == LowerBody.HOOFED)
				minoCounter++;
			if (hornType == Horns.COW_MINOTAUR)
				minoCounter++;
			if (minoCounter >= 4) {
				if (cumQ() > 500)
					minoCounter++;
				if (hasFur() || hasPartialCoat(Skin.FUR))
					minoCounter++;
				if (tallness >= 81)
					minoCounter++;
				if (cor >= 20)
					minoCounter++;
				if (cocks.length > 0 && horseCocks() > 0)
					minoCounter++;
				if (vaginas.length > 0)
					minoCounter -= 8;
			}
			if (findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0)
				minoCounter += 10;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && minoCounter >= 4)
				minoCounter += 1;
			End("Player","racialScore");
			return minoCounter;
		}

		//Determine cow rating
		public function cowScore():Number {
			Begin("Player","racialScore","cow");
			var cowCounter:Number = 0;
			if (faceType == Face.HUMAN || faceType == Face.COW_MINOTAUR)
				cowCounter++;
			if (earType == Ears.COW)
				cowCounter++;
			if (tailType == Tail.COW)
				cowCounter++;
			if (lowerBody == LowerBody.HOOFED)
				cowCounter++;
			if (hornType == Horns.COW_MINOTAUR)
				cowCounter++;
			if (cowCounter >= 4) {
				if (biggestTitSize() > 4)
					cowCounter++;
				if (hasFur() || hasPartialCoat(Skin.FUR))
					cowCounter++;
				if (tallness >= 73)
					cowCounter++;
				if (cor >= 20)
					cowCounter++;
				if (vaginas.length > 0)
					cowCounter++;
				if (cocks.length > 0)
					cowCounter -= 8;
			}
			if (findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0)
				cowCounter += 10;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && cowCounter >= 4)
				cowCounter += 1;
			End("Player","racialScore");
			return cowCounter;
		}

		public function sandTrapScore():int {
			Begin("Player","racialScore","sandTrap");
			var counter:int = 0;
			if (hasStatusEffect(StatusEffects.BlackNipples))
				counter++;
			if (hasStatusEffect(StatusEffects.Uniball))
				counter++;
			if (hasVagina() && vaginaType() == VaginaClass.BLACK_SAND_TRAP)
				counter++;
			if (eyeType == Eyes.BLACK_EYES_SAND_TRAP)
				counter++;
			if (wingType == Wings.GIANT_DRAGONFLY)
				counter++;
			if (hasStatusEffect(StatusEffects.Uniball))
				counter++;
			End("Player","racialScore");
			return counter;
		}

		//Determine Bee Rating
		public function beeScore():Number {
			Begin("Player","racialScore","bee");
			var beeCounter:Number = 0;
			if (hairColor == "shiny black")
				beeCounter++;
			if (hairColor == "black and yellow") // TODO if hairColor2 == yellow && hairColor == black
				beeCounter += 2;
			if (antennae == Antennae.BEE)
			{
				beeCounter++;
				if (faceType == Face.HUMAN)
					beeCounter++;
			}
			if (armType == Arms.BEE)
				beeCounter++;
			if (lowerBody == LowerBody.BEE)
			{
				beeCounter++;
				if (vaginas.length == 1)
					beeCounter++;
			}
			if (tailType == Tail.BEE_ABDOMEN)
				beeCounter++;
			if (wingType == Wings.BEE_LIKE_SMALL)
				beeCounter++;
			if (wingType == Wings.BEE_LIKE_LARGE)
				beeCounter += 2;
			if (beeCounter > 0 && findPerk(PerkLib.TrachealSystem) >= 0)
				beeCounter++;
			if (beeCounter > 4 && findPerk(PerkLib.TrachealSystemEvolved) >= 0)
				beeCounter++;
			if (beeCounter > 8 && findPerk(PerkLib.TrachealSystemFinalForm) >= 0)
				beeCounter++;
			if (findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0)
				beeCounter += 10;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && beeCounter >= 3)
				beeCounter += 1;
			End("Player","racialScore");
			return beeCounter;
		}
		//Determine Ferret Rating!
		public function ferretScore():Number {
			Begin("Player","racialScore","ferret");
			var counter:int = 0;
			if (faceType == Face.FERRET_MASK) counter++;
			if (faceType == Face.FERRET) counter+=2;
			if (earType == Ears.FERRET) counter++;
			if (tailType == Tail.FERRET) counter++;
			if (lowerBody == LowerBody.FERRET) counter++;
			if (hasFur() && counter > 0) counter++;
			
			End("Player","racialScore");
			return counter;
		}
		//Determine Dog Rating
		public function dogScore():Number {
			Begin("Player","racialScore","dog");
			var dogCounter:Number = 0;
			if (faceType == Face.DOG)
				dogCounter++;
			if (earType == Ears.DOG)
				dogCounter++;
			if (tailType == Tail.DOG)
				dogCounter++;
			if (lowerBody == LowerBody.DOG)
				dogCounter++;
			if (dogCocks() > 0)
				dogCounter++;
			if (breastRows.length > 1)
				dogCounter++;
			if (breastRows.length == 3)
				dogCounter++;
			if (breastRows.length > 3)
				dogCounter--;
			//Fur only counts if some canine features are present
			if (hasFur() && dogCounter > 0)
				dogCounter++;
			if (findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0)
				dogCounter += 10;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && dogCounter >= 3)
				dogCounter += 1;
			End("Player","racialScore");
			return dogCounter;
		}

		public function mouseScore():Number {
			Begin("Player","racialScore","mouse");
			var mouseCounter:Number = 0;
			if (earType == Ears.MOUSE)
				mouseCounter++;
			if (tailType == Tail.MOUSE)
				mouseCounter++;
			if (faceType == Face.BUCKTEETH)
				mouseCounter++;
			if (faceType == Face.MOUSE)
				mouseCounter += 2;
			//Fur only counts if some canine features are present
			if (hasFur() && mouseCounter > 0)
				mouseCounter++;
			if (tallness < 55 && mouseCounter > 0)
				mouseCounter++;
			if (tallness < 45 && mouseCounter > 0)
				mouseCounter++;
			
			End("Player","racialScore");
			return mouseCounter;
		}

		public function raccoonScore():Number {
			Begin("Player","racialScore","raccoon");
			var coonCounter:Number = 0;
			if (faceType == Face.RACCOON_MASK)
				coonCounter++;
			if (faceType == Face.RACCOON)
				coonCounter += 2;
			if (earType == Ears.RACCOON)
				coonCounter++;
			if (tailType == Tail.RACCOON)
				coonCounter++;
			if (lowerBody == LowerBody.RACCOON)
				coonCounter++;
			if (coonCounter > 0 && balls > 0)
				coonCounter++;
			//Fur only counts if some canine features are present
			if (hasFur() && coonCounter > 0)
				coonCounter++;
			if (findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0)
				coonCounter += 10;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && coonCounter >= 3)
				coonCounter += 1;
			
			End("Player","racialScore");
			return coonCounter;
		}

		//Determine Fox Rating
		public function foxScore():Number {
			Begin("Player","racialScore","fox");
			var foxCounter:Number = 0;
			if (faceType == Face.FOX)
				foxCounter++;
			if (eyeType == Eyes.FOX)
				foxCounter++;
			if (earType == Ears.FOX)
				foxCounter++;
			if (tailType == Tail.FOX)
				foxCounter++;
			if (tailType == Tail.FOX && tailCount >= 2)
				foxCounter -= 7;
			if (armType == Arms.FOX)
				foxCounter++;
			if (lowerBody == LowerBody.FOX)
				foxCounter++;
			if (foxCocks() > 0 && foxCounter > 0)
				foxCounter++;
			if (breastRows.length > 1 && foxCounter > 0)
				foxCounter++;
			if (breastRows.length == 3 && foxCounter > 0)
				foxCounter++;
			if (breastRows.length == 4 && foxCounter > 0)
				foxCounter++;
			//Fur only counts if some canine features are present
			if (hasFur() && foxCounter > 0)
				foxCounter++;
			if (findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0)
				foxCounter += 10;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && foxCounter >= 3)
				foxCounter += 1;
			End("Player","racialScore");
			return foxCounter;
		}

		//Determine cat Rating
		public function catScore():Number {
			Begin("Player","racialScore","cat");
			var catCounter:Number = 0;
			if (faceType == Face.CAT || faceType == Face.CAT_CANINES)
				catCounter++;
			if (faceType == Face.CHESHIRE || faceType == Face.CHESHIRE_SMILE)
				catCounter -= 7;
			if (eyeType == Eyes.CAT_SLITS)
				catCounter++;
			if (earType == Ears.CAT)
				catCounter++;
			if (tongueType == Tongue.CAT)
				catCounter++;
			if (tailType == Tail.CAT)
				catCounter++;
			if (armType == Arms.CAT)
				catCounter++;
			if (lowerBody == LowerBody.CAT)
				catCounter++;
			if (catCocks() > 0)
				catCounter++;
			if (breastRows.length > 1 && catCounter > 0)
				catCounter++;
			if (breastRows.length == 3 && catCounter > 0)
				catCounter++;
			if (breastRows.length > 3)
				catCounter -= 2;
			if (hasFur() || hasPartialCoat(Skin.FUR))
				catCounter++;
			if (hairColor == "lilac and white striped" && coatColor == "lilac and white striped")
				catCounter -= 7;
			if (hornType == Horns.DEMON || hornType == Horns.DRACONIC_X2 || hornType == Horns.DRACONIC_X4_12_INCH_LONG)
				catCounter -= 2;
			if (wingType == Wings.BAT_LIKE_TINY || wingType == Wings.DRACONIC_SMALL || wingType == Wings.BAT_LIKE_LARGE || wingType == Wings.DRACONIC_LARGE || Wings.BAT_LIKE_LARGE_2 || Wings.DRACONIC_HUGE)
				catCounter -= 2;
			if (findPerk(PerkLib.Flexibility) > 0)
				catCounter++;
			if (findPerk(PerkLib.CatlikeNimbleness) > 0)
				catCounter++;
			if (findPerk(PerkLib.CatlikeNimblenessEvolved) > 0)
				catCounter++;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && catCounter >= 3)
				catCounter += 1;
			if (findPerk(PerkLib.CatlikeNimbleness) >= 0 && findPerk(PerkLib.ChimericalBodyAdvancedStage) >= 0)
				catCounter++;
			if (findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0)
				catCounter += 10;
			
			End("Player","racialScore");
			return catCounter;
		}
		//Determine nekomata Rating
		public function nekomataScore():Number {
			Begin("Player","racialScore","nekomata");
			var nekomataCounter:Number = 0;
			if (faceType == Face.CAT || faceType == Face.CAT_CANINES)
				nekomataCounter++;
			if (eyeType == Eyes.CAT_SLITS)
				nekomataCounter++;
			if (earType == Ears.CAT)
				nekomataCounter++;
			if (tongueType == Tongue.CAT)
				nekomataCounter++;
			if (tailType == Tail.CAT)
				nekomataCounter++;
			if (armType == Arms.CAT)
				nekomataCounter++;
			if (lowerBody == LowerBody.CAT)
				nekomataCounter++;
			if (hasFur() || hasPartialCoat(Skin.FUR))
				nekomataCounter++;
			if (findPerk(PerkLib.Flexibility) > 0)
				nekomataCounter++;
			if (findPerk(PerkLib.CatlikeNimbleness) > 0)
				nekomataCounter++;
			if (findPerk(PerkLib.CatlikeNimblenessEvolved) > 0)
				nekomataCounter++;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && nekomataCounter >= 7)
				nekomataCounter += 1;

			End("Player","racialScore");
			return nekomataCounter;
		}
		//Determine cheshire Rating
		public function cheshireScore():Number {
			Begin("Player","racialScore","cheshire");
			var cheshireCounter:Number = 0;
			if (faceType == Face.CHESHIRE || faceType == Face.CHESHIRE_SMILE)
				cheshireCounter += 2;
			if (eyeType == Eyes.CAT_SLITS)
				cheshireCounter++;
			if (earType == Ears.CAT)
				cheshireCounter++;
			if (tongueType == Tongue.CAT)
				cheshireCounter++;
			if (tailType == Tail.CAT)
				cheshireCounter++;
			if (armType == Arms.CAT)
				cheshireCounter++;
			if (lowerBody == LowerBody.CAT)
				cheshireCounter++;
			if (hasFur() || hasPartialCoat(Skin.FUR))
				cheshireCounter++;
			if (hairColor == "lilac and white striped" && coatColor == "lilac and white striped")
				cheshireCounter += 2;
			if (findPerk(PerkLib.Flexibility) > 0)
				cheshireCounter++;
			if (findPerk(PerkLib.CatlikeNimbleness) > 0)
				cheshireCounter++;
			if (findPerk(PerkLib.CatlikeNimblenessEvolved) > 0)
				cheshireCounter++;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && cheshireCounter >= 7)
				cheshireCounter += 1;

			End("Player","racialScore");
			return cheshireCounter;
		}

		//Determine lizard rating
		public function lizardScore():Number {
			Begin("Player","racialScore","lizard");
			var lizardCounter:Number = 0;
			if (faceType == Face.LIZARD)
				lizardCounter++;
			if (earType == Ears.LIZARD)
				lizardCounter++;
			if (eyeType == Eyes.REPTILIAN)
				lizardCounter++;
			if (tailType == Tail.LIZARD)
				lizardCounter++;
			if (armType == Arms.LIZARD)
				lizardCounter++;
			if (lowerBody == LowerBody.LIZARD)
				lizardCounter++;
			if (horns > 0 && (hornType == Horns.DRACONIC_X2 || hornType == Horns.DRACONIC_X4_12_INCH_LONG))
				lizardCounter++;
			if (hasScales())
				lizardCounter++;
			if (lizardCocks() > 0)
				lizardCounter++;
			if (lizardCounter > 0 && findPerk(PerkLib.LizanRegeneration) >= 0)
				lizardCounter++;
			if (findPerk(PerkLib.LizanMarrow) >= 0)
				lizardCounter++;
			if (findPerk(PerkLib.LizanMarrowEvolved) >= 0)
				lizardCounter++;
			if (findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0)
				lizardCounter += 10;
			if (findPerk(PerkLib.LizanMarrow) >= 0 && findPerk(PerkLib.ChimericalBodyAdvancedStage) >= 0)
				lizardCounter++;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && lizardCounter >= 4)
				lizardCounter += 1;
			
			End("Player","racialScore");
			return lizardCounter;
		}

		public function spiderScore():Number {
			Begin("Player","racialScore","spider");
			var spiderCounter:Number = 0;
			if (eyeType == Eyes.FOUR_SPIDER_EYES)
				spiderCounter++;
			if (faceType == Face.SPIDER_FANGS)
				spiderCounter++;
			if (armType == Arms.SPIDER)
				spiderCounter++;
			if (lowerBody == LowerBody.CHITINOUS_SPIDER_LEGS)
				spiderCounter++;
			if (lowerBody == LowerBody.DRIDER)
				spiderCounter += 2;
			if (tailType == Tail.SPIDER_ADBOMEN)
				spiderCounter++;
			if (!hasCoatOfType(Skin.CHITIN) && spiderCounter > 0)
				spiderCounter--;
			if (hasCoatOfType(Skin.CHITIN))
				spiderCounter++;
			if (spiderCounter > 0 && findPerk(PerkLib.TrachealSystem) >= 0)
				spiderCounter++;
			if (spiderCounter > 4 && findPerk(PerkLib.TrachealSystemEvolved) >= 0)
				spiderCounter++;
			if (spiderCounter > 8 && findPerk(PerkLib.TrachealSystemFinalForm) >= 0)
				spiderCounter++;
			if (findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0)
				spiderCounter += 10;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && spiderCounter >= 3)
				spiderCounter += 1;
			
			End("Player","racialScore");
			return spiderCounter;
		}

		//Determine Horse Rating
		public function horseScore():Number {
			Begin("Player","racialScore","horse");
			var horseCounter:Number = 0;
			if (faceType == Face.HORSE)
				horseCounter++;
			if (earType == Ears.HORSE)
				horseCounter++;
			if (tailType == Tail.HORSE)
				horseCounter++;
			if (lowerBody == LowerBody.HOOFED || lowerBody == LowerBody.CENTAUR)
				horseCounter++;
			if (horseCocks() > 0)
				horseCounter++;
			if (hasVagina() && vaginaType() == VaginaClass.EQUINE)
				horseCounter++;
			if (hasFur()) {
				if (armType == Arms.HUMAN)
					horseCounter++;
				horseCounter++;
			}
			if (isTaur())
				horseCounter -= 5;
			if (unicornScore() > 8 || alicornScore() > 10)
				horseCounter -= 5;
			if (findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0)
				horseCounter += 10;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && horseCounter >= 3)
				horseCounter += 1;
			
			End("Player","racialScore");
			return horseCounter;
		}

		//Determine kitsune Rating
		public function kitsuneScore():Number {
			Begin("Player","racialScore","kitsune");
			var kitsuneCounter:int = 0;
			if (eyeType == Eyes.FOX)
				kitsuneCounter++;
			if (earType == Ears.FOX)
				kitsuneCounter++;
			//If the character has ears other than fox ears, -1
			if (earType != Ears.FOX)
				kitsuneCounter--;
			if (tailType == Tail.FOX && tailCount >= 2 && tailCount < 4)
				kitsuneCounter++;
			if (tailType == Tail.FOX && tailCount >= 4 && tailCount < 6)
				kitsuneCounter += 2;
			if (tailType == Tail.FOX && tailCount >= 6 && tailCount < 9)
				kitsuneCounter += 3;
			if (tailType == Tail.FOX && tailCount == 9)
				kitsuneCounter += 4;
			if (tailType != Tail.FOX || (tailType == Tail.FOX && tailCount < 2))
				kitsuneCounter -= 7;
			if (skin.base.pattern == Skin.PATTERN_MAGICAL_TATTOO || hasFur())
				kitsuneCounter++;
			//If the character has fur, scales, or gooey skin, -1
		//	if (skinType == FUR && !InCollection(furColor, KitsuneScene.basicKitsuneFur) && !InCollection(furColor, KitsuneScene.elderKitsuneColors))
		//		kitsuneCounter--;
			if (hasCoat() && !hasCoatOfType(Skin.FUR))
				kitsuneCounter -= 2;
			if (skin.base.type != Skin.PLAIN)
				kitsuneCounter -= 3;
			if (armType == Arms.HUMAN || armType == Arms.KITSUNE)
				kitsuneCounter++;
			if (lowerBody == LowerBody.FOX || lowerBody == LowerBody.HUMAN)
				kitsuneCounter++;
			if (lowerBody != LowerBody.HUMAN && lowerBody != LowerBody.FOX)
				kitsuneCounter--;
			//If the character has a 'vag of holding', +1
			if (vaginalCapacity() >= 8000)
				kitsuneCounter++;
			if (faceType == Face.HUMAN || faceType == Face.FOX)
				kitsuneCounter++;
			if (faceType != Face.HUMAN && faceType != Face.FOX)
				kitsuneCounter--;
			//If the character has "blonde","black","red","white", or "silver" hair, +1
		//	if (kitsuneCounter > 0 && (InCollection(furColor, KitsuneScene.basicKitsuneHair) || InCollection(furColor, KitsuneScene.elderKitsuneColors)))
		//		kitsuneCounter++;
			if (findPerk(PerkLib.StarSphereMastery) >= 0)
				kitsuneCounter++;
			//When character get Hoshi no tama
			if (findPerk(PerkLib.KitsuneThyroidGland) >= 0)
				kitsuneCounter++;
			if (findPerk(PerkLib.KitsuneThyroidGlandEvolved) >= 0)
				kitsuneCounter++;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && kitsuneCounter >= 5)
				kitsuneCounter += 1;
			if (findPerk(PerkLib.KitsuneThyroidGland) >= 0 && findPerk(PerkLib.ChimericalBodyAdvancedStage) >= 0)
				kitsuneCounter++;
			if (findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0)
				kitsuneCounter += 10;
			
			End("Player","racialScore");
			return kitsuneCounter;
		}

		//Determine Dragon Rating
		public function dragonScore():Number {
			Begin("Player","racialScore","dragon");
			var dragonCounter:Number = 0;
			if (faceType == Face.DRAGON || faceType == Face.DRAGON_FANGS)
				dragonCounter++;
			if (faceType == Face.JABBERWOCKY || faceType == Face.BUCKTOOTH)
				dragonCounter -= 10;
			if (eyeType == Eyes.DRAGON)
				dragonCounter++;
			if (earType == Ears.DRAGON)
				dragonCounter++;
			if (tailType == Tail.DRACONIC)
				dragonCounter++;
			if (tongueType == Tongue.DRACONIC)
				dragonCounter++;
			if (wingType == Wings.DRACONIC_SMALL)
				dragonCounter++;
			if (wingType == Wings.DRACONIC_LARGE)
				dragonCounter += 2;
			if (wingType == Wings.DRACONIC_HUGE)
				dragonCounter += 4;
			if (wingType == Wings.FEY_DRAGON_WINGS)
				dragonCounter -= 10;
			if (lowerBody == LowerBody.DRAGON)
				dragonCounter++;
			if (armType == Arms.DRAGON)
				dragonCounter++;
			if (tallness > 120 && dragonCounter >= 10)
				dragonCounter++;
			if (skinType == Skin.DRAGON_SCALES)// FIXME: what about PARTIAL_DRAGON_SCALES?
				dragonCounter++;
			if (hornType == Horns.DRACONIC_X4_12_INCH_LONG)
				dragonCounter += 2;
			if (hornType == Horns.DRACONIC_X2)
				dragonCounter++;
		//	if (dragonCocks() > 0)
		//		dragonCounter++;
			if (findPerk(PerkLib.DragonFireBreath) >= 0 && dragonCounter >= 4)
				dragonCounter++;
			if (findPerk(PerkLib.DragonIceBreath) >= 0 && dragonCounter >= 4)
				dragonCounter++;
			if (findPerk(PerkLib.DragonLightningBreath) >= 0 && dragonCounter >= 4)
				dragonCounter++;
			if (findPerk(PerkLib.DragonDarknessBreath) >= 0 && dragonCounter >= 4)
				dragonCounter++;
			if (findPerk(PerkLib.DraconicLungs) >= 0)
				dragonCounter++;
			if (findPerk(PerkLib.DraconicLungsEvolved) >= 0)
				dragonCounter++;
		//	if (findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0)
		//		dragonCounter += 10;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && dragonCounter >= 4)
				dragonCounter += 1;
			if (findPerk(PerkLib.DraconicLungs) >= 0 && findPerk(PerkLib.ChimericalBodyAdvancedStage) >= 0)
				dragonCounter++;
			
			End("Player","racialScore");
			return dragonCounter;
		}
		
		//Determine Jabberwocky Rating
		public function jabberwockyScore():Number {
			Begin("Player","racialScore","dragon");
			var jabberwockyCounter:Number = 0;
			if (faceType == Face.JABBERWOCKY || faceType == Face.BUCKTOOTH)
				jabberwockyCounter++;
			if (faceType == Face.DRAGON || faceType == Face.DRAGON_FANGS)
				jabberwockyCounter -= 10;
			if (eyeType == Eyes.DRAGON)
				jabberwockyCounter++;
			if (earType == Ears.DRAGON)
				jabberwockyCounter++;
			if (tailType == Tail.DRACONIC)
				jabberwockyCounter++;
			if (tongueType == Tongue.DRACONIC)
				jabberwockyCounter++;
			if (wingType == Wings.FEY_DRAGON_WINGS)
				jabberwockyCounter += 4;
			if (wingType == Wings.DRACONIC_SMALL || wingType == Wings.DRACONIC_LARGE || wingType == Wings.DRACONIC_HUGE)
				jabberwockyCounter -= 10;
			if (lowerBody == LowerBody.DRAGON)
				jabberwockyCounter++;
			if (armType == Arms.DRAGON)
				jabberwockyCounter++;
			if (tallness > 120 && jabberwockyCounter >= 10)
				jabberwockyCounter++;
			if (skinType == Skin.DRAGON_SCALES)// FIXME: what about PARTIAL_DRAGON_SCALES?
				jabberwockyCounter++;
			if (hornType == Horns.DRACONIC_X4_12_INCH_LONG)
				jabberwockyCounter += 2;
			if (hornType == Horns.DRACONIC_X2)
				jabberwockyCounter++;
		//	if (dragonCocks() > 0)
		//		dragonCounter++;
			if (findPerk(PerkLib.DragonFireBreath) >= 0 && jabberwockyCounter >= 4)
				jabberwockyCounter++;
			if (findPerk(PerkLib.DragonIceBreath) >= 0 && jabberwockyCounter >= 4)
				jabberwockyCounter++;
			if (findPerk(PerkLib.DragonLightningBreath) >= 0 && jabberwockyCounter >= 4)
				jabberwockyCounter++;
			if (findPerk(PerkLib.DragonDarknessBreath) >= 0 && jabberwockyCounter >= 4)
				jabberwockyCounter++;
			if (findPerk(PerkLib.DraconicLungs) >= 0)
				jabberwockyCounter++;
			if (findPerk(PerkLib.DraconicLungsEvolved) >= 0)
				jabberwockyCounter++;
		//	if (findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0)
		//		dragonCounter += 10;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && jabberwockyCounter >= 4)
				jabberwockyCounter += 1;
			if (findPerk(PerkLib.DraconicLungs) >= 0 && findPerk(PerkLib.ChimericalBodyAdvancedStage) >= 0)
				jabberwockyCounter++;
			
			End("Player","racialScore");
			return jabberwockyCounter;
		}

		//Goblin score
		public function goblinScore():Number
		{
			Begin("Player","racialScore","goblin");
			var goblinCounter:Number = 0;
			if (skinTone == "pale yellow" || skinTone == "grayish-blue" || skinTone == "green" || skinTone == "dark green") {	
				if (tallness < 48 && goblinCounter > 0)
					goblinCounter++;
				if (faceType == Face.HUMAN)
					goblinCounter++;
				if (hasVagina())
					goblinCounter++;
				if (lowerBody == LowerBody.HUMAN)
					goblinCounter++;
			}
			if (earType == Ears.ELFIN)
				goblinCounter++;
			if (skinTone == "pale yellow" || skinTone == "grayish-blue" || skinTone == "green" || skinTone == "dark green")
				goblinCounter++;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && goblinCounter >= 3)
				goblinCounter += 1;
			End("Player","racialScore");
			return goblinCounter;
		}

		//Goo score
		public function gooScore():Number
		{
			Begin("Player","racialScore","goo");
			var gooCounter:Number = 0;
			if (hairType == Hair.GOO)
				gooCounter++;
			if (hasGooSkin() && skinAdj == "slimy") {
				gooCounter++;
				if (faceType == Face.HUMAN)
					gooCounter++;
				if (armType == Arms.HUMAN)
					gooCounter++;
			}
			if (wingType == Wings.NONE)
				gooCounter++;
			if (lowerBody == LowerBody.GOO)
				gooCounter += 2;
			if (vaginalCapacity() > 9000)
				gooCounter++;
			if (hasStatusEffect(StatusEffects.SlimeCraving))
				gooCounter++;
			if (findPerk(PerkLib.SlimeCore) >= 0)
				gooCounter++;
			if (findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0)
				gooCounter += 10;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && gooCounter >= 4)
				gooCounter += 1;
			End("Player","racialScore");
			return gooCounter;
		}

		//Naga score
		public function nagaScore():Number {
			Begin("Player","racialScore","naga");
			var nagaCounter:Number = 0;
			if (isNaga())
				nagaCounter += 2;
			if (tongueType == Tongue.SNAKE)
				nagaCounter++;
			if (faceType == Face.SNAKE_FANGS)
				nagaCounter++;
			if (armType == Arms.HUMAN)
				nagaCounter++;
			if (hasPartialCoat(Skin.SCALES))
				nagaCounter++;
			if (eyeType == Eyes.SNAKE)
				nagaCounter++;
			if (earType == Ears.SNAKE)
				nagaCounter++;
			if (gorgonScore() > 10 || vouivreScore() > 10 || couatlScore() > 10)
				nagaCounter -= 8;
			
			End("Player","racialScore");
			return nagaCounter;
		}
		//Gorgon score
		public function gorgonScore():Number {
			Begin("Player","racialScore","gorgon");
			var gorgonCounter:Number = 0;
			if (isNaga())
				gorgonCounter += 2;
			if (tongueType == Tongue.SNAKE)
				gorgonCounter++;
			if (faceType == Face.SNAKE_FANGS)
				gorgonCounter++;
			if (armType == Arms.HUMAN)
				gorgonCounter++;
			if (hasCoatOfType(Skin.SCALES))
				gorgonCounter++;
			if (earType == Ears.SNAKE)
				gorgonCounter++;
			if (eyeType == Eyes.SNAKE)
				gorgonCounter++;
			if (eyeType == Eyes.GORGON)
				gorgonCounter += 2;
			if (hairType == Hair.GORGON)
				gorgonCounter += 2;
			if (findPerk(PerkLib.GorgonsEyes) >= 0)
				gorgonCounter++;
			if (antennae != Antennae.NONE)
				gorgonCounter -= 3;
			if (wingType != Wings.NONE)
				gorgonCounter -= 3;
			if (findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0)
				gorgonCounter += 10;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && gorgonCounter >= 7)
				gorgonCounter += 1;
			if (findPerk(PerkLib.GorgonsEyes) >= 0 && findPerk(PerkLib.ChimericalBodyAdvancedStage) >= 0)
				gorgonCounter++;
			
			End("Player","racialScore");
			return gorgonCounter;
		}
		//Vouivre score
		public function vouivreScore():Number {
			Begin("Player","racialScore","vouivre");
			var vouivreCounter:Number = 0;
			if (isNaga())
				vouivreCounter += 2;
			if (tongueType == Tongue.SNAKE)
				vouivreCounter++;
			if (faceType == Face.SNAKE_FANGS)
				vouivreCounter++;
			if (armType == Arms.DRAGON)
				vouivreCounter++;
			if (hasCoatOfType(Skin.DRAGON_SCALES))
				vouivreCounter++;
			if (eyeType == Eyes.SNAKE)
				vouivreCounter++;
			if (earType == Ears.DRAGON)
				vouivreCounter++;
			if (hornType == Horns.DRACONIC_X4_12_INCH_LONG || hornType == Horns.DRACONIC_X2)
				vouivreCounter++;
			if (wingType == Wings.DRACONIC_SMALL || wingType == Wings.DRACONIC_LARGE || wingType == Wings.DRACONIC_HUGE)
				vouivreCounter += 2;
			if (findPerk(PerkLib.DragonFireBreath) >= 0 && vouivreCounter >= 11)
				vouivreCounter++;
			if (findPerk(PerkLib.DragonIceBreath) >= 0 && vouivreCounter >= 11)
				vouivreCounter++;
			if (findPerk(PerkLib.DragonLightningBreath) >= 0 && vouivreCounter >= 11)
				vouivreCounter++;
			if (findPerk(PerkLib.DragonDarknessBreath) >= 0 && vouivreCounter >= 11)
				vouivreCounter++;
			if (findPerk(PerkLib.DraconicLungs) >= 0)
				vouivreCounter++;
			if (findPerk(PerkLib.DraconicLungsEvolved) >= 0)
				vouivreCounter++;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && vouivreCounter >= 7)
				vouivreCounter += 1;

			End("Player","racialScore");
			return vouivreCounter;
		}
		//Couatl score
		public function couatlScore():Number {
			Begin("Player","racialScore","couatl");
			var couatlCounter:Number = 0;
			if (isNaga())
				couatlCounter += 2;
			if (tongueType == Tongue.SNAKE)
				couatlCounter++;
			if (faceType == Face.SNAKE_FANGS)
				couatlCounter++;
			if (armType == Arms.HARPY)
				couatlCounter++;
			if (hasCoatOfType(Skin.SCALES))
				couatlCounter++;
			if (earType == Ears.SNAKE)
				couatlCounter++;
			if (eyeType == Eyes.SNAKE)
				couatlCounter++;
			if (hairType == Hair.FEATHER)
				couatlCounter++;
			if (wingType == Wings.FEATHERED_LARGE)
				couatlCounter += 2;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && couatlCounter >= 7)
				couatlCounter += 1;

			End("Player","racialScore");
			return couatlCounter;
		}

		//Bunny score
		public function bunnyScore():Number {
			Begin("Player","racialScore","bunny");
			var bunnyCounter:Number = 0;
			if (faceType == Face.BUNNY)
				bunnyCounter++;
			if (tailType == Tail.RABBIT)
				bunnyCounter++;
			if (earType == Ears.BUNNY)
				bunnyCounter++;
			if (lowerBody == LowerBody.BUNNY)
				bunnyCounter++;
			//More than 2 balls reduces bunny score
			if (balls > 2 && bunnyCounter > 0)
				bunnyCounter--;
			//Human skin on bunmorph adds
			if (hasPlainSkin() && bunnyCounter > 1 && skinTone != "slippery")
				bunnyCounter++;
			//No wings and antennae a plus
			if (bunnyCounter > 0 && antennae == 0)
				bunnyCounter++;
			if (bunnyCounter > 0 && wingType == Wings.NONE)
				bunnyCounter++;
			if (findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0)
				bunnyCounter += 10;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && bunnyCounter >= 3)
				bunnyCounter += 1;
			
			End("Player","racialScore");
			return bunnyCounter;
		}

		//Harpy score
		public function harpyScore():Number {
			Begin("Player","racialScore","harpy");
			var harpy:Number = 0;
			if (armType == Arms.HARPY)
				harpy++;
			if (hairType == Hair.FEATHER)
				harpy++;
			if (wingType == Wings.FEATHERED_LARGE)
				harpy += 2;
			if (tailType == Tail.HARPY)
				harpy++;
			if (tailType == Tail.SHARK || tailType == Tail.SALAMANDER)
				harpy -= 5;
			if (lowerBody == LowerBody.HARPY)
				harpy++;
			if (lowerBody == LowerBody.SALAMANDER)
				harpy--;
			if (harpy >= 2 && faceType == Face.HUMAN)
				harpy++;
			if (faceType == Face.SHARK_TEETH)
				harpy--;
			if (harpy >= 2 && (earType == Ears.HUMAN || earType == Ears.ELFIN))
				harpy++;
			if (findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0)
				harpy += 10;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && harpy >= 3)
				harpy += 1;
			
			End("Player","racialScore");
			return harpy;
		}

		//Kanga score
		public function kangaScore():Number {
			Begin("Player","racialScore","kanga");
			var kanga:Number = 0;
			if (kangaCocks() > 0)
				kanga++;
			if (earType == Ears.KANGAROO)
				kanga++;
			if (tailType == Tail.KANGAROO)
				kanga++;
			if (lowerBody == LowerBody.KANGAROO)
				kanga++;
			if (faceType == Face.KANGAROO)
				kanga++;
			if (kanga >= 2 && hasFur())
				kanga++;
			
			End("Player","racialScore");
			return kanga;
		}

		//shark score
		public function sharkScore():Number {
			Begin("Player","racialScore","shark");
			var sharkCounter:Number = 0;
			if (faceType == Face.SHARK_TEETH)
				sharkCounter++;
			if (gillType == Gills.FISH)
				sharkCounter++;
			if (rearBody == RearBody.SHARK_FIN)
				sharkCounter++;
			if (wingType == Wings.SHARK_FIN)
				sharkCounter -= 7;
			if (armType == Arms.SHARK)
				sharkCounter++;
			if (lowerBody == LowerBody.SHARK)
				sharkCounter++;
			if (tailType == Tail.SHARK)
				sharkCounter++;
			if (hairType == Hair.NORMAL && hairColor == "silver")
				sharkCounter++;
			if (hasScales() && InCollection(skin.coat.color, "rough gray","orange and black"))
				sharkCounter++;
			if (eyeType == Eyes.HUMAN && hairType == Hair.NORMAL && hairColor == "silver" && hasScales() && InCollection(skin.coat.color, "rough gray","orange and black"))
				sharkCounter++;
			if (vaginas.length > 0 && cocks.length > 0)
				sharkCounter++;
			if (findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0)
				sharkCounter += 10;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && sharkCounter >= 3)
				sharkCounter += 1;
			
			End("Player","racialScore");
			return sharkCounter;
		}

		//Orca score
		public function orcaScore():Number {
			Begin("Player","racialScore","orca");
			var orcaCounter:Number = 0;
			if (earType == Ears.ORCA)
				orcaCounter++;
			if (tailType == Tail.ORCA)
				orcaCounter++;
			if (faceType == Face.ORCA)
				orcaCounter++;
			if (lowerBody == LowerBody.ORCA)
				orcaCounter++;
			if (armType == Arms.ORCA)
				orcaCounter++;
			if (rearBody == RearBody.ORCA_BLOWHOLE)
				orcaCounter++;
			if (hasPlainSkinOnly() && skinAdj == "glossy")
				orcaCounter++;
			if (skin.base.pattern == Skin.PATTERN_ORCA_UNDERBODY)
				orcaCounter++;
			if (wingType == Wings.NONE)
				orcaCounter += 2;
			if (eyeType == Eyes.HUMAN)
				orcaCounter++;
			if (tallness >= 84)
				orcaCounter++;
			if (findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0)
				orcaCounter += 10;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && orcaCounter >= 3)
				orcaCounter += 1;
			
			End("Player","racialScore");
			return orcaCounter;
		}

		//Oni score
		public function oniScore():Number {
			Begin("Player","racialScore","oni");
			var oniCounter:Number = 0;
			if (earType == Ears.ONI)
				oniCounter++;
			if (faceType == Face.ONI_TEETH)
				oniCounter++;
			if (hornType == Horns.ONI)
				oniCounter++;
			if (armType == Arms.ONI)
				oniCounter++;
			if (lowerBody == LowerBody.ONI)
				oniCounter++;
			if (eyeType == Eyes.ONI && InCollection(eyeColor,Mutations.oniEyeColors))
				oniCounter++;
			if (skinTone == "red" || skinTone == "reddish orange" || skinTone == "purple" || skinTone == "blue")
				oniCounter++;
			if (skin.base.pattern == Skin.PATTERN_BATTLE_TATTOO)
				oniCounter++;
			if (tailType == Tail.NONE)
				oniCounter++;
			if (tone >= 75)
				oniCounter++;
			if ((hasVagina() && biggestTitSize() >= 19) || (cocks.length > 18))
				oniCounter++;
			if (tallness >= 120)
				oniCounter++;
			if (findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0)
				oniCounter += 10;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && oniCounter >= 3)
				oniCounter += 1;
			
			End("Player","racialScore");
			return oniCounter;
		}
		
		//Elf score
		public function elfScore():Number {
			Begin("Player","racialScore","elf");
			var elfCounter:Number = 0;
			if (earType == Ears.ELVEN)
				elfCounter++;
			if (eyeType == Eyes.ELF)
				elfCounter++;
			if (tongueType == Tongue.ELF)
				elfCounter++;
			if (armType == Arms.ELF)
				elfCounter++;
			if (lowerBody == LowerBody.ELF)
				elfCounter++;
			if (hairType == Hair.SILKEN)
				elfCounter++;
			if (hairColor == "black" || hairColor == "leaf green" || hairColor == "golden blonde" || hairColor == "silver")
				elfCounter++;
			if (skinTone == "dark" || skinTone == "light" || skinTone == "tan")
				elfCounter++;
			if (skinType == Skin.PLAIN && skinAdj == "flawless")
				elfCounter += 2;//elfCounter++;
			if (cocks.length < 6)
				elfCounter++;
			if (hasVagina() && biggestTitSize() >= 3)
				elfCounter++;
			if (findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0)
				elfCounter += 10;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && elfCounter >= 3)
				elfCounter += 1;
			
			End("Player","racialScore");
			return elfCounter;
		}

		//Elf score
		public function raijuScore():Number {
			Begin("Player","racialScore","raiju");
			var raijuCounter:Number = 0;
			if (earType == Ears.WEASEL)
				raijuCounter++;
			if (eyeType == Eyes.RAIJU)
				raijuCounter++;
			if (faceType == Face.RAIJU_FANGS)
				raijuCounter++;
			if (armType == Arms.RAIJU)
				raijuCounter++;
			if (lowerBody == LowerBody.RAIJU)
				raijuCounter++;
			if (tailType == Tail.RAIJU)
				raijuCounter++;
			if (rearBody == RearBody.RAIJU_MANE)
				raijuCounter++;
			if (skin.base.pattern == Skin.PATTERN_LIGHTNING_SHAPED_TATTOO)
				raijuCounter++;
			if (hairType == Hair.STORM)
				raijuCounter++;
			if (hairColor == "purple" || hairColor == "light blue" || hairColor == "yellow" || hairColor == "white")
				raijuCounter++;
			if (findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0)
				raijuCounter += 10;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && raijuCounter >= 3)
				raijuCounter += 1;
			
			End("Player","racialScore");
			return raijuCounter;
		}

		//Determine Mutant Rating
		public function mutantScore():Number{
			Begin("Player","racialScore","mutant");
			var mutantCounter:Number = 0;
			if (faceType != Face.HUMAN)
				mutantCounter++;
			if (!hasPlainSkinOnly())
				mutantCounter++;
			if (tailType != Tail.NONE)
				mutantCounter++;
			if (cockTotal() > 1)
				mutantCounter++;
			if (hasCock() && hasVagina())
				mutantCounter++;
			if (hasFuckableNipples())
				mutantCounter++;
			if (breastRows.length > 1)
				mutantCounter++;
			if (faceType == Face.HORSE)
			{
				if (hasFur())
					mutantCounter--;
				if (tailType == Tail.HORSE)
					mutantCounter--;
			}
			if (faceType == Face.DOG)
			{
				if (hasFur())
					mutantCounter--;
				if (tailType == Tail.DOG)
					mutantCounter--;
			}
			End("Player","racialScore");
			return mutantCounter;
		}
		
		//scorpion score
		public function scorpionScore():Number {
			Begin("Player","racialScore","scorpion");
			var scorpionCounter:Number = 0;
			if (hasCoatOfType(Skin.CHITIN))
				scorpionCounter++;
			if (tailType == Tail.SCORPION)
				scorpionCounter++;
			if (scorpionCounter > 0 && findPerk(PerkLib.TrachealSystem) >= 0)
				scorpionCounter++;
			if (scorpionCounter > 4 && findPerk(PerkLib.TrachealSystemEvolved) >= 0)
				scorpionCounter++;
			if (scorpionCounter > 8 && findPerk(PerkLib.TrachealSystemFinalForm) >= 0)
				scorpionCounter++;
			
			End("Player","racialScore");
			return scorpionCounter;
		}
		
		//Mantis score
		public function mantisScore():Number {
			Begin("Player","racialScore","mantis");
			var mantisCounter:Number = 0;
			if (hasCoatOfType(Skin.CHITIN))
				mantisCounter++;
			if (antennae == Antennae.MANTIS)
			{
				mantisCounter++;
				if (faceType == Face.HUMAN)
					mantisCounter++;
			}
			if (armType == Arms.MANTIS)
				mantisCounter++;
			if (lowerBody == LowerBody.MANTIS)
				mantisCounter++;
			if (tailType == Tail.MANTIS_ABDOMEN)
				mantisCounter++;
			if (wingType == Wings.MANTIS_LIKE_SMALL)
				mantisCounter++;
			if (wingType == Wings.MANTIS_LIKE_LARGE)
				mantisCounter += 2;
			if (wingType == Wings.MANTIS_LIKE_LARGE_2)
				mantisCounter += 4;
			if (mantisCounter > 0 && findPerk(PerkLib.TrachealSystem) >= 0)
				mantisCounter++;
			if (mantisCounter > 4 && findPerk(PerkLib.TrachealSystemEvolved) >= 0)
				mantisCounter++;
			if (mantisCounter > 8 && findPerk(PerkLib.TrachealSystemFinalForm) >= 0)
				mantisCounter++;
			if (findPerk(PerkLib.MantislikeAgility) >= 0)
				mantisCounter++;
			if (findPerk(PerkLib.MantislikeAgilityEvolved) >= 0)
				mantisCounter++;
			if (findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0)
				mantisCounter += 10;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && mantisCounter >= 3)
				mantisCounter += 1;
			if (findPerk(PerkLib.MantislikeAgility) >= 0 && findPerk(PerkLib.ChimericalBodyAdvancedStage) >= 0)
				mantisCounter++;
			End("Player","racialScore");
			return mantisCounter;
		}
		
		//Thunder Mantis score
		//4 eyes - adj spider 4 eyes desc
		//var. of arms, legs, wings, tail, ears
		
		//Salamander score
		public function salamanderScore():Number {
			Begin("Player","racialScore","salamander");
			var salamanderCounter:Number = 0;
			if (hasPartialCoat(Skin.SCALES))
				salamanderCounter++;
			if (faceType == Face.SALAMANDER_FANGS)
				salamanderCounter++;
			if (earType == Ears.HUMAN && faceType == Face.SALAMANDER_FANGS)
				salamanderCounter++;
			if (eyeType == Eyes.REPTILIAN)
				salamanderCounter++;
			if (armType == Arms.SALAMANDER)
				salamanderCounter++;
			if (lowerBody == LowerBody.SALAMANDER)
				salamanderCounter++;
			if (tailType == Tail.SALAMANDER)
				salamanderCounter++;
			if (lizardCocks() > 0)
				salamanderCounter++;
			if (findPerk(PerkLib.Lustzerker) >= 0)
				salamanderCounter++;
			if (findPerk(PerkLib.SalamanderAdrenalGlands) >= 0)
				salamanderCounter++;
			if (findPerk(PerkLib.SalamanderAdrenalGlandsEvolved) >= 0)
				salamanderCounter++;
			if (findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0)
				salamanderCounter += 10;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && salamanderCounter >= 4)
				salamanderCounter += 1;
			if (findPerk(PerkLib.SalamanderAdrenalGlands) >= 0 && findPerk(PerkLib.ChimericalBodyAdvancedStage) >= 0)
				salamanderCounter++;
			
			End("Player","racialScore");
			return salamanderCounter;
		}
		
		//Yeti score
		public function yetiScore():Number {
			Begin("Player","racialScore","yeti");
			var yetiCounter:Number = 0;
			if (skinTone == "dark")
				yetiCounter++;
			if (eyeType == Eyes.HUMAN)
				yetiCounter++;
			if (lowerBody == LowerBody.YETI)
				yetiCounter++;
			if (armType == Arms.YETI)
				yetiCounter++;
			if (earType == Ears.YETI)
				yetiCounter++;
			if (faceType == Face.YETI_FANGS)
				yetiCounter++;
			if (hairType == Hair.FLUFFY)
				yetiCounter++;
			if (hairColor == "white")
				yetiCounter++;
			if (hasPartialCoat(Skin.FUR))
				yetiCounter++;
			if (hasFur() && coatColor == "white")
				yetiCounter++;
			if (tallness >= 78)
				yetiCounter++;
			if (buttRating >= 10)
				yetiCounter++;
			
			End("Player","racialScore");
			return yetiCounter;
		}

		//Centaur score
		public function centaurScore():Number
		{
			if (hornType == Horns.UNICORN)
				return 0;
			Begin("Player","racialScore","centaur");
			var centaurCounter:Number = 0;
			if (isTaur())
				centaurCounter += 2;
			if (lowerBody == LowerBody.HOOFED || lowerBody == LowerBody.CLOVEN_HOOFED)
				centaurCounter++;
			if (tailType == Tail.HORSE)
				centaurCounter++;
			if (hasPlainSkinOnly())
				centaurCounter++;
			if (armType == Arms.HUMAN)
				centaurCounter++;
			if (earType == Ears.HUMAN || earType == Ears.HUMAN)
				centaurCounter++;
			if (faceType == Face.HUMAN)
				centaurCounter++;
			if (horseCocks() > 0)
				centaurCounter++;
			if (hasVagina() && vaginaType() == VaginaClass.EQUINE)
				centaurCounter++;
			if (wingType != Wings.NONE)
				centaurCounter -= 3;
			if (findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0)
				centaurCounter += 10;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && centaurCounter >= 3)
				centaurCounter += 1;
			End("Player","racialScore");
			return centaurCounter;
		}

		//Determine Unicorn Rating
		public function unicornScore():Number {
			if (hornType != Horns.UNICORN)
				return 0;
			if (wingType == Wings.FEATHERED_ALICORN)
				return 0;
			Begin("Player","racialScore","unicorn");
			var unicornCounter:Number = 0;
			if (faceType == Face.HORSE)
				unicornCounter += 2;
			if (faceType == Face.HUMAN)
				unicornCounter++;
			if (earType == Ears.HORSE)
				unicornCounter++;
			if (tailType == Tail.HORSE)
				unicornCounter++;
			if (lowerBody == LowerBody.HOOFED)
				unicornCounter++;
			if (legCount == 4)
				unicornCounter++;
			if (eyeColor == "red" || eyeColor == "blue")
				unicornCounter++;
			if (hornType == Horns.UNICORN && horns < 6)
				unicornCounter++;
			if (hornType == Horns.UNICORN && horns >= 6)
				unicornCounter += 2;
			if (hasFur() || hasPlainSkinOnly())
				unicornCounter++;
			if (hairColor == "white")
				unicornCounter++;
			if (findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0)
				unicornCounter += 10;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && unicornCounter >= 3)
				unicornCounter += 1;
			End("Player","racialScore");
			return unicornCounter;
		}
		
		//Determine Alicorn Rating
		public function alicornScore():Number {
			if (hornType != Horns.UNICORN)
				return 0;
			if (wingType != Wings.FEATHERED_ALICORN)
				return 0;
			Begin("Player","racialScore","alicorn");
			var alicornCounter:Number = 0;
			if (faceType == Face.HORSE)
				alicornCounter += 2;
			if (faceType == Face.HUMAN)
				alicornCounter++;
			if (earType == Ears.HORSE)
				alicornCounter++;
			if (tailType == Tail.HORSE)
				alicornCounter++;
			if (lowerBody == LowerBody.HOOFED)
				alicornCounter++;
			if (legCount == 4)
				alicornCounter++;
			if (eyeColor == "red" || eyeColor == "blue")
				alicornCounter++;
			if (wingType == Wings.FEATHERED_ALICORN)
				alicornCounter += 2;
			if (hornType == Horns.UNICORN && horns < 6)
				alicornCounter++;
			if (hornType == Horns.UNICORN && horns >= 6)
				alicornCounter += 2;
			if (hasFur() || hasPlainSkinOnly())
				alicornCounter++;
			if (hairColor == "white")
				alicornCounter++;
			if (findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0)
				alicornCounter += 10;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && alicornCounter >= 3)
				alicornCounter += 1;
			
			End("Player","racialScore");
			return alicornCounter;
		}
		
		//Determine Phoenix Rating
		public function phoenixScore():Number {
			Begin("Player","racialScore","phoenix");
			var phoenixCounter:Number = 0;
			if (hairType == Hair.FEATHER) {
				if (hairType == Hair.FEATHER)
					phoenixCounter++;
				if (faceType == Face.HUMAN && phoenixCounter > 2)
					phoenixCounter++;
				if (earType == Ears.HUMAN && phoenixCounter > 2)
					phoenixCounter++;
			}
			if (eyeType == Eyes.REPTILIAN)
				phoenixCounter++;
			if (wingType == Wings.FEATHERED_PHOENIX)
				phoenixCounter++;
			if (armType == Arms.PHOENIX)
				phoenixCounter++;
			if (lowerBody == LowerBody.SALAMANDER)
				phoenixCounter++;
			if (tailType == Tail.SALAMANDER)
				phoenixCounter++;
			if (hasPartialCoat(Skin.SCALES))
				phoenixCounter++;
			if (lizardCocks() > 0)
				phoenixCounter++;
			if (findPerk(PerkLib.PhoenixFireBreath) >= 0)
				phoenixCounter++;
			if (findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0)
				phoenixCounter += 10;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && phoenixCounter >= 3)
				phoenixCounter += 1;
			End("Player","racialScore");
			return phoenixCounter;
		}
		
		//Scylla score
		public function scyllaScore():Number {
			Begin("Player","racialScore","scylla");
			var scyllaCounter:Number = 0;
			if (faceType == Face.HUMAN)
				scyllaCounter++;
			if (faceType != 0)
				scyllaCounter--;
			if (earType == Ears.ELFIN)
				scyllaCounter++;
			if (hasPlainSkinOnly() && skinAdj == "slippery")
				scyllaCounter++;
		//	if (hasPlainSkinOnly() && skinAdj == "rubberlike slippery")
		//		scyllaCounter += 2;
			if (isScylla())
				scyllaCounter += 2;
			if (tallness > 96)
				scyllaCounter++;
			if (findPerk(PerkLib.InkSpray) >= 0)
				scyllaCounter++;
			if (findPerk(PerkLib.ScyllaInkGlands) >= 0)
				scyllaCounter++;
			if (findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0)
				scyllaCounter += 10;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && scyllaCounter >= 4)
				scyllaCounter += 1;
			if (findPerk(PerkLib.ScyllaInkGlands) >= 0 && findPerk(PerkLib.ChimericalBodyAdvancedStage) >= 0)
				scyllaCounter++;
			
			End("Player","racialScore");
			return scyllaCounter;
		}//potem tentacle dick lub scylla vag też bedą sie liczyć do wyniku)
		
		//Determine Kitshoo Rating
		public function kitshooScore():Number {
			Begin("Player","racialScore","kitshoo");
			var kitshooCounter:int = 0;
			//If the character has fox ears, +1
			if (earType == Ears.FOX)
				kitshooCounter++;
			//If the character has a fox tail, +1
		//	if (tailType == FOX)
		//		kitshooCounter++;
			//If the character has two to eight fox tails, +2
		//	if (tailType == FOX && tailCount >= 2 && tailCount < 9)
		//		kitshooCounter += 2;
			//If the character has nine fox tails, +3
		//	if (tailType == FOX && tailCount == 9)
		//		kitshooCounter += 3;
			//If the character has tattooed skin, +1
			//9999
			//If the character has a 'vag of holding', +1
		//	if (vaginalCapacity() >= 8000)
		//		kitshooCounter++;
			//If the character's kitshoo score is greater than 0 and:
			//If the character has a normal face, +1
			if (kitshooCounter > 0 && (faceType == Face.HUMAN || faceType == Face.FOX))
				kitshooCounter++;
			//If the character's kitshoo score is greater than 1 and:
			//If the character has "blonde","black","red","white", or "silver" hair, +1
			if (kitshooCounter > 0 && hasFur() && (InCollection(coatColor, KitsuneScene.basicKitsuneHair) || InCollection(coatColor, KitsuneScene.elderKitsuneColors)))
				kitshooCounter++;
			//If the character's femininity is 40 or higher, +1
		//	if (kitshooCounter > 0 && femininity >= 40)
		//		kitshooCounter++;
			//If the character has fur, chitin, or gooey skin, -1
		//	if (skinType == FUR && !InCollection(furColor, KitsuneScene.basicKitsuneFur) && !InCollection(furColor, KitsuneScene.elderKitsuneColors))
		//		kitshooCounter--;
		//	if (skinType == SCALES)
		//		kitshooCounter -= 2; - czy bedzie pozytywny do wyniku czy tez nie?
			if (hasCoatOfType(Skin.CHITIN))
				kitshooCounter -= 2;
			if (hasGooSkin())
				kitshooCounter -= 3;
			//If the character has abnormal legs, -1
		//	if (lowerBody != HUMAN && lowerBody != FOX)
		//		kitshooCounter--;
			//If the character has a nonhuman face, -1
		//	if (faceType != HUMAN && faceType != FOX)
		//		kitshooCounter--;
			//If the character has ears other than fox ears, -1
		//	if (earType != FOX)
		//		kitshooCounter--;
			//If the character has tail(s) other than fox tails, -1
		//	if (tailType != FOX)
		//		kitshooCounter--;
			//When character get one of 9-tail perk
		//	if (kitshooCounter >= 3 && (findPerk(PerkLib.EnlightenedNinetails) >= 0 || findPerk(PerkLib.CorruptedNinetails) >= 0))
		//		kitshooCounter += 2;
			//When character get Hoshi no tama
		//	if (findPerk(PerkLib.KitsuneThyroidGland) >= 0)
		//		kitshooCounter++;
		//	if (findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0)
		//		kitshooCounter += 10;
			
			End("Player","racialScore");
			return kitshooCounter;
		}
		
		//plant score
		public function plantScore():Number {
			Begin("Player","racialScore","plant");
			var plantCounter:Number = 0;
			if (faceType == Face.HUMAN)
				plantCounter++;
			if (faceType == Face.PLANT_DRAGON)
				plantCounter--;
			if (hornType == Horns.OAK || hornType == Horns.ORCHID)
				plantCounter++;
			if (earType == Ears.ELFIN)
				plantCounter++;
			if (earType == Ears.LIZARD)
				plantCounter--;
			if ((hairType == Hair.LEAF || hairType == Hair.GRASS) && hairColor == "green")
				plantCounter++;
			if (hasPlainSkinOnly() && (skinTone == "leaf green" || skinTone == "lime green" || skinTone == "turquoise"))
				plantCounter++;
		//	if (skinType == 6)/zielona skóra +1, bark skin +2
		//		plantCounter += 2;
			if (armType == Arms.PLANT)
				plantCounter++;
			if (lowerBody == LowerBody.PLANT_HIGH_HEELS || lowerBody == LowerBody.PLANT_ROOT_CLAWS) {
				if (tentacleCocks() > 0) {
					plantCounter++;
				}
				plantCounter++;
			}
			if (wingType == Wings.PLANT)
				plantCounter++;
		//	if (scorpionCounter > 0 && findPerk(PerkLib.TrachealSystemEvolved) >= 0)
		//		plantCounter++;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && plantCounter >= 3)
				plantCounter += 1;
			if (alrauneScore() >= 10)
				plantCounter -= 7;
			if (yggdrasilScore() >= 10)
				plantCounter -= 4;
			End("Player","racialScore");
			return plantCounter;
		}
		
		public function alrauneScore():Number {
			Begin("Player","racialScore","alraune");
			var alrauneCounter:Number = 0;
			if (faceType == Face.HUMAN)
				alrauneCounter++;
			if (eyeType == Eyes.HUMAN)
				alrauneCounter++;
			if (earType == Ears.ELFIN)
				alrauneCounter++;
			if ((hairType == Hair.LEAF || hairType == Hair.GRASS) && hairColor == "green")
				alrauneCounter++;
			if (skinType == Skin.PLAIN && (skinTone == "leaf green" || skinTone == "lime green" || skinTone == "turquoise"))
				alrauneCounter++;
			if (armType == Arms.PLANT)
				alrauneCounter++;
			if (wingType == Wings.NONE)
				alrauneCounter++;
			if (lowerBody == LowerBody.PLANT_FLOWER)
				alrauneCounter += 2;
			if (stamenCocks() > 0)
				alrauneCounter++;
			
			End("Player","racialScore");
			return alrauneCounter;
		}
		
		public function yggdrasilScore():Number {
			Begin("Player","racialScore","yggdrasil");
			var yggdrasilCounter:Number = 0;
			if (faceType == Face.PLANT_DRAGON)
				yggdrasilCounter += 2;
			if ((hairType == Hair.ANEMONE || hairType == Hair.LEAF || hairType == Hair.GRASS) && hairColor == "green")
				yggdrasilCounter++;
			if (earType == Ears.LIZARD)
				yggdrasilCounter++;
			if (earType == Ears.ELFIN)
				yggdrasilCounter -= 2;
			if (armType == Arms.PLANT || armType == Arms.PLANT2)
				yggdrasilCounter += 2;//++ - untill claws tf added arms tf will count for both arms and claws tf
			//claws?

			if (wingType == Wings.PLANT)
				yggdrasilCounter++;
			//skin(fur(moss), scales(bark))
			if (skinType == Skin.SCALES)
				yggdrasilCounter++;
			if (tentacleCocks() > 0 || stamenCocks() > 0)
				yggdrasilCounter++;
			if (lowerBody == LowerBody.YGG_ROOT_CLAWS)
				yggdrasilCounter++;
			if (tailType == Tail.YGGDRASIL)
				yggdrasilCounter++;
			
			End("Player","racialScore");
			return yggdrasilCounter;
		}

		//Wolf/Fenrir score
		public function wolfScore():Number {
			Begin("Player","racialScore","wolf");
			var wolfCounter:Number = 0;
			if (faceType == Face.WOLF)
				wolfCounter++;
			if (eyeType == Eyes.FENRIR)
				wolfCounter++;
			if (earType == Ears.WOLF)
				wolfCounter++;
			if (armType == Arms.WOLF)
				wolfCounter++;
			if (lowerBody == LowerBody.WOLF)
				wolfCounter++;
			if (tailType == Tail.WOLF)
				wolfCounter++;
			if (hasFur())
				wolfCounter++;
			if (hairColor == "glacial white" && hasFur() && coatColor == "glacial white")
				wolfCounter++;
			if (rearBody == RearBody.FENRIR_ICE_SPIKES)
				wolfCounter++;
			if (wolfCocks() > 0 && wolfCounter > 0)
				wolfCounter++;
			if (findPerk(PerkLib.FreezingBreath) >= 0)
				wolfCounter++;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && eyeType == 5)
				wolfCounter += 1;
			
			End("Player","racialScore");
			return wolfCounter;
		}

		public function sirenScore():Number {
			Begin("Player","racialScore","siren");
			var sirenCounter:Number = 0;
			if (faceType == Face.SHARK_TEETH)
				sirenCounter++;
			if (hairType == Hair.FEATHER)
				sirenCounter++;
			if (hairColor == "silver")
				sirenCounter++;
			if (tailType == Tail.SHARK)
				sirenCounter++;
			if (wingType == Wings.FEATHERED_LARGE)
				sirenCounter += 2;
			if (armType == Arms.HARPY)
				sirenCounter++;
			if (lowerBody == LowerBody.SHARK)
				sirenCounter++;
			if (skinType == Skin.SCALES && (skinTone == "rough gray" || skinTone == "orange and black"))
				sirenCounter++;
			if (gillType == Gills.FISH)
				sirenCounter++;
			if (eyeType == Eyes.HUMAN)
				sirenCounter++;
			if (findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0)
				sirenCounter += 10;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && sirenCounter >= 3)
				sirenCounter += 1;
			End("Player","racialScore");
			return sirenCounter;
		}
		
		public function pigScore():Number {
			Begin("Player","racialScore","pig");
			var pigCounter:Number = 0;
			if (earType == Ears.PIG)
				pigCounter++;
			if (tailType == Tail.PIG)
				pigCounter++;
			if (faceType == Face.PIG || Face.BOAR)
				pigCounter++;
			if (lowerBody == LowerBody.CLOVEN_HOOFED)
				pigCounter += 2;
			if (pigCocks() > 0)
				pigCounter++;
			
			End("Player","racialScore");
			return pigCounter;
		}
		
		public function satyrScore():Number {
			Begin("Player","racialScore","satyr");
			var satyrCounter:Number = 0;
			if (lowerBody == LowerBody.HOOFED)
				satyrCounter++;
			if (tailType == Tail.GOAT)
				satyrCounter++;
			if (satyrCounter >= 2) {
				if (earType == Ears.ELFIN)
					satyrCounter++;
				if (faceType == Face.HUMAN)
					satyrCounter++;
				if (countCocksOfType(CockTypesEnum.HUMAN) > 0)
					satyrCounter++;
				if (balls > 0 && ballSize >= 3)
					satyrCounter++;
			}
			if (findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0)
				satyrCounter += 10;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && satyrCounter >= 3)
				satyrCounter += 1;
			End("Player","racialScore");
			return satyrCounter;
		}
		
		public function rhinoScore():Number {
			Begin("Player","racialScore","rhino");
			var rhinoCounter:Number = 0;
			if (earType == Ears.RHINO)
				rhinoCounter++;
			if (tailType == Tail.RHINO)
				rhinoCounter++;
			if (faceType == Face.RHINO)
				rhinoCounter++;
			if (hornType == Horns.RHINO)
				rhinoCounter++;
			if (rhinoCounter >= 2 && skinTone == "gray")
				rhinoCounter++;
			if (rhinoCounter >= 2 && hasCock() && countCocksOfType(CockTypesEnum.RHINO) > 0)
				rhinoCounter++;
			if (findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0)
				rhinoCounter += 10;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && rhinoCounter >= 3)
				rhinoCounter += 1;
			
			End("Player","racialScore");
			return rhinoCounter;
		}
		
		public function echidnaScore():Number {
			Begin("Player","racialScore","echidna");
			var echidnaCounter:Number = 0;
			if (earType == Ears.ECHIDNA)
				echidnaCounter++;
			if (tailType == Tail.ECHIDNA)
				echidnaCounter++;
			if (faceType == Face.ECHIDNA)
				echidnaCounter++;
			if (tongueType == Tongue.ECHIDNA)
				echidnaCounter++;
			if (lowerBody == LowerBody.ECHIDNA)
				echidnaCounter++;
			if (echidnaCounter >= 2 && skinType == Skin.FUR)
				echidnaCounter++;
			if (echidnaCounter >= 2 && countCocksOfType(CockTypesEnum.ECHIDNA) > 0)
				echidnaCounter++;
			
			End("Player","racialScore");
			return echidnaCounter;
		}
		
		public function deerScore():Number {
			Begin("Player","racialScore","deer");
			var deerCounter:Number = 0;
			if (earType == Ears.DEER)
				deerCounter++;
			if (tailType == Tail.DEER)
				deerCounter++;
			if (faceType == Face.DEER)
				deerCounter++;
			if (lowerBody == LowerBody.CLOVEN_HOOFED || lowerBody == LowerBody.DEERTAUR)
				deerCounter++;
			if (hornType == Horns.ANTLERS && horns >= 4)
				deerCounter++;
			if (deerCounter >= 2 && skinType == Skin.FUR)
				deerCounter++;
			if (deerCounter >= 3 && countCocksOfType(CockTypesEnum.HORSE) > 0)
				deerCounter++;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && deerCounter >= 3)
				deerCounter += 1;
			
			End("Player","racialScore");
			return deerCounter;
		}
		
		//Dragonne
		public function dragonneScore():Number {
			Begin("Player","racialScore","dragonne");
			var dragonneCounter:Number = 0;
			if (faceType == Face.CAT)
				dragonneCounter++;
			if (earType == Ears.CAT)
				dragonneCounter++;
			if (tailType == Tail.CAT)
				dragonneCounter++;
			if (tongueType == Tongue.DRACONIC)
				dragonneCounter++;
			if (wingType == Wings.DRACONIC_LARGE)
				dragonneCounter += 2;
			if (wingType == Wings.DRACONIC_SMALL)
				dragonneCounter++;
			if (lowerBody == LowerBody.CAT)
				dragonneCounter++;
			if (skinType == Skin.SCALES && dragonneCounter > 0)
				dragonneCounter++;
			
			End("Player","racialScore");
			return dragonneCounter;
		}
		
		//Manticore
		public function manticoreScore():Number {
			Begin("Player","racialScore","manticore");
			var manticoreCounter:Number = 0;
			if (faceType == Face.MANTICORE)
				manticoreCounter++;
			if (eyeType == Eyes.MANTICORE)
				manticoreCounter++;
			if (earType == Ears.LION)
				manticoreCounter++;
			if (tailType == Tail.MANTICORE_PUSSYTAIL)
				manticoreCounter += 2;
			if (rearBody == RearBody.LION_MANE)
				manticoreCounter++;
			if (armType == Arms.LION)
				manticoreCounter++;
			if (lowerBody == LowerBody.LION)
				manticoreCounter++;
			if (tongueType == Tongue.CAT)
				manticoreCounter++;
			if (wingType == Wings.MANTICORE_LIKE_SMALL)
				manticoreCounter++;
			if (wingType == Wings.MANTICORE_LIKE_LARGE)
				manticoreCounter += 2;
			if (!hasCock())
				manticoreCounter++;
			if (cocks.length > 0)
				manticoreCounter -= 3;
			if (findPerk(PerkLib.ManticoreMetabolism) >= 0)
				manticoreCounter++;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && manticoreCounter >= 3)
				manticoreCounter += 1;
			if (findPerk(PerkLib.ChimericalBodyAdvancedStage) >= 0 && findPerk(PerkLib.ManticoreMetabolism) >= 0)
				manticoreCounter++;
			if (findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0 && findPerk(PerkLib.ManticoreMetabolism) >= 0 && manticoreCounter >= 6)
				manticoreCounter += 1;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0 && findPerk(PerkLib.ManticoreMetabolism) >= 0 && manticoreCounter >= 7)
				manticoreCounter += 1;
			End("Player","racialScore");
			return manticoreCounter;
		}
		
		//Manticore
		public function redpandaScore():Number {
			Begin("Player","racialScore","redpanda");
			var redpandaCounter:Number = 0;
			if (faceType == Face.RED_PANDA)
				redpandaCounter += 2;
			if (earType == Ears.RED_PANDA)
				redpandaCounter++;
			if (tailType == Tail.RED_PANDA)
				redpandaCounter++;
			if (armType == Arms.RED_PANDA)
				redpandaCounter++;
			if (lowerBody == LowerBody.RED_PANDA)
				redpandaCounter++;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && redpandaCounter >= 3)
				redpandaCounter += 1;
			if (redpandaCounter >= 2 && skin.base.pattern == Skin.PATTERN_RED_PANDA_UNDERBODY)
				redpandaCounter++;
			if (redpandaCounter >= 2 && skinType == Skin.FUR)
				redpandaCounter++;
			End("Player","racialScore");
			return redpandaCounter;
		}
		
		//Gargoyle
		public function gargoyleScore():Number {
			Begin("Player","racialScore","gargoyle");
			var gargoyleCounter:Number = 0;
			if (hairColor == "light grey" || hairColor == "quartz white")
				gargoyleCounter++;
			if (skinTone == "light grey" || skinTone == "quartz white")
				gargoyleCounter++;
			if (hairType == Hair.NORMAL)
				gargoyleCounter++;
			if (skinType == Skin.STONE)
				gargoyleCounter++;
			if (hornType == Horns.GARGOYLE)
				gargoyleCounter++;
			if (eyeType == Eyes.GEMSTONES)
				gargoyleCounter++;
			if (earType == Ears.ELFIN)
				gargoyleCounter++;
			if (faceType == Face.DEVIL_FANGS)
				gargoyleCounter++;
			if (tongueType == Tongue.DEMONIC)
				gargoyleCounter++;
			if (armType == Arms.GARGOYLE || armType == Arms.GARGOYLE_2)
				gargoyleCounter++;
			if (tailType == Tail.GARGOYLE || tailType == Tail.GARGOYLE_2)
				gargoyleCounter++;
			if (lowerBody == LowerBody.GARGOYLE || lowerBody == LowerBody.GARGOYLE_2)
				gargoyleCounter++;
			if (hasPerk(PerkLib.GargoylePure) || hasPerk(PerkLib.GargoyleCorrupted))
				gargoyleCounter++;
			if (hasPerk(PerkLib.TransformationImmunity))
				gargoyleCounter += 4;
			if (wingType == Wings.GARGOYLE_LIKE_LARGE)
				gargoyleCounter += 4;
			
			End("Player","racialScore");
			return gargoyleCounter;
		}
		//Bat
		public function batScore():int{
            Begin("Player","racialScore","bat");
			var counter:int = 0;
			if(earType == Ears.BAT){ counter++;}
			else if(earType == Ears.ELFIN){ counter -= 10;}
			if(wingType == Wings.BAT_ARM) {counter += 5;}
			if(lowerBody == LowerBody.HUMAN) {counter++;}
			if(faceType == Face.VAMPIRE){counter +=2;}
			if(eyeType == Eyes.VAMPIRE){counter++;}
			if(rearBody == RearBody.BAT_COLLAR){counter++;}
            End("Player","racialScore");
			return counter < 0? 0:counter;
		}
		//Vampire
		public function vampireScore():int{
            Begin("Player","racialScore","vampire");
            var counter:int = 0;
            if(earType == Ears.BAT){ counter-=10;}
            else if(earType == Ears.VAMPIRE){ counter++;}
			if(wingType == Wings.VAMPIRE){counter += 4;}
            if(lowerBody == LowerBody.HUMAN) {counter++;}
			if(armType == Arms.HUMAN){counter++;}
            if(faceType == Face.VAMPIRE){counter +=2;}
			if(eyeType == Eyes.VAMPIRE){counter++;}
            End("Player","racialScore");
			return counter < 0? 0:counter;
		}

		//TODO: (logosK) elderSlime, succubus pussy/demonic eyes, arachne, wasp, lactabovine/slut, sleipnir, hellhound, ryu, quetzalcoatl, eredar, anihilan, 

		
		public function maxPrestigeJobs():Number
		{
			var prestigeJobs:Number = 1;
			if (findPerk(PerkLib.PrestigeJobArcaneArcher) >= 0)
				prestigeJobs--;
			if (findPerk(PerkLib.PrestigeJobBerserker) >= 0)
				prestigeJobs--;
			if (findPerk(PerkLib.PrestigeJobSeer) >= 0)
				prestigeJobs--;
			if (findPerk(PerkLib.PrestigeJobSentinel) >= 0)
				prestigeJobs--;
			if (findPerk(PerkLib.PrestigeJobSoulArcher) >= 0)
				prestigeJobs--;
			if (findPerk(PerkLib.PrestigeJobSoulArtMaster) >= 0)
				prestigeJobs--;
			if (findPerk(PerkLib.DeityJobMunchkin) >= 0)
				prestigeJobs++;
		//	if (findPerk(PerkLib.TrachealSystemEvolved) >= 0)
		//		prestigeJobs++;
		//	if (findPerk(PerkLib.TrachealSystemEvolved) >= 0)
		//		prestigeJobs++;
			return prestigeJobs;
		}

		public function lactationQ():Number
		{
			if (biggestLactation() < 1)
				return 0;
			//(Milk production TOTAL= breastSize x 10 * lactationMultiplier * breast total * milking-endurance (1- default, maxes at 2.  Builds over time as milking as done)
			//(Small – 0.01 mLs – Size 1 + 1 Multi)
			//(Large – 0.8 - Size 10 + 4 Multi)
			//(HUGE – 2.4 - Size 12 + 5 Multi + 4 tits)
			var total:Number;
			if (!hasStatusEffect(StatusEffects.LactationEndurance))
				createStatusEffect(StatusEffects.LactationEndurance, 1, 0, 0, 0);
			total = biggestTitSize() * 10 * averageLactation() * statusEffectv1(StatusEffects.LactationEndurance) * totalBreasts();
			if (findPerk(PerkLib.MilkMaid) >= 0)
				total += 200 + (perkv1(PerkLib.MilkMaid) * 100);
			if (findPerk(PerkLib.ProductivityDrugs) >= 0)
				total += (perkv4(PerkLib.ProductivityDrugs));
			if (statusEffectv1(StatusEffects.LactationReduction) >= 48)
				total = total * 1.5;
			if (total > int.MAX_VALUE)
				total = int.MAX_VALUE;
			return total;
		}
		
		public function isLactating():Boolean
		{
			return lactationQ() > 0;

		}

		public function cuntChange(cArea:Number, display:Boolean, spacingsF:Boolean = false, spacingsB:Boolean = true):Boolean {
			if (vaginas.length==0) return false;
			var wasVirgin:Boolean = vaginas[0].virgin;
			var stretched:Boolean = cuntChangeNoDisplay(cArea);
			var devirgined:Boolean = wasVirgin && !vaginas[0].virgin;
			if (devirgined){
				if(spacingsF) outputText("  ");
				outputText("<b>Your hymen is torn, robbing you of your virginity.</b>");
				if(spacingsB) outputText("  ");
			}
			//STRETCH SUCCESSFUL - begin flavor text if outputting it!
			if(display && stretched) {
				//Virgins get different formatting
				if(devirgined) {
					//If no spaces after virgin loss
					if(!spacingsB) outputText("  ");
				}
				//Non virgins as usual
				else if(spacingsF) outputText("  ");
				if(vaginas[0].vaginalLooseness == VaginaClass.LOOSENESS_LEVEL_CLOWN_CAR) outputText("<b>Your " + Appearance.vaginaDescript(this,0)+ " is stretched painfully wide, large enough to accommodate most beasts and demons.</b>");
				if(vaginas[0].vaginalLooseness == VaginaClass.LOOSENESS_GAPING_WIDE) outputText("<b>Your " + Appearance.vaginaDescript(this,0) + " is stretched so wide that it gapes continually.</b>");
				if(vaginas[0].vaginalLooseness == VaginaClass.LOOSENESS_GAPING) outputText("<b>Your " + Appearance.vaginaDescript(this,0) + " painfully stretches, the lips now wide enough to gape slightly.</b>");
				if(vaginas[0].vaginalLooseness == VaginaClass.LOOSENESS_LOOSE) outputText("<b>Your " + Appearance.vaginaDescript(this,0) + " is now very loose.</b>");
				if(vaginas[0].vaginalLooseness == VaginaClass.LOOSENESS_NORMAL) outputText("<b>Your " + Appearance.vaginaDescript(this,0) + " is now a little loose.</b>");
				if(vaginas[0].vaginalLooseness == VaginaClass.LOOSENESS_TIGHT) outputText("<b>Your " + Appearance.vaginaDescript(this,0) + " is stretched out to a more normal size.</b>");
				if(spacingsB) outputText("  ");
			}
			return stretched;
		}

		public function buttChange(cArea:Number, display:Boolean, spacingsF:Boolean = true, spacingsB:Boolean = true):Boolean
		{
			var stretched:Boolean = buttChangeNoDisplay(cArea);
			//STRETCH SUCCESSFUL - begin flavor text if outputting it!
			if(stretched && display) {
				if (spacingsF) outputText("  ");
				buttChangeDisplay();
				if (spacingsB) outputText("  ");
			}
			return stretched;
		}

		/**
		 * Refills player's hunger. 'amnt' is how much to refill, 'nl' determines if new line should be added before the notification.
		 * @param	amnt
		 * @param	nl
		 */
		public function refillHunger(amnt:Number = 0, nl:Boolean = true):void {
			if ((flags[kFLAGS.HUNGER_ENABLED] > 0 || flags[kFLAGS.IN_PRISON] > 0) && !isGargoyle())
			{
				
				var oldHunger:Number = hunger;
				var weightChange:int = 0;
				
				hunger += amnt;
				if (hunger > maxHunger())
				{
					while (hunger > (maxHunger() + 10) && !SceneLib.prison.inPrison) {
						weightChange++;
						hunger -= 10;
					}
					modThickness(100, weightChange);
					hunger = maxHunger();
				}
				if (hunger > oldHunger && flags[kFLAGS.USE_OLD_INTERFACE] == 0) CoC.instance.mainView.statsView.showStatUp('hunger');
				//game.dynStats("lus", 0, "scale", false);
				if (nl) outputText("\n");
				//Messages
				if (hunger < maxHunger() * 0.1) outputText("<b>You still need to eat more. </b>");
				else if (hunger >= maxHunger() * 0.1 && hunger < maxHunger() * 0.25) outputText("<b>You are no longer starving but you still need to eat more. </b>");
				else if (hunger >= maxHunger() * 0.25 && hunger < maxHunger() * 0.5) outputText("<b>The growling sound in your stomach seems to quiet down. </b>");
				else if (hunger >= maxHunger() * 0.5 && hunger < maxHunger() * 0.75) outputText("<b>Your stomach no longer growls. </b>");
				else if (hunger >= maxHunger() * 0.75 && hunger < maxHunger() * 0.9) outputText("<b>You feel so satisfied. </b>");
				else if (hunger >= maxHunger() * 0.9) outputText("<b>Your stomach feels so full. </b>");
				if (weightChange > 0) outputText("<b>You feel like you've put on some weight. </b>");
				EngineCore.awardAchievement("Tastes Like Chicken ", kACHIEVEMENTS.REALISTIC_TASTES_LIKE_CHICKEN);
				if (oldHunger < 1 && hunger >= 100) EngineCore.awardAchievement("Champion Needs Food Badly ", kACHIEVEMENTS.REALISTIC_CHAMPION_NEEDS_FOOD);
				if (oldHunger >= 90) EngineCore.awardAchievement("Glutton ", kACHIEVEMENTS.REALISTIC_GLUTTON);
				if (hunger > oldHunger) CoC.instance.mainView.statsView.showStatUp("hunger");
				dynStats("lus", 0, "scale", false);
				EngineCore.statScreenRefresh();
			}
		}
		public function refillGargoyleHunger(amnt:Number = 0, nl:Boolean = true):void {
			var oldHunger:Number = hunger;
			hunger += amnt;
			if (hunger > maxHunger()) hunger = maxHunger();
			if (hunger > oldHunger && flags[kFLAGS.USE_OLD_INTERFACE] == 0) CoC.instance.mainView.statsView.showStatUp('hunger');
			//game.dynStats("lus", 0, "scale", false);
			if (nl) outputText("\n");
			if (hunger > oldHunger) CoC.instance.mainView.statsView.showStatUp("hunger");
			dynStats("lus", 0, "scale", false);
			EngineCore.statScreenRefresh();
		}
		
		/**
		 * Damages player's hunger. 'amnt' is how much to deduct.
		 * @param	amnt
		 */
		public function damageHunger(amnt:Number = 0):void {
			var oldHunger:Number = hunger;
			hunger -= amnt;
			if (hunger < 0) hunger = 0;
			if (hunger < oldHunger && flags[kFLAGS.USE_OLD_INTERFACE] == 0) CoC.instance.mainView.statsView.showStatDown('hunger');
			dynStats("lus", 0, "scale", false);
		}
		
		public function corruptionTolerance():int {
			var temp:int = perkv1(PerkLib.AscensionTolerance) * 5;
			if (flags[kFLAGS.MEANINGLESS_CORRUPTION] > 0) temp += 100;
			return temp;
		}
		
		public function newGamePlusMod():int {
			var temp:int = flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			//Constrains value between 0 and 5.
			if (temp < 0) temp = 0;
			if (temp > 5) temp = 5;
			return temp;
		}
		
		public function buttChangeDisplay():void
		{	//Allows the test for stretching and the text output to be separated
			if (ass.analLooseness == 5) outputText("<b>Your " + Appearance.assholeDescript(this) + " is stretched even wider, capable of taking even the largest of demons and beasts.</b>");
			if (ass.analLooseness == 4) outputText("<b>Your " + Appearance.assholeDescript(this) + " becomes so stretched that it gapes continually.</b>");
			if (ass.analLooseness == 3) outputText("<b>Your " + Appearance.assholeDescript(this) + " is now very loose.</b>");
			if (ass.analLooseness == 2) outputText("<b>Your " + Appearance.assholeDescript(this) + " is now a little loose.</b>");
			if (ass.analLooseness == 1) outputText("<b>You have lost your anal virginity.</b>");
		}

		public function slimeFeed():void{
			if (hasStatusEffect(StatusEffects.SlimeCraving)) {
				//Reset craving value
				changeStatusValue(StatusEffects.SlimeCraving,1,0);
				//Flag to display feed update and restore stats in event parser
				if(!hasStatusEffect(StatusEffects.SlimeCravingFeed)) {
					createStatusEffect(StatusEffects.SlimeCravingFeed,0,0,0,0);
				}
			}
			if (findPerk(PerkLib.Diapause) >= 0) {
				flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00228] += 3 + rand(3);
				flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00229] = 1;
			}
			if (isGargoyle() && hasPerk(PerkLib.GargoyleCorrupted)) refillGargoyleHunger(30);
		}

		public function minoCumAddiction(raw:Number = 10):void {
			//Increment minotaur cum intake count
			flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00340]++;
			//Fix if variables go out of range.
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] < 0) flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] = 0;
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] < 0) flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] = 0;
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] > 120) flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] = 120;

			//Turn off withdrawal
			//if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] > 1) flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] = 1;
			//Reset counter
			flags[kFLAGS.TIME_SINCE_LAST_CONSUMED_MINOTAUR_CUM] = 0;
			//If highly addicted, rises slower
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] >= 60) raw /= 2;
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] >= 80) raw /= 2;
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] >= 90) raw /= 2;
			if(findPerk(PerkLib.MinotaurCumResistance) >= 0 || findPerk(PerkLib.ManticoreCumAddict) >= 0) raw *= 0;
			//If in withdrawl, readdiction is potent!
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] == 3) raw += 10;
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] == 2) raw += 5;
			raw = Math.round(raw * 100)/100;
			//PUT SOME CAPS ON DAT' SHIT
			if(raw > 50) raw = 50;
			if(raw < -50) raw = -50;
			if(findPerk(PerkLib.ManticoreCumAddict) < 0) flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] += raw;
			//Recheck to make sure shit didn't break
			if(findPerk(PerkLib.MinotaurCumResistance) >= 0) flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] = 0; //Never get addicted!
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] > 120) flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] = 120;
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] < 0) flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] = 0;

		}

		public function hasSpells():Boolean
		{
			return spellCount()>0;
		}

		public function spellCount():Number
		{
			return [StatusEffects.KnowsArouse,StatusEffects.KnowsHeal,StatusEffects.KnowsMight,StatusEffects.KnowsCharge,StatusEffects.KnowsBlind,StatusEffects.KnowsWhitefire,StatusEffects.KnowsChargeA,StatusEffects.KnowsBlink,StatusEffects.KnowsBlizzard,StatusEffects.KnowsIceSpike,StatusEffects.KnowsLightningBolt,StatusEffects.KnowsDarknessShard,StatusEffects.KnowsFireStorm,StatusEffects.KnowsIceRain]
					.filter(function(item:StatusEffectType, index:int, array:Array):Boolean{
						return this.hasStatusEffect(item);},this)
					.length;
		}

		public function armorDescript(nakedText:String = "gear"):String
		{
			var textArray:Array = [];
			var text:String = "";
			//if (armor != ArmorLib.NOTHING) text += armorName;
			//Join text.
			if (armor != ArmorLib.NOTHING) textArray.push(armor.name);
			if (upperGarment != UndergarmentLib.NOTHING) textArray.push(upperGarmentName);
			if (lowerGarment != UndergarmentLib.NOTHING) textArray.push(lowerGarmentName);
			if (textArray.length > 0) text = formatStringArray(textArray);
			//Naked?
			if (upperGarment == UndergarmentLib.NOTHING && lowerGarment == UndergarmentLib.NOTHING && armor == ArmorLib.NOTHING) text = nakedText;
			return text;
		}
		
		public function clothedOrNaked(clothedText:String, nakedText:String = ""):String
		{
			return (armorDescript() != "gear" ? clothedText : nakedText);
		}
		
		public function clothedOrNakedLower(clothedText:String, nakedText:String = ""):String
		{
			return (armorName != "gear" && (armorName != "lethicite armor" && lowerGarmentName == "nothing") && !isTaur() ? clothedText : nakedText);
		}
		
		public function addToWornClothesArray(armor:Armor):void {
			for (var i:int = 0; i < previouslyWornClothes.length; i++) {
				if (previouslyWornClothes[i] == armor.shortName) return; //Already have?
			}
			previouslyWornClothes.push(armor.shortName);
		}
		
		public function shrinkTits(ignore_hyper_happy:Boolean=false):void
		{
			if (flags[kFLAGS.HYPER_HAPPY] && !ignore_hyper_happy)
			{
				return;
			}
			if(breastRows.length == 1) {
				if(breastRows[0].breastRating > 0) {
					//Shrink if bigger than N/A cups
					var temp:Number;
					temp = 1;
					breastRows[0].breastRating--;
					//Shrink again 50% chance
					if(breastRows[0].breastRating >= 1 && rand(2) == 0 && findPerk(PerkLib.BigTits) < 0) {
						temp++;
						breastRows[0].breastRating--;
					}
					if(breastRows[0].breastRating < 0) breastRows[0].breastRating = 0;
					//Talk about shrinkage
					if(temp == 1) outputText("\n\nYou feel a weight lifted from you, and realize your breasts have shrunk!  With a quick measure, you determine they're now " + breastCup(0) + "s.");
					if(temp == 2) outputText("\n\nYou feel significantly lighter.  Looking down, you realize your breasts are much smaller!  With a quick measure, you determine they're now " + breastCup(0) + "s.");
				}
			}
			else if(breastRows.length > 1) {
				//multiple
				outputText("\n");
				//temp2 = amount changed
				//temp3 = counter
				var temp2:Number = 0;
				var temp3:Number = breastRows.length;
				while(temp3 > 0) {
					temp3--;
					if(breastRows[temp3].breastRating > 0) {
						breastRows[temp3].breastRating--;
						if(breastRows[temp3].breastRating < 0) breastRows[temp3].breastRating = 0;
						temp2++;
						outputText("\n");
						if(temp3 < breastRows.length - 1) outputText("...and y");
						else outputText("Y");
						outputText("our " + breastDescript(temp3) + " shrink, dropping to " + breastCup(temp3) + "s.");
					}
					if(breastRows[temp3].breastRating < 0) breastRows[temp3].breastRating = 0;
				}
				if(temp2 == 2) outputText("\nYou feel so much lighter after the change.");
				if(temp2 == 3) outputText("\nWithout the extra weight you feel particularly limber.");
				if(temp2 >= 4) outputText("\nIt feels as if the weight of the world has been lifted from your shoulders, or in this case, your chest.");
			}
		}

		public function growTits(amount:Number, rowsGrown:Number, display:Boolean, growthType:Number):void
		{
			if(breastRows.length == 0) return;
			//GrowthType 1 = smallest grows
			//GrowthType 2 = Top Row working downward
			//GrowthType 3 = Only top row
			var temp2:Number = 0;
			var temp3:Number = 0;
			//Chance for "big tits" perked characters to grow larger!
			if(findPerk(PerkLib.BigTits) >= 0 && rand(3) == 0 && amount < 1) amount=1;

			// Needs to be a number, since uint will round down to 0 prevent growth beyond a certain point
			var temp:Number = breastRows.length;
			if(growthType == 1) {
				//Select smallest breast, grow it, move on
				while(rowsGrown > 0) {
					//Temp = counter
					temp = breastRows.length;
					//Temp2 = smallest tits index
					temp2 = 0;
					//Find smallest row
					while(temp > 0) {
						temp--;
						if(breastRows[temp].breastRating < breastRows[temp2].breastRating) temp2 = temp;
					}
					//Temp 3 tracks total amount grown
					temp3 += amount;
					trace("Breastrow chosen for growth: " + String(temp2) + ".");
					//Reuse temp to store growth amount for diminishing returns.
					temp = amount;
					if (!flags[kFLAGS.HYPER_HAPPY])
					{
						//Diminishing returns!
						if(breastRows[temp2].breastRating > 3)
						{
							if(findPerk(PerkLib.BigTits) < 0)
								temp /=1.5;
							else
								temp /=1.3;
						}

						// WHy are there three options here. They all have the same result.
						if(breastRows[temp2].breastRating > 7)
						{
							if(findPerk(PerkLib.BigTits) < 0)
								temp /=2;
							else
								temp /=1.5;
						}
						if(breastRows[temp2].breastRating > 9)
						{
							if(findPerk(PerkLib.BigTits) < 0)
								temp /=2;
							else
								temp /=1.5;
						}
						if(breastRows[temp2].breastRating > 12)
						{
							if(findPerk(PerkLib.BigTits) < 0)
								temp /=2;
							else
								temp  /=1.5;
						}
					}

					//Grow!
					trace("Growing breasts by ", temp);
					breastRows[temp2].breastRating += temp;
					rowsGrown--;
				}
			}

			if (!flags[kFLAGS.HYPER_HAPPY])
			{
				//Diminishing returns!
				if(breastRows[0].breastRating > 3) {
					if(findPerk(PerkLib.BigTits) < 0) amount/=1.5;
					else amount/=1.3;
				}
				if(breastRows[0].breastRating > 7) {
					if(findPerk(PerkLib.BigTits) < 0) amount/=2;
					else amount /= 1.5;
				}
				if(breastRows[0].breastRating > 12) {
					if(findPerk(PerkLib.BigTits) < 0) amount/=2;
					else amount /= 1.5;
				}
			}
			/*if(breastRows[0].breastRating > 12) {
				if(hasPerk("Big Tits") < 0) amount/=2;
				else amount /= 1.5;
			}*/
			if(growthType == 2) {
				temp = 0;
				//Start at top and keep growing down, back to top if hit bottom before done.
				while(rowsGrown > 0) {
					if(temp+1 > breastRows.length) temp = 0;
					breastRows[temp].breastRating += amount;
					trace("Breasts increased by " + amount + " on row " + temp);
					temp++;
					temp3 += amount;
					rowsGrown--;
				}
			}
			if(growthType == 3) {
				while(rowsGrown > 0) {
					rowsGrown--;
					breastRows[0].breastRating += amount;
					temp3 += amount;
				}
			}
			//Breast Growth Finished...talk about changes.
			trace("Growth amount = ", amount);
			if(display) {
				if(growthType < 3) {
					if(amount <= 2)
					{
						if(breastRows.length > 1) outputText("Your rows of " + breastDescript(0) + " jiggle with added weight, growing a bit larger.");
						if(breastRows.length == 1) outputText("Your " + breastDescript(0) + " jiggle with added weight as they expand, growing a bit larger.");
					}
					else if(amount <= 4)
					{
						if(breastRows.length > 1) outputText("You stagger as your chest gets much heavier.  Looking down, you watch with curiosity as your rows of " + breastDescript(0) + " expand significantly.");
						if(breastRows.length == 1) outputText("You stagger as your chest gets much heavier.  Looking down, you watch with curiosity as your " + breastDescript(0) + " expand significantly.");
					}
					else
					{
						if(breastRows.length > 1) outputText("You drop to your knees from a massive change in your body's center of gravity.  Your " + breastDescript(0) + " tingle strongly, growing disturbingly large.");
						if(breastRows.length == 1) outputText("You drop to your knees from a massive change in your center of gravity.  The tingling in your " + breastDescript(0) + " intensifies as they continue to grow at an obscene rate.");
					}
					if(biggestTitSize() >= 8.5 && nippleLength < 2)
					{
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.");
						nippleLength = 2;
					}
					if(biggestTitSize() >= 7 && nippleLength < 1)
					{
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.");
						nippleLength = 1;
					}
					if(biggestTitSize() >= 5 && nippleLength < .75)
					{
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.");
						nippleLength = .75;
					}
					if(biggestTitSize() >= 3 && nippleLength < .5)
					{
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.");
						nippleLength = .5;
					}
				}
				else
				{
					if(amount <= 2) {
						if(breastRows.length > 1) outputText("Your top row of " + breastDescript(0) + " jiggles with added weight as it expands, growing a bit larger.");
						if(breastRows.length == 1) outputText("Your row of " + breastDescript(0) + " jiggles with added weight as it expands, growing a bit larger.");
					}
					if(amount > 2 && amount <= 4) {
						if(breastRows.length > 1) outputText("You stagger as your chest gets much heavier.  Looking down, you watch with curiosity as your top row of " + breastDescript(0) + " expand significantly.");
						if(breastRows.length == 1) outputText("You stagger as your chest gets much heavier.  Looking down, you watch with curiosity as your " + breastDescript(0) + " expand significantly.");
					}
					if(amount > 4) {
						if(breastRows.length > 1) outputText("You drop to your knees from a massive change in your body's center of gravity.  Your top row of " + breastDescript(0) + " tingle strongly, growing disturbingly large.");
						if(breastRows.length == 1) outputText("You drop to your knees from a massive change in your center of gravity.  The tingling in your " + breastDescript(0) + " intensifies as they continue to grow at an obscene rate.");
					}
					if(biggestTitSize() >= 8.5 && nippleLength < 2) {
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.");
						nippleLength = 2;
					}
					if(biggestTitSize() >= 7 && nippleLength < 1) {
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.");
						nippleLength = 1;
					}
					if(biggestTitSize() >= 5 && nippleLength < .75) {
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.");
						nippleLength = .75;
					}
					if(biggestTitSize() >= 3 && nippleLength < .5) {
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.");
						nippleLength = .5;
					}
				}
			}
		}

		public override function getAllMinStats():Object {
			var minStr:int = 1;
			var minTou:int = 1;
			var minSpe:int = 1;
			var minInt:int = 1;
			var minWis:int = 1;
			var minLib:int = 0;
			var minSen:int = 10;
			var minCor:int = 0;
			//Minimum Libido
			if (this.gender > 0) minLib = 15;
			else minLib = 10;
	
			if (this.armorName == "lusty maiden's armor" && this.findPerk(PerkLib.GargoylePure) >= 0) {
				if (minLib < 50) minLib = 50;
			}
			if (minLib < (minLust() * 2 / 3) && this.findPerk(PerkLib.GargoylePure) >= 0)
			{
				minLib = (minLust() * 2 / 3);
			}
			if (this.jewelryEffectId == JewelryLib.PURITY)
			{
				minLib -= this.jewelryEffectMagnitude;
			}
			if (this.findPerk(PerkLib.PurityBlessing) >= 0) {
				minLib -= 2;
			}
			if (this.findPerk(PerkLib.HistoryReligious) >= 0 || this.findPerk(PerkLib.PastLifeReligious) >= 0) {
				minLib -= 2;
			}
			if (this.findPerk(PerkLib.GargoylePure) >= 0) {
				minLib = 5;
				minSen = 5;
			}
			if (this.findPerk(PerkLib.GargoyleCorrupted) >= 0) {
				minSen += 15;
			}
			//Factory Perks
			if(this.hasPerk(PerkLib.DemonicLethicite)) {minCor+=10;minLib+=10;}
			if(this.hasPerk(PerkLib.ProductivityDrugs)) {minLib+=this.perkv1(PerkLib.ProductivityDrugs);minCor+=this.perkv2(PerkLib.ProductivityDrugs);}

			//Minimum Sensitivity
			if(this.manticoreScore() >= 6) minSen += 30;
			if(this.manticoreScore() >= 12) minSen += 15;
			if(this.devilkinScore() >= 7) minSen += 10;
			if(this.devilkinScore() >= 10) minSen += 15;
			if(this.devilkinScore() >= 14) minSen += 30;
			if(this.elfScore() >= 5) minSen += 15;
			if(this.elfScore() >= 11) minSen += 15;
			if(this.raijuScore() >= 5) minSen += 25;
			if(this.raijuScore() >= 10) minSen += 25;

			return {
				str:minStr,
				tou:minTou,
				spe:minSpe,
				inte:minInt,
				wis:minWis,
				lib:minLib,
				sens:minSen,
				cor:minCor
			};
		}

		//Determine minimum lust
		public override function minLust():Number
		{
			var min:Number = 0;
			var minCap:Number = maxLust();
			//Bimbo body boosts minimum lust by 40
			if(hasStatusEffect(StatusEffects.BimboChampagne) || findPerk(PerkLib.BimboBody) >= 0 || findPerk(PerkLib.BroBody) >= 0 || findPerk(PerkLib.FutaForm) >= 0) min += 40;
			//Omnibus' Gift
			if (findPerk(PerkLib.OmnibusGift) >= 0) min += 35;
			//Fera Blessing
			if (hasStatusEffect(StatusEffects.BlessingOfDivineFera)) min += 15;
			//Nymph perk raises to 30
			if(findPerk(PerkLib.Nymphomania) >= 0) min += 30;
			//Oh noes anemone!
			if(hasStatusEffect(StatusEffects.AnemoneArousal)) min += 30;
			//Hot blooded perk raises min lust!
			if(findPerk(PerkLib.HotBlooded) >= 0) min += perk(findPerk(PerkLib.HotBlooded)).value1;
			if(findPerk(PerkLib.LuststickAdapted) > 0) min += 10;
			if(hasStatusEffect(StatusEffects.Infested)) min += 50;
			//Add points for Crimstone
			min += perkv1(PerkLib.PiercedCrimstone);
			//Subtract points for Icestone!
			min -= perkv1(PerkLib.PiercedIcestone);
			min += perkv1(PerkLib.PentUp);
			//Cold blooded perk reduces min lust, to a minimum of 20! Takes effect after piercings. This effectively caps minimum lust at 80.
			if (findPerk(PerkLib.ColdBlooded) >= 0) {
				if (min >= 20) min -= 20;
				else min = 0;
				minCap -= 20;
			}
			//Purity Blessing perk reduce min lust, to a minimum of 10! Takes effect after piercings. This effectively caps minimum lust at 90.
			if (findPerk(PerkLib.PurityBlessing) >= 0) {
				if (min >= 10) min -= 10;
				else min = 0;
				minCap -= 10;
			}
			//Harpy Lipstick status forces minimum lust to be at least 50.
			if(hasStatusEffect(StatusEffects.Luststick)) min += 50;
			//SHOULDRA BOOSTS
			//+20
			if(flags[kFLAGS.SHOULDRA_SLEEP_TIMER] <= -168 && flags[kFLAGS.URTA_QUEST_STATUS] != 0.75) {
				min += 20;
				if(flags[kFLAGS.SHOULDRA_SLEEP_TIMER] <= -216)
					min += 30;
			}
			//cumOmeter
			if (tailType == Tail.MANTICORE_PUSSYTAIL && flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] <= 25) {
				if (flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] <= 25 && flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] > 20) min += 10;
				if (flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] <= 20 && flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] > 15) min += 20;
				if (flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] <= 15 && flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] > 10) min += 30;
				if (flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] <= 10 && flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] > 5) min += 40;
				if (flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] <= 5) min += 50;
			}
			//SPOIDAH BOOSTS
			if(eggs() >= 20) {
				min += 10;
				if(eggs() >= 40) min += 10;
			}
			//Jewelry effects
			if (jewelryEffectId == JewelryLib.MODIFIER_MINIMUM_LUST)
			{
				min += jewelryEffectMagnitude;
				if (min > (minCap - jewelryEffectMagnitude) && jewelryEffectMagnitude < 0)
				{
					minCap += jewelryEffectMagnitude;
				}
			}
			if (armorName == "lusty maiden's armor") min += 30;
			if (armorName == "tentacled bark armor") min += 20;
			//Constrain values
			if (min < 0) min = 0;
			if (min > (maxLust() - 10)) min = (maxLust() - 10);
			if (min > minCap) min = minCap;
			return min;
		}
		
		public override function getAllMaxStats():Object {
			Begin("Player","getAllMaxStats");
			var maxStr:int = 100;
			var maxTou:int = 100;
			var maxSpe:int = 100;
			var maxInt:int = 100;
			var maxWis:int = 100;
			var maxLib:int = 100;
			var maxSen:int = 100;
			var maxCor:int = 100;
			var newGamePlusMod:int = this.newGamePlusMod()+1;
			
			//Alter max speed if you have oversized parts. (Realistic mode)
			if (flags[kFLAGS.HUNGER_ENABLED] >= 1)
			{
				//Balls
				var tempSpeedPenalty:Number = 0;
				var lim:int = isTaur() ? 9 : 4;
				if (ballSize > lim && balls > 0) tempSpeedPenalty += Math.round((ballSize - lim) / 2);
				//Breasts
				lim = isTaur() ? BreastCup.I : BreastCup.G;
				if (hasBreasts() && biggestTitSize() > lim) tempSpeedPenalty += ((biggestTitSize() - lim) / 2);
				//Cocks
				lim = isTaur() ? 72 : 24;
				if (biggestCockArea() > lim) tempSpeedPenalty += ((biggestCockArea() - lim) / 6);
				//Min-cap
				var penaltyMultiplier:Number = 1;
				penaltyMultiplier -= str * 0.1;
				penaltyMultiplier -= (tallness - 72) / 168;
				if (penaltyMultiplier < 0.4) penaltyMultiplier = 0.4;
				tempSpeedPenalty *= penaltyMultiplier;
				maxSpe -= tempSpeedPenalty;
				if (maxSpe < 50) maxSpe = 50;
			}
			//Perks ahoy
			Begin("Player","getAllMaxStats.perks");
			if (findPerk(PerkLib.BasiliskResistance) >= 0 && findPerk(PerkLib.GorgonsEyes) >= 0)
			{
				maxSpe -= (5 * newGamePlusMod);
			}
			//Uma's Needlework affects max stats. Takes effect BEFORE racial modifiers and AFTER modifiers from body size.
			//Caps strength from Uma's needlework. 
			if (findPerk(PerkLib.ChiReflowSpeed) >= 0)
			{
				if (maxStr > UmasShop.NEEDLEWORK_SPEED_STRENGTH_CAP)
				{
					maxStr = UmasShop.NEEDLEWORK_SPEED_STRENGTH_CAP;
				}
			}
			//Caps speed from Uma's needlework.
			if (findPerk(PerkLib.ChiReflowDefense) >= 0)
			{
				if (maxSpe > UmasShop.NEEDLEWORK_DEFENSE_SPEED_CAP)
				{
					maxSpe = UmasShop.NEEDLEWORK_DEFENSE_SPEED_CAP;
				}
			}
			End("Player","getAllMaxStats.perks");
			Begin("Player","getAllMaxStats.racial");
			//Alter max stats depending on race (+15 za pkt)
			if (minotaurScore() >= 4) {
				if (minotaurScore() >= 10) {
					maxStr += (120 * newGamePlusMod);
					maxTou += (45 * newGamePlusMod);
					maxSpe -= (20 * newGamePlusMod);
					maxInt -= (40 * newGamePlusMod);
					maxLib += (45 * newGamePlusMod);
				}
				else {
					maxStr += (60 * newGamePlusMod);
					maxTou += (10 * newGamePlusMod);
					maxSpe -= (10 * newGamePlusMod);
					maxInt -= (20 * newGamePlusMod);
					maxLib += (20 * newGamePlusMod);
				}
			}//+20/10-20
			if (cowScore() >= 4) {
				if (cowScore() >= 10) {
					maxStr += (120 * newGamePlusMod);
					maxTou += (45 * newGamePlusMod);
					maxSpe -= (40 * newGamePlusMod);
					maxInt -= (20 * newGamePlusMod);
					maxLib += (45 * newGamePlusMod);
				}
				else {
					maxStr += (60 * newGamePlusMod);
					maxTou += (10 * newGamePlusMod);
					maxSpe -= (20 * newGamePlusMod);
					maxInt -= (10 * newGamePlusMod);
					maxLib += (20 * newGamePlusMod);
				}
			}//+20/10-20
			if (lizardScore() >= 4) {
				if (lizardScore() >= 8) {
					maxTou += (70 * newGamePlusMod);
					maxInt += (50 * newGamePlusMod);
				}
				else {
					maxTou += (40 * newGamePlusMod);
					maxInt += (20 * newGamePlusMod);
				}
			}//+10/10-20
			if (dragonScore() >= 4) {
				if (dragonScore() >= 28) {
				maxStr += (100 * newGamePlusMod);
				maxTou += (100 * newGamePlusMod);
				maxSpe += (40 * newGamePlusMod);
				maxInt += (50 * newGamePlusMod);
				maxWis += (50 * newGamePlusMod);
				maxLib += (20 * newGamePlusMod);
				}//+60
				else if (dragonScore() >= 20 && dragonScore() < 28) {
				maxStr += (95 * newGamePlusMod);
				maxTou += (95 * newGamePlusMod);
				maxSpe += (20 * newGamePlusMod);
				maxInt += (40 * newGamePlusMod);
				maxWis += (40 * newGamePlusMod);
				maxLib += (10 * newGamePlusMod);
				}
				else if (dragonScore() >= 10 && dragonScore() < 20) {
				maxStr += (50 * newGamePlusMod);
				maxTou += (40 * newGamePlusMod);
				maxSpe += (10 * newGamePlusMod);
				maxInt += (20 * newGamePlusMod);
				maxWis += (20 * newGamePlusMod);
				maxLib += (10 * newGamePlusMod);
				}
				else {
				maxStr += (15 * newGamePlusMod);
				maxTou += (15 * newGamePlusMod);
				maxInt += (15 * newGamePlusMod);
				maxWis += (15 * newGamePlusMod);
				}
			}//+60/50-60
			if (jabberwockyScore() >= 4) {
				if (jabberwockyScore() >= 20) {
				maxStr += (95 * newGamePlusMod);
				maxTou += (95 * newGamePlusMod);
				maxSpe += (100 * newGamePlusMod);
				maxInt += (40 * newGamePlusMod);
				maxWis -= (50 * newGamePlusMod);
				maxLib += (20 * newGamePlusMod);
				}
				else if (jabberwockyScore() >= 10 && jabberwockyScore() < 20) {
				maxStr += (50 * newGamePlusMod);
				maxTou += (40 * newGamePlusMod);
				maxSpe += (50 * newGamePlusMod);
				maxInt += (20 * newGamePlusMod);
				maxWis -= (20 * newGamePlusMod);
				maxLib += (10 * newGamePlusMod);
				}
				else {
				maxStr += (15 * newGamePlusMod);
				maxTou += (15 * newGamePlusMod);
				maxSpe += (30 * newGamePlusMod);
				maxInt += (15 * newGamePlusMod);
				maxWis -= (15 * newGamePlusMod);
				}
			}
			if (dogScore() >= 4) {
				maxSpe += (15 * newGamePlusMod);
				maxInt -= (5 * newGamePlusMod);
			}//+10/10-20
			if (wolfScore() >= 4) {
				if (wolfScore() >= 10) {
					maxStr += (60 * newGamePlusMod);
					maxTou += (30 * newGamePlusMod);
					maxSpe += (60 * newGamePlusMod);
					maxInt -= (10 * newGamePlusMod);
				}
				else if (wolfScore() >= 7 && hasFur() && coatColor == "glacial white") {
					maxStr += (30 * newGamePlusMod);
					maxTou += (20 * newGamePlusMod);
					maxSpe += (30 * newGamePlusMod);
					maxInt -= (10 * newGamePlusMod);
				}
				else if (wolfScore() >= 6) {
					maxStr += (30 * newGamePlusMod);
					maxTou += (10 * newGamePlusMod);
					maxSpe += (30 * newGamePlusMod);
					maxInt -= (10 * newGamePlusMod);
				}
				else {
					maxStr += (15 * newGamePlusMod);
					maxSpe += (10 * newGamePlusMod);
					maxInt -= (10 * newGamePlusMod);
				}
			}//+15(60)((70))(((140)))/10-20(50-60)((70-80))(((130-140)))
			if (foxScore() >= 4) {
				if (foxScore() >= 7) {
					maxStr -= (30 * newGamePlusMod);
					maxSpe += (80 * newGamePlusMod);
					maxInt += (55 * newGamePlusMod);
				}
				else {
					maxStr -= (5 * newGamePlusMod);
					maxSpe += (40 * newGamePlusMod);
					maxInt += (25 * newGamePlusMod);
				}
			}//+10/10-20
			if (catScore() >= 4) {
				if (catScore() >= 8) {
					if (findPerk(PerkLib.Flexibility) > 0) maxSpe += (70 * newGamePlusMod);
					else maxSpe += (60 * newGamePlusMod);
					maxLib += (60 * newGamePlusMod);
				}
				else {
					if (findPerk(PerkLib.Flexibility) > 0) maxSpe += (50 * newGamePlusMod);
					else maxSpe += (40 * newGamePlusMod);
					maxLib += (20 * newGamePlusMod);
				}

			}//+10 / 10 - 20
			if (nekomataScore() >= 11) {
				if (findPerk(PerkLib.Flexibility) > 0) maxSpe += (50 * newGamePlusMod);
				else maxSpe += (40 * newGamePlusMod);
				maxInt += (40 * newGamePlusMod);
				maxWis += (85 * newGamePlusMod);
			}
			if (cheshireScore() >= 11) {
				if (findPerk(PerkLib.Flexibility) > 0) maxSpe += (70 * newGamePlusMod);
				else maxSpe += (60 * newGamePlusMod);
				maxInt += (80 * newGamePlusMod);
				maxSen += (25 * newGamePlusMod)
			}
			if (bunnyScore() >= 4) {
				maxSpe += (10 * newGamePlusMod);
			}//+10/10-20
			if (raccoonScore() >= 4) {
				maxSpe += (15 * newGamePlusMod);
			}//+15/10-20
			if (horseScore() >= 4) {
				if (horseScore() >= 7) {
					maxSpe += (70 * newGamePlusMod);
					maxTou += (35 * newGamePlusMod);
				}
				else {
					maxSpe += (40 * newGamePlusMod);
					maxTou += (20 * newGamePlusMod);
				}
			}//+15/10-20
			if (goblinScore() >= 4) {
				maxInt += (20 * newGamePlusMod);
			}//+20/10-20
			if (gooScore() >= 4) {
				if (gooScore() >= 8) {
					maxTou += (80 * newGamePlusMod);
					maxSpe -= (40 * newGamePlusMod);
					maxLib += (80 * newGamePlusMod);
				}
				else {
					maxTou += (40 * newGamePlusMod);
					maxSpe -= (20 * newGamePlusMod);
					maxLib += (40 * newGamePlusMod);
				}
			}//+20/10-20
			if (kitsuneScore() >= 5) {
				if (kitsuneScore() >= 12 && tailType == 13 && tailCount == 9) {
					maxStr -= (50 * newGamePlusMod);
					maxSpe += (40 * newGamePlusMod);
					maxInt += (70 * newGamePlusMod);
					maxWis += (100 * newGamePlusMod);
					maxLib += (20 * newGamePlusMod);
				}
				else {
					maxStr -= (35 * newGamePlusMod);
					maxSpe += (20 * newGamePlusMod);
					maxInt += (30 * newGamePlusMod);
					maxWis += (40 * newGamePlusMod);
					maxLib += (20 * newGamePlusMod);
				}
			}//+50/50-60
		/*	if (kitshooScore() >= 6) {
				if (tailType == 26) {
					if (tailCount == 1) {
						maxStr -= (2 * newGamePlusMod);
						maxSpe += (2 * newGamePlusMod);
						maxInt += (4 * newGamePlusMod);
					}
					else if (tailCount >= 2 && tailCount < 9) {
						maxStr -= ((tailCount + 1) * newGamePlusMod);
						maxSpe += ((tailCount + 1) * newGamePlusMod);
						maxInt += (((tailCount/2) + 2) * newGamePlusMod);
					}
					else if (tailCount >= 9) {
						maxStr -= (10 * newGamePlusMod);;
						maxSpe += (10 * newGamePlusMod);;
						maxInt += (20 * newGamePlusMod);;
					}
				}
			}
		*/	if (beeScore() >= 5) {
				if (beeScore() >= 9) {
					maxTou += (50 * newGamePlusMod);
					maxSpe += (50 * newGamePlusMod);
					maxInt += (35 * newGamePlusMod);
				}
				else {
					maxTou += (30 * newGamePlusMod);
					maxSpe += (30 * newGamePlusMod);
					maxInt += (15 * newGamePlusMod);
				}
			}//+40/30-40
			if (spiderScore() >= 4) {
				if (spiderScore() >= 7) {
					maxStr -= (20 * newGamePlusMod);
					maxTou += (50 * newGamePlusMod);
					maxInt += (75 * newGamePlusMod);
				}
				else {
					maxStr -= (10 * newGamePlusMod);
					maxTou += (30 * newGamePlusMod);
					maxInt += (40 * newGamePlusMod);
				}
			}//+10/10-20
			if (kangaScore() >= 4) {
				maxTou += (5 * newGamePlusMod);
				maxSpe += (15 * newGamePlusMod);
			}//+20/10-20
			if (sharkScore() >= 4) {
				if (sharkScore() >= 9 && vaginas.length > 0 && cocks.length > 0) {
					maxStr += (60 * newGamePlusMod);
					maxSpe += (70 * newGamePlusMod);
					maxLib += (20 * newGamePlusMod);
				}
				else if (sharkScore() >= 8) {
					maxStr += (40 * newGamePlusMod);
					maxSpe += (70 * newGamePlusMod);
					maxLib += (10 * newGamePlusMod);
				}
				else {
					maxStr += (20 * newGamePlusMod);
					maxSpe += (40 * newGamePlusMod);
				}
			}//+10/10-20
			if (harpyScore() >= 4) {
				if (harpyScore() >= 8) {
					maxTou -= (20 * newGamePlusMod);
					maxSpe += (80 * newGamePlusMod);
					maxLib += (60 * newGamePlusMod);
				}
				else {
					maxTou -= (10 * newGamePlusMod);
					maxSpe += (40 * newGamePlusMod);
					maxLib += (30 * newGamePlusMod);
				}
			}//+10/10-20
			if (sirenScore() >= 10) {
				maxStr += (40 * newGamePlusMod);
				maxSpe += (70 * newGamePlusMod);
				maxInt += (40 * newGamePlusMod);
			}//+20/10-20
			if (orcaScore() >= 6) {
				if (orcaScore() >= 12) {
					maxStr += (70 * newGamePlusMod);
					maxTou += (40 * newGamePlusMod);
					maxSpe += (70 * newGamePlusMod);
				}
				else {
					maxStr += (35 * newGamePlusMod);
					maxTou += (20 * newGamePlusMod);
					maxSpe += (35 * newGamePlusMod);
				}
			}//+10/10-20
			if (oniScore() >= 6) {
				if (oniScore() >= 12) {
					maxStr += (100 * newGamePlusMod);
					maxTou += (60 * newGamePlusMod);
					maxInt -= (20 * newGamePlusMod);
					maxWis += (40 * newGamePlusMod);
				}
				else {
					maxStr += (50 * newGamePlusMod);
					maxTou += (30 * newGamePlusMod);
					maxInt -= (10 * newGamePlusMod);
					maxWis += (20 * newGamePlusMod);
				}
			}//+10/10-20
			if (elfScore() >= 5) {
				if (elfScore() >= 11) {
					maxStr -= (10 * newGamePlusMod);
					maxTou -= (15 * newGamePlusMod);
					maxSpe += (80 * newGamePlusMod);
					maxInt += (80 * newGamePlusMod);
					maxWis += (60 * newGamePlusMod);
					maxSen += (30 * newGamePlusMod);
				}
				else {
					maxStr -= (10 * newGamePlusMod);
					maxTou -= (10 * newGamePlusMod);
					maxSpe += (40 * newGamePlusMod);
					maxInt += (40 * newGamePlusMod);
					maxWis += (30 * newGamePlusMod);
					maxSen += (15 * newGamePlusMod);
				}
			}//+10/10-20
			if (raijuScore() >= 5) {
				if (raijuScore() >= 10) {
					maxSpe += (70 * newGamePlusMod);
					maxInt += (50 * newGamePlusMod);
					maxLib += (80 * newGamePlusMod);
					maxSen += (50 * newGamePlusMod);
				}
				else {
					maxSpe += (35 * newGamePlusMod);
					maxInt += (25 * newGamePlusMod);
					maxLib += (40 * newGamePlusMod);
					maxSen += (25 * newGamePlusMod);
				}
			}//+10/10-20
			if (demonScore() >= 5) {
				if (demonScore() >= 11) {
					maxSpe += (30 * newGamePlusMod);
					maxInt += (35 * newGamePlusMod);
					maxLib += (100 * newGamePlusMod);
				}
				else {
					maxSpe += (15 * newGamePlusMod);
					maxInt += (15 * newGamePlusMod);
					maxLib += (45 * newGamePlusMod);
				}
			}//+60/50-60
			if (devilkinScore() >= 7) {
				if (devilkinScore() >= 14) {
					maxSpe += (30 * newGamePlusMod);
					maxInt += (35 * newGamePlusMod);
					maxLib += (100 * newGamePlusMod);
				}
				else if (devilkinScore() >= 11 && devilkinScore() < 14) {
					maxStr += (50 * newGamePlusMod);
					maxSpe -= (20 * newGamePlusMod);
					maxInt += (60 * newGamePlusMod);
					maxLib += (75 * newGamePlusMod);
					maxSen += (15 * newGamePlusMod);
				}
				else {
					maxStr += (35 * newGamePlusMod);
					maxSpe -= (10 * newGamePlusMod);
					maxInt += (40 * newGamePlusMod);
					maxLib += (50 * newGamePlusMod);
					maxSen += (10 * newGamePlusMod);
				}
			}//+60/50-60
			if (rhinoScore() >= 4) {
				maxStr += (15 * newGamePlusMod);
				maxTou += (15 * newGamePlusMod);
				maxSpe -= (10 * newGamePlusMod);
				maxInt -= (10 * newGamePlusMod);
			}//+10/10-20
			if (satyrScore() >= 4) {
				maxStr += (5 * newGamePlusMod);
				maxSpe += (5 * newGamePlusMod);
			}//+10/10-20
			if (manticoreScore() >= 6) {
				if (manticoreScore() >= 12) {
					maxSpe += (100 * newGamePlusMod);
					maxInt += (50 * newGamePlusMod);
					maxLib += (60 * newGamePlusMod);
				}
				else {
					maxSpe += (50 * newGamePlusMod);
					maxInt += (25 * newGamePlusMod);
					maxLib += (30 * newGamePlusMod);
				}
			}//+60/50-60
			if (redpandaScore() >= 4) {
				if (redpandaScore() >= 8) {
					maxStr += (15 * newGamePlusMod);
					maxSpe += (75 * newGamePlusMod);
					maxInt += (30 * newGamePlusMod);
				}
				else {
					maxSpe += (45 * newGamePlusMod);
					maxInt += (15 * newGamePlusMod);
				}
			}
			if (mantisScore() >= 6) {
				if (mantisScore() >= 12) {
					maxStr -= (40 * newGamePlusMod);
					maxTou += (60 * newGamePlusMod);
					maxSpe += (140 * newGamePlusMod);
					maxInt += (20 * newGamePlusMod);
				}
				else {
					maxStr -= (20 * newGamePlusMod);
					maxTou += (30 * newGamePlusMod);
					maxSpe += (70 * newGamePlusMod);
					maxInt += (10 * newGamePlusMod);
				}
			}//+35/30-40
			if (salamanderScore() >= 4) {
				if (salamanderScore() >= 7) {
					maxStr += (25 * newGamePlusMod);
					maxTou += (25 * newGamePlusMod);
					maxLib += (40 * newGamePlusMod);
				}
				else {
					maxStr += (15 * newGamePlusMod);
					maxTou += (15 * newGamePlusMod);
					maxLib += (30 * newGamePlusMod);
				}
			}//+15/10-20
			if (unicornScore() >= 9) {
				maxTou += (20 * newGamePlusMod);
				maxSpe += (40 * newGamePlusMod);
				maxInt += (75 * newGamePlusMod);
			}//+(15)30/(10-20)30-40
			if (alicornScore() >= 11) {
				maxTou += (25 * newGamePlusMod);
				maxSpe += (50 * newGamePlusMod);
				maxInt += (90 * newGamePlusMod);
			}//+(30)55/(30-40)50-60
			if (phoenixScore() >= 10) {
				maxStr += (20 * newGamePlusMod);
				maxTou += (20 * newGamePlusMod);
				maxSpe += (70 * newGamePlusMod);
				maxLib += (40 * newGamePlusMod);
			}//+30/30-40
			if (scyllaScore() >= 4) {
				if (scyllaScore() >= 12) {
					maxStr += (120 * newGamePlusMod);
					maxInt += (60 * newGamePlusMod);
				}
				else if (scyllaScore() >= 7 && scyllaScore() < 12) {
					maxStr += (65 * newGamePlusMod);
					maxInt += (40 * newGamePlusMod);
				}
				else {
					maxStr += (40 * newGamePlusMod);
					maxInt += (20 * newGamePlusMod);
				}
			}//+30/30-40
			if (plantScore() >= 4) {
				if (plantScore() >= 7) {
					maxStr += (25 * newGamePlusMod);
					maxTou += (100 * newGamePlusMod);
					maxSpe -= (50 * newGamePlusMod);
				}
				else if (plantScore() == 6) {
					maxStr += (20 * newGamePlusMod);
					maxTou += (80 * newGamePlusMod);
					maxSpe -= (40 * newGamePlusMod);
				}
				else if (plantScore() == 5) {
					maxStr += (10 * newGamePlusMod);
					maxTou += (50 * newGamePlusMod);
					maxSpe -= (20 * newGamePlusMod);
				}
				else {
					maxTou += (30 * newGamePlusMod);
					maxSpe -= (10 * newGamePlusMod);
				}
			}//+20(40)(60)(75)/10-20(30-40)(50-60)(70-80)
			if (alrauneScore() >= 10) {
				maxTou += (100 * newGamePlusMod);
				maxSpe -= (50 * newGamePlusMod);
				maxLib += (100 * newGamePlusMod);
			}
			if (yggdrasilScore() >= 10) {
				maxStr += (50 * newGamePlusMod);
				maxTou += (70 * newGamePlusMod);
				maxSpe -= (50 * newGamePlusMod);
				maxInt += (50 * newGamePlusMod);
				maxWis += (80 * newGamePlusMod);
				maxLib -= (50 * newGamePlusMod);
			}//+150
			if (deerScore() >= 4) {
				maxSpe += (20 * newGamePlusMod);
			}//+20/10-20
			if (yetiScore() >= 6) {
				if (yetiScore() >= 12) {
					maxStr += (60 * newGamePlusMod);
					maxTou += (80 * newGamePlusMod);
					maxSpe += (50 * newGamePlusMod);
					maxInt -= (60 * newGamePlusMod);
					maxLib += (50 * newGamePlusMod);
				}
				else {
					maxStr += (30 * newGamePlusMod);
					maxTou += (40 * newGamePlusMod);
					maxSpe += (25 * newGamePlusMod);
					maxInt -= (30 * newGamePlusMod);
					maxLib += (25 * newGamePlusMod);
				}
			}
			if (couatlScore() >= 11) {
				maxStr += (40 * newGamePlusMod);
				maxTou += (25 * newGamePlusMod);
				maxSpe += (100 * newGamePlusMod);
			}//+30/30-40
			if (vouivreScore() >= 11) {
				maxStr += (10 * newGamePlusMod);
				maxTou -= (10 * newGamePlusMod);
				maxSpe += (35 * newGamePlusMod);
				maxInt += (10 * newGamePlusMod);
				maxWis -= (20 * newGamePlusMod);
			}//+30/30-40
			if (gorgonScore() >= 11) {
				maxStr += (50 * newGamePlusMod);
				maxTou += (45 * newGamePlusMod);
				maxSpe += (70 * newGamePlusMod);
			}//+30/30-40
			if (nagaScore() >= 4)
			{
				if (nagaScore() >= 8) {
					maxStr += (40 * newGamePlusMod);
					maxTou += (20 * newGamePlusMod);
					maxSpe += (60 * newGamePlusMod);
				}
				else {
					maxStr += (20 * newGamePlusMod);
					maxSpe += (40 * newGamePlusMod);
				}
			}
			if (centaurScore() >= 8) {
				maxTou += (80 * newGamePlusMod);
				maxSpe += (40 * newGamePlusMod);
			}//+40/30-40
			if (isNaga()) {
				maxStr += (15 * newGamePlusMod);
				maxSpe += (15 * newGamePlusMod);
			}
			if (isTaur()) {
				maxSpe += (20 * newGamePlusMod);
			}
			if (isDrider()) {
				maxTou += (15 * newGamePlusMod);
				maxSpe += (15 * newGamePlusMod);
			}
			if (isScylla()) {
				maxStr += (30 * newGamePlusMod);
			}
			if (gargoyleScore() >= 21) {
				if (flags[kFLAGS.GARGOYLE_BODY_MATERIAL] == 1) {
					maxStr += (90 * newGamePlusMod);
					maxTou += (100 * newGamePlusMod);
					maxInt += (70 * newGamePlusMod);
				}
				if (flags[kFLAGS.GARGOYLE_BODY_MATERIAL] == 2) {
					maxTou += (70 * newGamePlusMod);
					maxInt += (100 * newGamePlusMod);
					maxInt += (90 * newGamePlusMod);
				}
			}
			if (batScore() >= 6){
                var mod:int = batScore() >= 10 ? 35:20;
                maxStr += mod * newGamePlusMod;
                maxSpe += mod * newGamePlusMod;
                maxInt += mod * newGamePlusMod;
                maxLib += (10+mod) * newGamePlusMod;
			}
			if (vampireScore() >= 6){
                mod = vampireScore() >= 10 ? 35:20;
				maxStr += mod * newGamePlusMod;
				maxSpe += mod * newGamePlusMod;
				maxInt += mod * newGamePlusMod;
				maxLib += (10 + mod) * newGamePlusMod;
			}
			if (dragonScore() >= 4) {
				if (dragonScore() >= 20) {
				maxStr += (95 * newGamePlusMod);
				maxTou += (95 * newGamePlusMod);
				maxSpe += (100 * newGamePlusMod);
				maxInt += (40 * newGamePlusMod);
				maxWis -= (50 * newGamePlusMod);
				maxLib += (10 * newGamePlusMod);
				}
				else if (dragonScore() >= 10 && dragonScore() < 20) {
				maxStr += (50 * newGamePlusMod);
				maxTou += (40 * newGamePlusMod);
				maxSpe += (50 * newGamePlusMod);
				maxInt += (20 * newGamePlusMod);
				maxWis -= (20 * newGamePlusMod);
				maxLib += (10 * newGamePlusMod);
				}
				else {
				maxStr += (15 * newGamePlusMod);
				maxTou += (15 * newGamePlusMod);
				maxSpe += (30 * newGamePlusMod);
				maxInt += (15 * newGamePlusMod);
				maxWis -= (15 * newGamePlusMod);
				}
			}
			if (humanScore() == 30) {
				maxStr += (40 * newGamePlusMod);
				maxTou += (40 * newGamePlusMod);
				maxSpe += (40 * newGamePlusMod);
				maxInt += (40 * newGamePlusMod);
				maxWis += (40 * newGamePlusMod);
				maxLib += (40 * newGamePlusMod);
				maxSen += (40 * newGamePlusMod);
			}
			if (humanScore() == 29) {
				maxStr += (30 * newGamePlusMod);
				maxTou += (30 * newGamePlusMod);
				maxSpe += (30 * newGamePlusMod);
				maxInt += (30 * newGamePlusMod);
				maxWis += (30 * newGamePlusMod);
				maxLib += (30 * newGamePlusMod);
				maxSen += (30 * newGamePlusMod);
			}
			if (humanScore() == 28) {
				maxStr += (20 * newGamePlusMod);
				maxTou += (20 * newGamePlusMod);
				maxSpe += (20 * newGamePlusMod);
				maxInt += (20 * newGamePlusMod);
				maxWis += (20 * newGamePlusMod);
				maxLib += (20 * newGamePlusMod);
				maxSen += (20 * newGamePlusMod);
			}
			if (humanScore() == 27) {
				maxStr += (10 * newGamePlusMod);
				maxTou += (10 * newGamePlusMod);
				maxSpe += (10 * newGamePlusMod);
				maxInt += (10 * newGamePlusMod);
				maxWis += (10 * newGamePlusMod);
				maxLib += (10 * newGamePlusMod);
				maxSen += (10 * newGamePlusMod);
			}
			if (internalChimeraScore() >= 1) {
				maxStr += (5 * internalChimeraScore() * newGamePlusMod);
				maxTou += (5 * internalChimeraScore() * newGamePlusMod);
				maxSpe += (5 * internalChimeraScore() * newGamePlusMod);
				maxInt += (5 * internalChimeraScore() * newGamePlusMod);
				maxWis += (5 * internalChimeraScore() * newGamePlusMod);
				maxLib += (5 * internalChimeraScore() * newGamePlusMod);
				maxSen += (5 * internalChimeraScore() * newGamePlusMod);
			}
			if (maxStr < 25) maxStr = 25;
			if (maxTou < 25) maxTou = 25;
			if (maxSpe < 25) maxSpe = 25;
			if (maxInt < 25) maxInt = 25;
			if (maxWis < 25) maxWis = 25;
			if (maxLib < 25) maxLib = 25;
			if (maxSen < 25) maxSen = 25;
			End("Player","getAllMaxStats.racial");
			Begin("Player","getAllMaxStats.perks2");
			if (findPerk(PerkLib.ChimericalBodyInitialStage) > 0) {
				maxTou += (5 * newGamePlusMod);
				maxLib += (5 * newGamePlusMod);
			}
			if (findPerk(PerkLib.ChimericalBodyBasicStage) > 0) {
				maxStr += (5 * newGamePlusMod);
				maxSpe += (5 * newGamePlusMod);
				maxInt += (5 * newGamePlusMod);
				maxWis += (5 * newGamePlusMod);
			}
			if (findPerk(PerkLib.ChimericalBodyAdvancedStage) > 0) {
				maxStr += (10 * newGamePlusMod);
				maxTou += (10 * newGamePlusMod);
				maxSpe += (10 * newGamePlusMod);
			}
			if (findPerk(PerkLib.ChimericalBodyPerfectStage) > 0) {
				maxInt += (10 * newGamePlusMod);
				maxWis += (10 * newGamePlusMod);
				maxLib += (10 * newGamePlusMod);
			}
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) > 0) {
				maxStr += (10 * newGamePlusMod);
				maxTou += (10 * newGamePlusMod);
				maxSpe += (10 * newGamePlusMod);
				maxInt += (10 * newGamePlusMod);
				maxWis += (10 * newGamePlusMod);
				maxLib += (10 * newGamePlusMod);
			}
			if (findPerk(PerkLib.SalamanderAdrenalGlands) > 0) {
				maxTou += (5 * newGamePlusMod);
				maxLib += (5 * newGamePlusMod);
			}
			if (findPerk(PerkLib.SalamanderAdrenalGlandsEvolved) > 0) {
				maxStr += (5 * newGamePlusMod);
				maxTou += (5 * newGamePlusMod);
				maxSpe += (5 * newGamePlusMod);
				maxLib += (5 * newGamePlusMod);
			}
			if (findPerk(PerkLib.ScyllaInkGlands) > 0) {
				maxStr += (10 * newGamePlusMod);
			}
			if (findPerk(PerkLib.MantislikeAgility) > 0) {
				if (hasCoatOfType(Skin.CHITIN) && findPerk(PerkLib.ThickSkin) >= 0) maxSpe += (20 * newGamePlusMod);
				if ((skinType == Skin.SCALES && findPerk(PerkLib.ThickSkin) >= 0) || hasCoatOfType(Skin.CHITIN)) maxSpe += (15 * newGamePlusMod);
				if (skinType == Skin.SCALES) maxSpe += (10 * newGamePlusMod);
				if (findPerk(PerkLib.ThickSkin) >= 0) maxSpe += (5 * newGamePlusMod);
			}
			if (findPerk(PerkLib.MantislikeAgilityEvolved) > 0) {
				if (hasCoatOfType(Skin.CHITIN) && findPerk(PerkLib.ThickSkin) >= 0) maxSpe += (20 * newGamePlusMod);
				if ((skinType == Skin.SCALES && findPerk(PerkLib.ThickSkin) >= 0) || hasCoatOfType(Skin.CHITIN)) maxSpe += (15 * newGamePlusMod);
				if (skinType == Skin.SCALES) maxSpe += (10 * newGamePlusMod);
				if (findPerk(PerkLib.ThickSkin) >= 0) maxSpe += (5 * newGamePlusMod);
			}
			if (findPerk(PerkLib.DraconicLungs) >= 0) {
				maxSpe += (5 * newGamePlusMod);
			}
			if (findPerk(PerkLib.DraconicLungsEvolved) >= 0) {
				maxTou += (5 * newGamePlusMod);
				maxSpe += (5 * newGamePlusMod);
			}
			if (findPerk(PerkLib.KitsuneThyroidGland) >= 0) {
				maxSpe += (5 * newGamePlusMod);
			}
			if (findPerk(PerkLib.KitsuneThyroidGlandEvolved) >= 0) {
				maxSpe += (5 * newGamePlusMod);
				maxWis += (5 * newGamePlusMod);
			}
			if (findPerk(PerkLib.CatlikeNimblenessEvolved) >= 0) {
				maxSpe += (10 * newGamePlusMod);
			}
			if (findPerk(PerkLib.GargoylePure) > 0) {
				maxWis += (80 * newGamePlusMod);
				maxLib -= (10 * newGamePlusMod);
				maxSen -= (10 * newGamePlusMod);
			}
			if (findPerk(PerkLib.GargoyleCorrupted) > 0) {
				maxWis -= (10 * newGamePlusMod);
				maxLib += (80 * newGamePlusMod);
			}
			if (findPerk(PerkLib.EzekielBlessing) > 0) {
				maxStr += (5 * newGamePlusMod);
				maxTou += (5 * newGamePlusMod);
				maxSpe += (5 * newGamePlusMod);
				maxInt += (5 * newGamePlusMod);
				maxWis += (5 * newGamePlusMod);
				maxLib += (5 * newGamePlusMod);
				maxSen += (5 * newGamePlusMod);
			}
			//Perks
			if (findPerk(PerkLib.JobAllRounder) >= 0) {
				maxStr += (10 * newGamePlusMod);
				maxTou += (10 * newGamePlusMod);
				maxSpe += (10 * newGamePlusMod);
				maxInt += (10 * newGamePlusMod);
				maxWis += (10 * newGamePlusMod);
				maxLib += (6 * newGamePlusMod);
				maxSen += (6 * newGamePlusMod);
			}
			if (findPerk(PerkLib.JobBarbarian) >= 0) maxStr += (10 * newGamePlusMod);
			if (findPerk(PerkLib.JobBeastWarrior) >= 0) {
				maxStr += (5 * newGamePlusMod);
				maxTou += (5 * newGamePlusMod);
				maxSpe += (5 * newGamePlusMod);
				if (findPerk(PerkLib.ImprovingNaturesBlueprintsApexPredator) >= 0) {
					maxInt += (5 * newGamePlusMod);
					maxWis += (5 * newGamePlusMod);
				}
				else {
					maxInt -= (5 * newGamePlusMod);
					maxWis -= (5 * newGamePlusMod);
				}
			}
			if (findPerk(PerkLib.JobCourtesan) >= 0) maxLib += (15 * newGamePlusMod);
			if (findPerk(PerkLib.JobBrawler) >= 0) maxStr += (10 * newGamePlusMod);
			if (findPerk(PerkLib.JobDervish) >= 0) maxSpe += (10 * newGamePlusMod);
			if (findPerk(PerkLib.JobDefender) >= 0) maxTou += (15 * newGamePlusMod);
			if (findPerk(PerkLib.JobElementalConjurer) >= 0) maxWis += (5 * newGamePlusMod);
			if (findPerk(PerkLib.JobEnchanter) >= 0) maxInt += (15 * newGamePlusMod);
			if (findPerk(PerkLib.JobEromancer) >= 0) {
				maxInt += (5 * newGamePlusMod);
				maxLib += (5 * newGamePlusMod);
			}
			if (findPerk(PerkLib.JobGolemancer) >= 0) {
				maxInt += (5 * newGamePlusMod);
				maxWis += (5 * newGamePlusMod);
			}
			if (findPerk(PerkLib.JobGuardian) >= 0) maxTou += (5 * newGamePlusMod);
			if (findPerk(PerkLib.JobHunter) >= 0) {
				maxSpe += (10 * newGamePlusMod);
				maxInt += (5 * newGamePlusMod);
			}
			if (findPerk(PerkLib.JobKnight) >= 0) maxTou += (10 * newGamePlusMod);
			if (findPerk(PerkLib.JobMonk) >= 0) maxWis += (15 * newGamePlusMod);
			if (findPerk(PerkLib.JobRanger) >= 0) maxSpe += (5 * newGamePlusMod);
			if (findPerk(PerkLib.JobSeducer) >= 0) maxLib += (5 * newGamePlusMod);
			if (findPerk(PerkLib.JobSorcerer) >= 0) maxInt += (5 * newGamePlusMod);
			if (findPerk(PerkLib.JobSoulCultivator) >= 0) maxWis += (5 * newGamePlusMod);
			if (findPerk(PerkLib.JobWarlord) >= 0) maxTou += (20 * newGamePlusMod);
			if (findPerk(PerkLib.JobWarrior) >= 0) maxStr += (5 * newGamePlusMod);
			if (findPerk(PerkLib.PrestigeJobArcaneArcher) >= 0) {
				maxSpe += (40 * newGamePlusMod);
				maxInt += (40 * newGamePlusMod);
			}
			if (findPerk(PerkLib.PrestigeJobBerserker) >= 0) {
				maxStr += (60 * newGamePlusMod);
				maxTou += (20 * newGamePlusMod);
			}
			if (findPerk(PerkLib.PrestigeJobSeer) >= 0) {
				maxInt += (60 * newGamePlusMod);
				maxWis += (20 * newGamePlusMod);
			}
			if (findPerk(PerkLib.PrestigeJobSentinel) >= 0) {
				maxStr += (20 * newGamePlusMod);
				maxTou += (60 * newGamePlusMod);
			}
			if (findPerk(PerkLib.PrestigeJobSoulArcher) >= 0) {
				maxSpe += (40 * newGamePlusMod);
				maxWis += (40 * newGamePlusMod);
			}
			if (findPerk(PerkLib.PrestigeJobSoulArtMaster) >= 0) {
				maxStr += (40 * newGamePlusMod);
				maxWis += (40 * newGamePlusMod);
			}
			if (findPerk(PerkLib.DeityJobMunchkin) >= 0) {
				maxStr += (25 * newGamePlusMod);
				maxTou += (25 * newGamePlusMod);
				maxSpe += (25 * newGamePlusMod);
				maxInt += (25 * newGamePlusMod);
				maxWis += (25 * newGamePlusMod);
				maxLib += (15 * newGamePlusMod);
				maxSen += (15 * newGamePlusMod);
			}
			if (findPerk(PerkLib.WeaponMastery) >= 0) maxStr += (5 * newGamePlusMod);
			if (findPerk(PerkLib.WeaponGrandMastery) >= 0) maxStr += (10 * newGamePlusMod);
			if (findPerk(PerkLib.ElementalConjurerResolve) >= 0) {
				if (findPerk(PerkLib.ElementalConjurerMindAndBodyResolve) < 0) {
					maxStr -= (15 * newGamePlusMod);
					maxTou -= (15 * newGamePlusMod);
					maxSpe -= (15 * newGamePlusMod);
				}
				maxInt += (20 * newGamePlusMod);
				maxWis += (30 * newGamePlusMod);
			}
			if (findPerk(PerkLib.ElementalConjurerDedication) >= 0) {
				if (findPerk(PerkLib.ElementalConjurerMindAndBodyDedication) < 0) {
					maxStr -= (30 * newGamePlusMod);
					maxTou -= (30 * newGamePlusMod);
					maxSpe -= (30 * newGamePlusMod);
				}
				maxInt += (40 * newGamePlusMod);
				maxWis += (60 * newGamePlusMod);
			}
			if (findPerk(PerkLib.ElementalConjurerSacrifice) >= 0) {
				if (findPerk(PerkLib.ElementalConjurerMindAndBodySacrifice) < 0) {
					maxStr -= (45 * newGamePlusMod);
					maxTou -= (45 * newGamePlusMod);
					maxSpe -= (45 * newGamePlusMod);
				}
				maxInt += (60 * newGamePlusMod);
				maxWis += (90 * newGamePlusMod);
			}
			if (findPerk(PerkLib.HclassHeavenTribulationSurvivor) >= 0) {
				maxStr += (10 * newGamePlusMod);
				maxTou += (10 * newGamePlusMod);
				maxSpe += (10 * newGamePlusMod);
				maxInt += (10 * newGamePlusMod);
				maxWis += (10 * newGamePlusMod);
				maxLib += (10 * newGamePlusMod);
				maxSen += (10 * newGamePlusMod);
			}
			if (findPerk(PerkLib.GclassHeavenTribulationSurvivor) >= 0) {
				maxStr += (15 * newGamePlusMod);
				maxTou += (15 * newGamePlusMod);
				maxSpe += (15 * newGamePlusMod);
				maxInt += (15 * newGamePlusMod);
				maxWis += (15 * newGamePlusMod);
				maxLib += (15 * newGamePlusMod);
				maxSen += (15 * newGamePlusMod);
			}
			if (findPerk(PerkLib.SoulApprentice) >= 0) maxWis += 5;
			if (findPerk(PerkLib.SoulPersonage) >= 0) maxWis += 5;
			if (findPerk(PerkLib.SoulWarrior) >= 0) maxWis += 5;
			if (findPerk(PerkLib.SoulSprite) >= 0) maxWis += 5;
			if (findPerk(PerkLib.SoulScholar) >= 0) maxWis += 5;
			if (findPerk(PerkLib.SoulElder) >= 0) maxWis += 5;
			if (findPerk(PerkLib.SoulExalt) >= 0) maxWis += 5;
			if (findPerk(PerkLib.SoulOverlord) >= 0) maxWis += 5;
			if (findPerk(PerkLib.SoulTyrant) >= 0) maxWis += 5;
			if (findPerk(PerkLib.SoulKing) >= 0) maxWis += 5;
			if (findPerk(PerkLib.SoulEmperor) >= 0) maxWis += 5;
			if (findPerk(PerkLib.SoulAncestor) >= 0) maxWis += 5;
			if (findPerk(PerkLib.EpicGolemMaker) >= 0) {
				maxInt += 10;
				maxWis += 10;
			}
			if (findPerk(PerkLib.LegendaryGolemMaker) >= 0) {
				maxInt += 20;
				maxWis += 20;
			}
			if (findPerk(PerkLib.MythicalGolemMaker) >= 0) {
				maxInt += 30;
				maxWis += 30;
			}
			if (findPerk(PerkLib.CarefulButRecklessAimAndShooting) >= 0 && findPerk(PerkLib.ColdAim) < 0) maxTou -= (15 * newGamePlusMod);
			End("Player","getAllMaxStats.perks2");
			Begin("Player","getAllMaxStats.effects");
			//Apply New Game+
			maxStr += 5 * perkv1(PerkLib.AscensionTranshumanism);
			maxTou += 5 * perkv1(PerkLib.AscensionTranshumanism);
			maxSpe += 5 * perkv1(PerkLib.AscensionTranshumanism);
			maxInt += 5 * perkv1(PerkLib.AscensionTranshumanism);
			maxWis += 5 * perkv1(PerkLib.AscensionTranshumanism);
			maxLib += 5 * perkv1(PerkLib.AscensionTranshumanism);
			maxSen += 5 * perkv1(PerkLib.AscensionTranshumanism);
			//Might
			if (hasStatusEffect(StatusEffects.Might)) {
				if (hasStatusEffect(StatusEffects.FortressOfIntellect)) maxInt += statusEffectv1(StatusEffects.Might);
				else maxStr += statusEffectv1(StatusEffects.Might);
				maxTou += statusEffectv2(StatusEffects.Might);
			}
			//Blink
			if (hasStatusEffect(StatusEffects.Blink)) {
				maxSpe += statusEffectv1(StatusEffects.Blink);
			}
			//Dwarf Rage
			if (hasStatusEffect(StatusEffects.DwarfRage)) {
				maxStr += statusEffectv1(StatusEffects.DwarfRage);
				maxTou += statusEffectv2(StatusEffects.DwarfRage);
				maxSpe += statusEffectv2(StatusEffects.DwarfRage);
			}
			//Trance Transformation
			if (hasStatusEffect(StatusEffects.TranceTransformation)) {
				maxStr += statusEffectv1(StatusEffects.TranceTransformation);
				maxTou += statusEffectv1(StatusEffects.TranceTransformation);
			}
			//Crinos Shape
			if (hasStatusEffect(StatusEffects.CrinosShape)) {
				maxStr += statusEffectv1(StatusEffects.CrinosShape);
				maxTou += statusEffectv2(StatusEffects.CrinosShape);
				maxSpe += statusEffectv3(StatusEffects.CrinosShape);
			}
			//
			if (hasStatusEffect(StatusEffects.ShiraOfTheEastFoodBuff2)) {
				if (statusEffectv1(StatusEffects.ShiraOfTheEastFoodBuff2) >= 1) maxStr += statusEffectv1(StatusEffects.ShiraOfTheEastFoodBuff2);
				maxTou += statusEffectv4(StatusEffects.ShiraOfTheEastFoodBuff2);
				if (statusEffectv2(StatusEffects.ShiraOfTheEastFoodBuff2) >= 1) maxSpe += statusEffectv2(StatusEffects.ShiraOfTheEastFoodBuff2);
				if (statusEffectv3(StatusEffects.ShiraOfTheEastFoodBuff2) >= 1) maxInt += statusEffectv3(StatusEffects.ShiraOfTheEastFoodBuff2);
			}
			//Beat of War
			if (hasStatusEffect(StatusEffects.BeatOfWar)) {
				maxStr += statusEffectv1(StatusEffects.BeatOfWar);
			}
			if (hasStatusEffect(StatusEffects.AndysSmoke)) {
				maxSpe -= statusEffectv2(StatusEffects.AndysSmoke);
				maxInt += statusEffectv3(StatusEffects.AndysSmoke);
			}
			if (hasStatusEffect(StatusEffects.FeedingEuphoria)) {
				maxSpe += statusEffectv2(StatusEffects.FeedingEuphoria);
			}
			if (hasStatusEffect(StatusEffects.BlessingOfDivineFenrir)) {
				maxStr += statusEffectv2(StatusEffects.BlessingOfDivineFenrir);
				maxTou += statusEffectv3(StatusEffects.BlessingOfDivineFenrir);
			}
			if (hasStatusEffect(StatusEffects.BlessingOfDivineTaoth)) {
				maxSpe += statusEffectv2(StatusEffects.BlessingOfDivineTaoth);
			}
			var vthirst:VampireThirstEffect = statusEffectByType(StatusEffects.VampireThirst) as VampireThirstEffect;
			if (vthirst != null) {
				maxStr += vthirst.currentBoost;
				maxSpe += vthirst.currentBoost;
				maxInt += vthirst.currentBoost;
				maxLib += vthirst.currentBoost;
			}
			if (hasStatusEffect(StatusEffects.UnderwaterCombatBoost)) {
				maxStr += statusEffectv1(StatusEffects.UnderwaterCombatBoost);
				maxSpe += statusEffectv2(StatusEffects.UnderwaterCombatBoost);
			}
			End("Player","getAllMaxStats.effects");
			End("Player","getAllMaxStats");
			maxStr = Math.max(maxStr,1);
			maxTou = Math.max(maxTou,1);
			maxSpe = Math.max(maxSpe,1);
			maxInt = Math.max(maxInt,1);
			maxWis = Math.max(maxWis,1);
			maxLib = Math.max(maxLib,1);
			maxSen = Math.max(maxSen,1);
			maxCor = Math.max(maxCor,1);
			return {
				str:maxStr,
				tou:maxTou,
				spe:maxSpe,
				inte:maxInt,
				wis:maxWis,
				lib:maxLib,
				sens:maxSen,
				cor:maxCor
			};
		}
		
		public function requiredXP():int {
			var temp:int = level * 100;
			if (temp > 15000) temp = 15000;
			return temp;
		}
		
		public function minotaurAddicted():Boolean {
			return findPerk(PerkLib.MinotaurCumResistance) < 0 && findPerk(PerkLib.ManticoreCumAddict) < 0 && (findPerk(PerkLib.MinotaurCumAddict) >= 0 || flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] >= 1);
		}
		public function minotaurNeed():Boolean {
			return findPerk(PerkLib.MinotaurCumResistance) < 0 && findPerk(PerkLib.ManticoreCumAddict) < 0 && flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] > 1;
		}

		public function clearStatuses(visibility:Boolean):void
		{
			if (hasStatusEffect(StatusEffects.DriderIncubusVenom))
			{
				str += statusEffectv2(StatusEffects.DriderIncubusVenom);
				removeStatusEffect(StatusEffects.DriderIncubusVenom);
				CoC.instance.mainView.statsView.showStatUp('str');
			}
			if(CoC.instance.monster.hasStatusEffect(StatusEffects.Sandstorm)) CoC.instance.monster.removeStatusEffect(StatusEffects.Sandstorm);
			if(hasStatusEffect(StatusEffects.DwarfRage)) {
				dynStats("str", -statusEffectv1(StatusEffects.DwarfRage),"tou", -statusEffectv2(StatusEffects.DwarfRage),"spe", -statusEffectv2(StatusEffects.DwarfRage), "scale", false);
				removeStatusEffect(StatusEffects.DwarfRage);
			}
			if(hasStatusEffect(StatusEffects.Berzerking)) {
				removeStatusEffect(StatusEffects.Berzerking);
			}
			if(hasStatusEffect(StatusEffects.Lustzerking)) {
				removeStatusEffect(StatusEffects.Lustzerking);
			}
			if(hasStatusEffect(StatusEffects.EverywhereAndNowhere)) {
				removeStatusEffect(StatusEffects.EverywhereAndNowhere);
			}
			if(CoC.instance.monster.hasStatusEffect(StatusEffects.TailWhip)) {
				CoC.instance.monster.removeStatusEffect(StatusEffects.TailWhip);
			}
			if(CoC.instance.monster.hasStatusEffect(StatusEffects.TwuWuv)) {
				inte += CoC.instance.monster.statusEffectv1(StatusEffects.TwuWuv);
				EngineCore.statScreenRefresh();
				CoC.instance.mainView.statsView.showStatUp( 'inte' );
			}
			if(hasStatusEffect(StatusEffects.NagaVenom)) {
				spe += statusEffectv1(StatusEffects.NagaVenom);
				CoC.instance.mainView.statsView.showStatUp( 'spe' );
				removeStatusEffect(StatusEffects.NagaVenom);
			}
			if(hasStatusEffect(StatusEffects.MedusaVenom)) {
				str += statusEffectv1(StatusEffects.MedusaVenom);
				tou += statusEffectv2(StatusEffects.MedusaVenom);
				spe += statusEffectv3(StatusEffects.MedusaVenom);
				inte += statusEffectv4(StatusEffects.MedusaVenom);
				CoC.instance.mainView.statsView.showStatUp( 'str' );
				CoC.instance.mainView.statsView.showStatUp( 'tou' );
				CoC.instance.mainView.statsView.showStatUp( 'spe' );
				CoC.instance.mainView.statsView.showStatUp( 'inte' );
				removeStatusEffect(StatusEffects.MedusaVenom);
			}
			if(hasStatusEffect(StatusEffects.Frostbite)) {
				str += statusEffectv1(StatusEffects.Frostbite);
				CoC.instance.mainView.statsView.showStatUp( 'str' );
				removeStatusEffect(StatusEffects.Frostbite);
			}
			if(hasStatusEffect(StatusEffects.Flying)) {
				removeStatusEffect(StatusEffects.Flying);
				if(hasStatusEffect(StatusEffects.FlyingNoStun)) {
					removeStatusEffect(StatusEffects.FlyingNoStun);
					removePerk(PerkLib.Resolute);
				}
			}
			if(hasStatusEffect(StatusEffects.Might)) {
				if (hasStatusEffect(StatusEffects.FortressOfIntellect)) dynStats("int", -statusEffectv1(StatusEffects.Might), "scale", false);
				else dynStats("str", -statusEffectv1(StatusEffects.Might), "scale", false);
				dynStats("tou", -statusEffectv2(StatusEffects.Might), "scale", false);
				removeStatusEffect(StatusEffects.Might);
			}
			if(hasStatusEffect(StatusEffects.Blink)) {
				dynStats("spe", -statusEffectv1(StatusEffects.Blink), "scale", false);
				removeStatusEffect(StatusEffects.Blink);
			}
			if(hasStatusEffect(StatusEffects.BeatOfWar)) {
				dynStats("str", -statusEffectv1(StatusEffects.BeatOfWar), "scale", false);
				removeStatusEffect(StatusEffects.BeatOfWar);
			}
			if(hasStatusEffect(StatusEffects.UnderwaterCombatBoost)) {
				dynStats("str", -statusEffectv1(StatusEffects.UnderwaterCombatBoost),"spe", -statusEffectv2(StatusEffects.UnderwaterCombatBoost), "scale", false);
				removeStatusEffect(StatusEffects.UnderwaterCombatBoost);
			}
			if(hasStatusEffect(StatusEffects.TranceTransformation)) {
				dynStats("str", -statusEffectv1(StatusEffects.TranceTransformation), "scale", false);
				dynStats("tou", -statusEffectv1(StatusEffects.TranceTransformation), "scale", false);
				removeStatusEffect(StatusEffects.TranceTransformation);
			}
			if(hasStatusEffect(StatusEffects.CrinosShape)) {
				dynStats("str", -statusEffectv1(StatusEffects.CrinosShape), "scale", false);
				dynStats("tou", -statusEffectv2(StatusEffects.CrinosShape), "scale", false);
				dynStats("spe", -statusEffectv3(StatusEffects.CrinosShape), "scale", false);
				removeStatusEffect(StatusEffects.CrinosShape);
			}
			if(hasStatusEffect(StatusEffects.EzekielCurse) && flags[kFLAGS.EVANGELINE_AFFECTION] >= 3 && findPerk(PerkLib.EzekielBlessing) >= 0) {
				removeStatusEffect(StatusEffects.EzekielCurse);
			}
			if(hasStatusEffect(StatusEffects.DragonBreathCooldown) && findPerk(PerkLib.DraconicLungsEvolved) >= 0) {
				removeStatusEffect(StatusEffects.DragonBreathCooldown);
			}
			if(hasStatusEffect(StatusEffects.DragonDarknessBreathCooldown) && findPerk(PerkLib.DraconicLungs) >= 0) {
				removeStatusEffect(StatusEffects.DragonDarknessBreathCooldown);
			}
			if(hasStatusEffect(StatusEffects.DragonFireBreathCooldown) && findPerk(PerkLib.DraconicLungs) >= 0) {
				removeStatusEffect(StatusEffects.DragonFireBreathCooldown);
			}
			if(hasStatusEffect(StatusEffects.DragonIceBreathCooldown) && findPerk(PerkLib.DraconicLungs) >= 0) {
				removeStatusEffect(StatusEffects.DragonIceBreathCooldown);
			}
			if(hasStatusEffect(StatusEffects.DragonLightningBreathCooldown) && findPerk(PerkLib.DraconicLungs) >= 0) {
				removeStatusEffect(StatusEffects.DragonLightningBreathCooldown);
			}
			if(hasStatusEffect(StatusEffects.HeroBane)) {
				removeStatusEffect(StatusEffects.HeroBane);
			}
			if(hasStatusEffect(StatusEffects.Disarmed)) {
				removeStatusEffect(StatusEffects.Disarmed);
				if (weapon == WeaponLib.FISTS) {
//					weapon = ItemType.lookupItem(flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID]) as Weapon;
//					(ItemType.lookupItem(flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID]) as Weapon).doEffect(this, false);
					setWeapon(ItemType.lookupItem(flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID]) as Weapon);
				}
				else {
					flags[kFLAGS.BONUS_ITEM_AFTER_COMBAT_ID] = flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID];
				}
			}
			if (hasStatusEffect(StatusEffects.DriderIncubusVenom))
			{
				str += statusEffectv2(StatusEffects.DriderIncubusVenom);
				removeStatusEffect(StatusEffects.DriderIncubusVenom);
			}
			
			// All CombatStatusEffects are removed here
			for (var a:/*StatusEffectClass*/Array=statusEffects.slice(),n:int=a.length,i:int=0;i<n;i++) {
				// Using a copy of array in case effects are removed/added in handler
				if (statusEffects.indexOf(a[i])>=0) a[i].onCombatEnd();
			}
		}

		public function consumeItem(itype:ItemType, amount:int = 1):Boolean {
			if (!hasItem(itype, amount)) {
				CoC_Settings.error("ERROR: consumeItem attempting to find " + amount + " item" + (amount > 1 ? "s" : "") + " to remove when the player has " + itemCount(itype) + ".");
				return false;
			}
			//From here we can be sure the player has enough of the item in inventory
			var slot:ItemSlotClass;
			while (amount > 0) {
				slot = getLowestSlot(itype); //Always draw from the least filled slots first
				if (slot.quantity > amount) {
					slot.quantity -= amount;
					amount = 0;
				}
				else { //If the slot holds the amount needed then amount will be zero after this
					amount -= slot.quantity;
					slot.emptySlot();
				}
			}
			return true;
/*			
			var consumed:Boolean = false;
			var slot:ItemSlotClass;
			while (amount > 0)
			{
				if(!hasItem(itype,1))
				{
					CoC_Settings.error("ERROR: consumeItem in items.as attempting to find an item to remove when the has none.");
					break;
				}
				trace("FINDING A NEW SLOT! (ITEMS LEFT: " + amount + ")");
				slot = getLowestSlot(itype);
				while (slot != null && amount > 0 && slot.quantity > 0)
				{
					amount--;
					slot.quantity--;
					if(slot.quantity == 0) slot.emptySlot();
					trace("EATIN' AN ITEM");
				}
				//If on slot 5 and it doesn't have any more to take, break out!
				if(slot == undefined) amount = -1

			}
			if(amount == 0) consumed = true;
			return consumed;
*/
		}

		public function getLowestSlot(itype:ItemType):ItemSlotClass
		{
			var minslot:ItemSlotClass = null;
			for each (var slot:ItemSlotClass in itemSlots) {
				if (slot.itype == itype) {
					if (minslot == null || slot.quantity < minslot.quantity) {
						minslot = slot;
					}
				}
			}
			return minslot;
		}
		
		public function hasItem(itype:ItemType, minQuantity:int = 1):Boolean {
			return itemCount(itype) >= minQuantity;
		}
		
		public function itemCount(itype:ItemType):int {
			var count:int = 0;
			for each (var itemSlot:ItemSlotClass in itemSlots){
				if (itemSlot.itype == itype) count += itemSlot.quantity;
			}
			return count;
		}

		// 0..5 or -1 if no
		public function roomInExistingStack(itype:ItemType):Number {
			for (var i:int = 0; i<itemSlots.length; i++){
				if(itemSlot(i).itype == itype && itemSlot(i).quantity != 0 && itemSlot(i).quantity < 5)
					return i;
			}
			return -1;
		}

		public function itemSlot(idx:int):ItemSlotClass
		{
			return itemSlots[idx];
		}

		// 0..5 or -1 if no
		public function emptySlot():Number {
		    for (var i:int = 0; i<itemSlots.length;i++){
				if (itemSlot(i).isEmpty() && itemSlot(i).unlocked) return i;
			}
			return -1;
		}


		public function destroyItems(itype:ItemType, numOfItemToRemove:Number):Boolean
		{
			for (var slotNum:int = 0; slotNum < itemSlots.length; slotNum += 1)
			{
				if(itemSlot(slotNum).itype == itype)
				{
					while(itemSlot(slotNum).quantity > 0 && numOfItemToRemove > 0)
					{
						itemSlot(slotNum).removeOneItem();
						numOfItemToRemove--;
					}
				}
			}
			return numOfItemToRemove <= 0;
		}

		public function lengthChange(temp2:Number, ncocks:Number):void {

			if (temp2 < 0 && flags[kFLAGS.HYPER_HAPPY])  // Early return for hyper-happy cheat if the call was *supposed* to shrink a cock.
			{
				return;
			}
			//DIsplay the degree of length change.
			if(temp2 <= 1 && temp2 > 0) {
				if(cocks.length == 1) outputText("Your [cock] has grown slightly longer.");
				if(cocks.length > 1) {
					if(ncocks == 1) outputText("One of your [cocks] grows slightly longer.");
					if(ncocks > 1 && ncocks < cocks.length) outputText("Some of your [cocks] grow slightly longer.");
					if(ncocks == cocks.length) outputText("Your [cocks] seem to fill up... growing a little bit larger.");
				}
			}
			if(temp2 > 1 && temp2 < 3) {
				if(cocks.length == 1) outputText("A very pleasurable feeling spreads from your groin as your [cock] grows permanently longer - at least an inch - and leaks pre-cum from the pleasure of the change.");
				if(cocks.length > 1) {
					if(ncocks == cocks.length) outputText("A very pleasurable feeling spreads from your groin as your [cocks] grow permanently longer - at least an inch - and leak plenty of pre-cum from the pleasure of the change.");
					if(ncocks == 1) outputText("A very pleasurable feeling spreads from your groin as one of your [cocks] grows permanently longer, by at least an inch, and leaks plenty of pre-cum from the pleasure of the change.");
					if(ncocks > 1 && ncocks < cocks.length) outputText("A very pleasurable feeling spreads from your groin as " + num2Text(ncocks) + " of your [cocks] grow permanently longer, by at least an inch, and leak plenty of pre-cum from the pleasure of the change.");
				}
			}
			if(temp2 >=3){
				if(cocks.length == 1) outputText("Your [cock] feels incredibly tight as a few more inches of length seem to pour out from your crotch.");
				if(cocks.length > 1) {
					if(ncocks == 1) outputText("Your [cocks] feel incredibly tight as one of their number begins to grow inch after inch of length.");
					if(ncocks > 1 && ncocks < cocks.length) outputText("Your [cocks] feel incredibly number as " + num2Text(ncocks) + " of them begin to grow inch after inch of added length.");
					if(ncocks == cocks.length) outputText("Your [cocks] feel incredibly tight as inch after inch of length pour out from your groin.");
				}
			}
			//Display LengthChange
			if(temp2 > 0) {
				if(cocks[0].cockLength >= 8 && cocks[0].cockLength-temp2 < 8){
					if(cocks.length == 1) outputText("  <b>Most men would be overly proud to have a tool as long as yours.</b>");
					if(cocks.length > 1) outputText("  <b>Most men would be overly proud to have one cock as long as yours, let alone " + multiCockDescript() + ".</b>");
				}
				if(cocks[0].cockLength >= 12 && cocks[0].cockLength-temp2 < 12) {
					if(cocks.length == 1) outputText("  <b>Your [cock] is so long it nearly swings to your knee at its full length.</b>");
					if(cocks.length > 1) outputText("  <b>Your [cocks] are so long they nearly reach your knees when at full length.</b>");
				}
				if(cocks[0].cockLength >= 16 && cocks[0].cockLength-temp2 < 16) {
					if(cocks.length == 1) outputText("  <b>Your [cock] would look more at home on a large horse than you.</b>");
					if(cocks.length > 1) outputText("  <b>Your [cocks] would look more at home on a large horse than on your body.</b>");
					if (biggestTitSize() >= BreastCup.C) {
						if (cocks.length == 1) outputText("  You could easily stuff your [cock] between your breasts and give yourself the titty-fuck of a lifetime.");
						if (cocks.length > 1) outputText("  They reach so far up your chest it would be easy to stuff a few cocks between your breasts and give yourself the titty-fuck of a lifetime.");
					}
					else {
						if(cocks.length == 1) outputText("  Your [cock] is so long it easily reaches your chest.  The possibility of autofellatio is now a foregone conclusion.");
						if(cocks.length > 1) outputText("  Your [cocks] are so long they easily reach your chest.  Autofellatio would be about as hard as looking down.");
					}
				}
				if(cocks[0].cockLength >= 20 && cocks[0].cockLength-temp2 < 20) {
					if(cocks.length == 1) outputText("  <b>As if the pulsing heat of your [cock] wasn't enough, the tip of your [cock] keeps poking its way into your view every time you get hard.</b>");
					if(cocks.length > 1) outputText("  <b>As if the pulsing heat of your [cocks] wasn't bad enough, every time you get hard, the tips of your [cocks] wave before you, obscuring the lower portions of your vision.</b>");
					if(cor > 40 && cor <= 60) {
						if(cocks.length > 1) outputText("  You wonder if there is a demon or beast out there that could take the full length of one of your [cocks]?");
						if(cocks.length ==1) outputText("  You wonder if there is a demon or beast out there that could handle your full length.");
					}
					if(cor > 60 && cor <= 80) {
						if(cocks.length > 1) outputText("  You daydream about being attacked by a massive tentacle beast, its tentacles engulfing your [cocks] to their hilts, milking you dry.\n\nYou smile at the pleasant thought.");
						if(cocks.length ==1) outputText("  You daydream about being attacked by a massive tentacle beast, its tentacles engulfing your [cock] to the hilt, milking it of all your cum.\n\nYou smile at the pleasant thought.");
					}
					if(cor > 80) {
						if(cocks.length > 1) outputText("  You find yourself fantasizing about impaling nubile young champions on your [cocks] in a year's time.");
					}
				}
			}
			//Display the degree of length loss.
			if(temp2 < 0 && temp2 >= -1) {
				if(cocks.length == 1) outputText("Your [cocks] has shrunk to a slightly shorter length.");
				if(cocks.length > 1) {
					if(ncocks == cocks.length) outputText("Your [cocks] have shrunk to a slightly shorter length.");
					if(ncocks > 1 && ncocks < cocks.length) outputText("You feel " + num2Text(ncocks) + " of your [cocks] have shrunk to a slightly shorter length.");
					if(ncocks == 1) outputText("You feel " + num2Text(ncocks) + " of your [cocks] has shrunk to a slightly shorter length.");
				}
			}
			if(temp2 < -1 && temp2 > -3) {
				if(cocks.length == 1) outputText("Your [cocks] shrinks smaller, flesh vanishing into your groin.");
				if(cocks.length > 1) {
					if(ncocks == cocks.length) outputText("Your [cocks] shrink smaller, the flesh vanishing into your groin.");
					if(ncocks == 1) outputText("You feel " + num2Text(ncocks) + " of your [cocks] shrink smaller, the flesh vanishing into your groin.");
					if(ncocks > 1 && ncocks < cocks.length) outputText("You feel " + num2Text(ncocks) + " of your [cocks] shrink smaller, the flesh vanishing into your groin.");
				}
			}
			if(temp2 <= -3) {
				if(cocks.length == 1) outputText("A large portion of your [cocks]'s length shrinks and vanishes.");
				if(cocks.length > 1) {
					if(ncocks == cocks.length) outputText("A large portion of your [cocks] recedes towards your groin, receding rapidly in length.");
					if(ncocks == 1) outputText("A single member of your [cocks] vanishes into your groin, receding rapidly in length.");
					if(ncocks > 1 && cocks.length > ncocks) outputText("Your [cocks] tingles as " + num2Text(ncocks) + " of your members vanish into your groin, receding rapidly in length.");
				}
			}
		}

		public function killCocks(deadCock:Number):void
		{
			//Count removal for text bits
			var removed:Number = 0;
			var temp:Number;
			//Holds cock index
			var storedCock:Number = 0;
			//Less than 0 = PURGE ALL
			if (deadCock < 0) {
				deadCock = cocks.length;
			}
			//Double loop - outermost counts down cocks to remove, innermost counts down
			while (deadCock > 0) {
				//Find shortest cock and prune it
				temp = cocks.length;
				while (temp > 0) {
					temp--;
					//If anything is out of bounds set to 0.
					if (storedCock > cocks.length - 1) storedCock = 0;
					//If temp index is shorter than stored index, store temp to stored index.
					if (cocks[temp].cockLength <= cocks[storedCock].cockLength) storedCock = temp;
				}
				//Smallest cock should be selected, now remove it!
				removeCock(storedCock, 1);
				removed++;
				deadCock--;
				if (cocks.length == 0) deadCock = 0;
			}
			//Texts
			if (removed == 1) {
				if (cocks.length == 0) {
					outputText("<b>Your manhood shrinks into your body, disappearing completely.</b>");
					if (hasStatusEffect(StatusEffects.Infested)) outputText("  Like rats fleeing a sinking ship, a stream of worms squirts free from your withering member, slithering away.");
				}
				if (cocks.length == 1) {
					outputText("<b>Your smallest penis disappears, shrinking into your body and leaving you with just one [cock].</b>");
				}
				if (cocks.length > 1) {
					outputText("<b>Your smallest penis disappears forever, leaving you with just your [cocks].</b>");
				}
			}
			if (removed > 1) {
				if (cocks.length == 0) {
					outputText("<b>All your male endowments shrink smaller and smaller, disappearing one at a time.</b>");
					if (hasStatusEffect(StatusEffects.Infested)) outputText("  Like rats fleeing a sinking ship, a stream of worms squirts free from your withering member, slithering away.");
				}
				if (cocks.length == 1) {
					outputText("<b>You feel " + num2Text(removed) + " cocks disappear into your groin, leaving you with just your [cock].");
				}
				if (cocks.length > 1) {
					outputText("<b>You feel " + num2Text(removed) + " cocks disappear into your groin, leaving you with [cocks].");
				}
			}
			//remove infestation if cockless
			if (cocks.length == 0) removeStatusEffect(StatusEffects.Infested);
			if (cocks.length == 0 && balls > 0) {
				outputText("  <b>Your " + sackDescript() + " and [balls] shrink and disappear, vanishing into your groin.</b>");
				balls = 0;
				ballSize = 1;
			}
		}
		public function modCumMultiplier(delta:Number):Number
		{
			trace("modCumMultiplier called with: " + delta);
		
			if (delta == 0) {
				trace( "Whoops! modCumMuliplier called with 0... aborting..." );
				return delta;
			}
			else if (delta > 0) {
				trace("and increasing");
				if (findPerk(PerkLib.MessyOrgasms) >= 0) {
					trace("and MessyOrgasms found");
					delta *= 1.5
				}
			}
			else if (delta < 0) {
				trace("and decreasing");
				if (findPerk(PerkLib.MessyOrgasms) >= 0) {
					trace("and MessyOrgasms found");
					delta *= 0.5
				}
			}

			trace("and modifying by " + delta);
			cumMultiplier += delta;
			return delta;
		}

		public function increaseCock(cockNum:Number, lengthDelta:Number):Number
		{
			var bigCock:Boolean = false;
	
			if (findPerk(PerkLib.BigCock) >= 0)
				bigCock = true;

			return cocks[cockNum].growCock(lengthDelta, bigCock);
		}
		
		public function increaseEachCock(lengthDelta:Number):Number
		{
			var totalGrowth:Number = 0;
			
			for (var i:Number = 0; i < cocks.length; i++) {
				trace( "increaseEachCock at: " + i);
				totalGrowth += increaseCock(i as Number, lengthDelta);
			}
			
			return totalGrowth;
		}
		
		// Attempts to put the player in heat (or deeper in heat).
		// Returns true if successful, false if not.
		// The player cannot go into heat if she is already pregnant or is a he.
		// 
		// First parameter: boolean indicating if function should output standard text.
		// Second parameter: intensity, an integer multiplier that can increase the 
		// duration and intensity. Defaults to 1.
		public function goIntoHeat(output:Boolean, intensity:int = 1):Boolean {
			if(!hasVagina() || pregnancyIncubation != 0) {
				// No vagina or already pregnant, can't go into heat.
				return false;
			}
			
			//Already in heat, intensify further.
			if (inHeat) {
				if(output) {
					outputText("\n\nYour mind clouds as your " + vaginaDescript(0) + " moistens.  Despite already being in heat, the desire to copulate constantly grows even larger.");
				}
				var sac:StatusEffectClass = statusEffectByType(StatusEffects.Heat);
				sac.value1 += 5 * intensity;
				sac.value2 += 5 * intensity;
				sac.value3 += 48 * intensity;
				dynStats("lib", 5 * intensity, "scale", false);
			}
			//Go into heat.  Heats v1 is bonus fertility, v2 is bonus libido, v3 is hours till it's gone
			else {
				if(output) {
					outputText("\n\nYour mind clouds as your " + vaginaDescript(0) + " moistens.  Your hands begin stroking your body from top to bottom, your sensitive skin burning with desire.  Fantasies about bending over and presenting your needy pussy to a male overwhelm you as <b>you realize you have gone into heat!</b>");
				}
				createStatusEffect(StatusEffects.Heat, 10 * intensity, 15 * intensity, 48 * intensity, 0);
				dynStats("lib", 15 * intensity, "scale", false);
			}
			return true;
		}
		
		// Attempts to put the player in rut (or deeper in heat).
		// Returns true if successful, false if not.
		// The player cannot go into heat if he is a she.
		// 
		// First parameter: boolean indicating if function should output standard text.
		// Second parameter: intensity, an integer multiplier that can increase the 
		// duration and intensity. Defaults to 1.
		public function goIntoRut(output:Boolean, intensity:int = 1):Boolean {
			if (!hasCock()) {
				// No cocks, can't go into rut.
				return false;
			}
			
			//Has rut, intensify it!
			if (inRut) {
				if(output) {
					outputText("\n\nYour [cock] throbs and dribbles as your desire to mate intensifies.  You know that <b>you've sunken deeper into rut</b>, but all that really matters is unloading into a cum-hungry cunt.");
				}
				
				addStatusValue(StatusEffects.Rut, 1, 100 * intensity);
				addStatusValue(StatusEffects.Rut, 2, 5 * intensity);
				addStatusValue(StatusEffects.Rut, 3, 48 * intensity);
				dynStats("lib", 5 * intensity, "scale", false);
			}
			else {
				if(output) {
					outputText("\n\nYou stand up a bit straighter and look around, sniffing the air and searching for a mate.  Wait, what!?  It's hard to shake the thought from your head - you really could use a nice fertile hole to impregnate.  You slap your forehead and realize <b>you've gone into rut</b>!");
				}
				
				//v1 - bonus cum production
				//v2 - bonus libido
				//v3 - time remaining!
				createStatusEffect(StatusEffects.Rut, 150 * intensity, 5 * intensity, 100 * intensity, 0);
				dynStats("lib", 5 * intensity, "scale", false);
			}
			
			return true;
		}
		public function orgasmReal():void
		{
			dynStats("lus=", 0, "sca", false);
			hoursSinceCum = 0;
			flags[kFLAGS.TIMES_ORGASMED]++;

			if (countCockSocks("gilded") > 0) {
				var randomCock:int = rand( cocks.length );
				var bonusGems:int = rand( cocks[randomCock].cockThickness ) + countCockSocks("gilded"); // int so AS rounds to whole numbers
				EngineCore.outputText("\n\nFeeling some minor discomfort in your " + cockDescript(randomCock) + " you slip it out of your [armor] and examine it. <b>With a little exploratory rubbing and massaging, you manage to squeeze out " + bonusGems + " gems from its cum slit.</b>\n\n");
				gems += bonusGems;
			}
		}
		public function orgasm(type:String = 'Default', real:Boolean = true):void
		{
			switch (type) {
					// Start with that, whats easy
				case 'Vaginal': //if (CoC.instance.bimboProgress.ableToProgress() || flags[kFLAGS.TIMES_ORGASM_VAGINAL] < 10) flags[kFLAGS.TIMES_ORGASM_VAGINAL]++;
					break;
				case 'Anal':    //if (CoC.instance.bimboProgress.ableToProgress() || flags[kFLAGS.TIMES_ORGASM_ANAL]    < 10) flags[kFLAGS.TIMES_ORGASM_ANAL]++;
					break;
				case 'Dick':    //if (CoC.instance.bimboProgress.ableToProgress() || flags[kFLAGS.TIMES_ORGASM_DICK]    < 10) flags[kFLAGS.TIMES_ORGASM_DICK]++;
					break;
				case 'Lips':    //if (CoC.instance.bimboProgress.ableToProgress() || flags[kFLAGS.TIMES_ORGASM_LIPS]    < 10) flags[kFLAGS.TIMES_ORGASM_LIPS]++;
					break;
				case 'Tits':    //if (CoC.instance.bimboProgress.ableToProgress() || flags[kFLAGS.TIMES_ORGASM_TITS]    < 10) flags[kFLAGS.TIMES_ORGASM_TITS]++;
					break;
				case 'Nipples': //if (CoC.instance.bimboProgress.ableToProgress() || flags[kFLAGS.TIMES_ORGASM_NIPPLES] < 10) flags[kFLAGS.TIMES_ORGASM_NIPPLES]++;
					break;
				case 'Ovi':     break;

					// Now to the more complex types
				case 'VaginalAnal':
					orgasm((hasVagina() ? 'Vaginal' : 'Anal'), real);
					return; // Prevent calling orgasmReal() twice

				case 'DickAnal':
					orgasm((rand(2) == 0 ? 'Dick' : 'Anal'), real);
					return;

				case 'Default':
				case 'Generic':
				default:
					if (!hasVagina() && !hasCock()) {
						orgasm('Anal'); // Failsafe for genderless PCs
						return;
					}

					if (hasVagina() && hasCock()) {
						orgasm((rand(2) == 0 ? 'Vaginal' : 'Dick'), real);
						return;
					}

					orgasm((hasVagina() ? 'Vaginal' : 'Dick'), real);
					return;
			}

			if (real) orgasmReal();
		}
		public function orgasmRaijuStyle():void
		{
			if (game.player.hasStatusEffect(StatusEffects.RaijuLightningStatus)) {
				EngineCore.outputText("\n\nAs you finish masturbating you feel a jolt in your genitals, as if for a small moment the raiju discharge was brought back, increasing the intensity of the pleasure and your desire to touch yourself. Electricity starts coursing through your body again by intermittence as something in you begins to change.");
				game.player.addStatusValue(StatusEffects.RaijuLightningStatus,1,6);
				dynStats("lus", (60 + rand(20)), "sca", false);
				game.mutations.voltageTopaz(false,CoC.instance.player);
			}
			else {
				EngineCore.outputText("\n\nAfter this electrifying orgasm your lust only raise sky high above. You will need a partner to fuck with in order to discharge your ramping up desire and electricity.");
				dynStats("lus", (maxLust() * 0.1), "sca", false);
			}
			hoursSinceCum = 0;
			flags[kFLAGS.TIMES_ORGASMED]++;
		}
		public function penetrated(where:ISexyPart, tool:ISexyPart, options:Object = null):void {
			options = Utils.extend({
				display:true,
				orgasm:false
			},options||{});

			if (where.host != null && where.host != this) {
				trace("Penetration confusion! Host is "+where.host);
				return;
			}

			var size:Number = 8;
			if ('size' in options) size = options.size;
			else if (tool is Cock) size = (tool as Cock).cArea();

			var otype:String = 'Default';
			if (where is AssClass) {
				buttChange(size, options.display);
				otype = 'Anal';
			} else if (where is VaginaClass) {
				cuntChange(size, options.display);
				otype = 'Vaginal';
			}
			if (options.orgasm) {
				orgasm(otype);
			}
		}
		
		protected override function maxHP_base():Number {
			var max:Number = super.maxHP_base();
			if (alicornScore() >= 11) max += (150 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (centaurScore() >= 8) max += (100 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (dragonScore() >= 4) max += (100 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (dragonScore() >= 10) max += (100 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (dragonScore() >= 20) max += (100 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (dragonScore() >= 28) max += (100 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (gorgonScore() >= 11) max += (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (horseScore() >= 4) max += (35 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (horseScore() >= 7) max += (35 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (manticoreScore() >= 6) max += (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (rhinoScore() >= 4) max += (100 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (scyllaScore() >= 4) max += (25 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (scyllaScore() >= 7) max += (25 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (scyllaScore() >= 12) max += (100 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (unicornScore() >= 9) max += (120 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			
			return max;
		}
		protected override function maxLust_base():Number {
			var max:Number = super.maxLust_base();
			if (cowScore() >= 4) max += (25 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (cowScore() >= 9) max += (25 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (demonScore() >= 5) max += (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (demonScore() >= 11) max += (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (devilkinScore() >= 7) max += (75 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (devilkinScore() >= 10) max += (75 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (dragonScore() >= 20) max += (25 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (dragonScore() >= 28) max += (25 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (minotaurScore() >= 4) max += (25 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (minotaurScore() >= 9) max += (25 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (phoenixScore() >= 5) max += (25 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (salamanderScore() >= 4) max += (25 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (sharkScore() >= 9 && vaginas.length > 0 && cocks.length > 0) max += (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			
			return max;
		}
		
		override public function modStats(dstr:Number, dtou:Number, dspe:Number, dinte:Number, dwis:Number,dlib:Number, dsens:Number, dlust:Number, dcor:Number, scale:Boolean, max:Boolean):void {
			//Easy mode cuts lust gains!
			if (flags[kFLAGS.EASY_MODE_ENABLE_FLAG] == 1 && dlust > 0 && scale) dlust /= 2;
			
			//Set original values to begin tracking for up/down values if
			//they aren't set yet.
			//These are reset when up/down arrows are hidden with
			//hideUpDown();
			//Just check str because they are either all 0 or real values
			if(game.oldStats.oldStr == 0) {
				game.oldStats.oldStr = str;
				game.oldStats.oldTou = tou;
				game.oldStats.oldSpe = spe;
				game.oldStats.oldInte = inte;
				game.oldStats.oldWis = wis;
				game.oldStats.oldLib = lib;
				game.oldStats.oldSens = sens;
				game.oldStats.oldCor = cor;
				game.oldStats.oldHP = HP;
				game.oldStats.oldLust = lust;
				game.oldStats.oldFatigue = fatigue;
				game.oldStats.oldSoulforce = soulforce;
				game.oldStats.oldHunger = hunger;
			}
			if (scale) {
				//MOD CHANGES FOR PERKS
				//Bimbos learn slower
				if (findPerk(PerkLib.FutaFaculties) >= 0 || findPerk(PerkLib.BimboBrains) >= 0 || findPerk(PerkLib.BroBrains) >= 0) {
					if (dinte > 0) dinte /= 2;
					if (dinte < 0) dinte *= 2;
				}
				if (findPerk(PerkLib.FutaForm) >= 0 || findPerk(PerkLib.BimboBody) >= 0 || findPerk(PerkLib.BroBody) >= 0) {
					if (dlib > 0) dlib *= 2;
					if (dlib < 0) dlib /= 2;
				}
				
				// Uma's Perkshit
				if (findPerk(PerkLib.ChiReflowSpeed) >= 0 && dspe < 0) dspe *= UmasShop.NEEDLEWORK_SPEED_SPEED_MULTI;
				if (findPerk(PerkLib.ChiReflowLust) >= 0 && dlib > 0) dlib *= UmasShop.NEEDLEWORK_LUST_LIBSENSE_MULTI;
				if (findPerk(PerkLib.ChiReflowLust) >= 0 && dsens > 0) dsens *= UmasShop.NEEDLEWORK_LUST_LIBSENSE_MULTI;
				
				//Apply lust changes in NG+.
				dlust *= 1 + (newGamePlusMod() * 0.2);
				
				//lust resistance
				if (dlust > 0 && scale) dlust *= EngineCore.lustPercent() / 100;
				if (dlib > 0 && findPerk(PerkLib.PurityBlessing) >= 0) dlib *= 0.75;
				if (dcor > 0 && findPerk(PerkLib.PurityBlessing) >= 0) dcor *= 0.5;
				if (dcor > 0 && findPerk(PerkLib.PureAndLoving) >= 0) dcor *= 0.75;
				if (dcor > 0 && weapon == game.weapons.HNTCANE) dcor *= 0.5;
				if (findPerk(PerkLib.AscensionMoralShifter) >= 0) dcor *= 1 + (perkv1(PerkLib.AscensionMoralShifter) * 0.2);
				if (hasStatusEffect(StatusEffects.BlessingOfDivineFera)) dcor *= 2;
				
				if (sens > 50 && dsens > 0) dsens /= 2;
				if (sens > 75 && dsens > 0) dsens /= 2;
				if (sens > 90 && dsens > 0) dsens /= 2;
				if (sens > 50 && dsens < 0) dsens *= 2;
				if (sens > 75 && dsens < 0) dsens *= 2;
				if (sens > 90 && dsens < 0) dsens *= 2;
				
				
				//Bonus gain for perks!
				if (findPerk(PerkLib.Strong) >= 0) dstr += dstr * perk(findPerk(PerkLib.Strong)).value1;
				if (findPerk(PerkLib.Tough) >= 0) dtou += dtou * perk(findPerk(PerkLib.Tough)).value1;
				if (findPerk(PerkLib.Fast) >= 0) dspe += dspe * perk(findPerk(PerkLib.Fast)).value1;
				if (findPerk(PerkLib.Smart) >= 0) dinte += dinte * perk(findPerk(PerkLib.Smart)).value1;
				if (findPerk(PerkLib.Lusty) >= 0) dlib += dlib * perk(findPerk(PerkLib.Lusty)).value1;
				if (findPerk(PerkLib.Sensitive) >= 0) dsens += dsens * perk(findPerk(PerkLib.Sensitive)).value1;
				
				// Uma's Str Cap from Perks (Moved to max stats)
				/*if (findPerk(PerkLib.ChiReflowSpeed) >= 0)
				{
					if (str > UmasShop.NEEDLEWORK_SPEED_STRENGTH_CAP)
					{
						str = UmasShop.NEEDLEWORK_SPEED_STRENGTH_CAP;
					}
				}
				if (findPerk(PerkLib.ChiReflowDefense) >= 0)
				{
					if (spe > UmasShop.NEEDLEWORK_DEFENSE_SPEED_CAP)
					{
						spe = UmasShop.NEEDLEWORK_DEFENSE_SPEED_CAP;
					}
				}*/
			}
			//Change original stats
			super.modStats(dstr,dtou,dspe,dinte,dwis,dlib,dsens,dlust,dcor,false,max);
			//Refresh the stat pane with updated values
			//mainView.statsView.showUpDown();
			EngineCore.showUpDown();
			EngineCore.statScreenRefresh();
		}
	}
}
