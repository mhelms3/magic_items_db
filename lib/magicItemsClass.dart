// ignore: file_names
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class MagicItem
{
  final int id;
  final String itemName;
  final String itemAura;
  final String itemCL;
  final String itemSlot;
  final String itemPrice;
  final String itemWeight;
  final String itemDescription;
  final String itemRequirements;
  final String itemCost;
  final String itemGroup;
  final String itemSource;
  final String itemFullText;
  final int itemMinorArtifactFlag;
  final int itemMajorArtifactFlag;
  final int itemAbjuration;
  final int itemConjuration;
  final int itemDivination;
  final int itemEnchantment;
  final int itemEvocation;
  final int itemNecromancy;
  final int itemTransmutation;
  final String itemAuraStrength;
  final int itemWeightValue;
  final int itemPriceValue;
  final int itemCostValue;
  final String itemLinkText;

  MagicItem(
  {
    required this.id,
    required this.itemName,
    required this.itemAura,
    required this.itemCL,
    required this.itemSlot,
    required this.itemPrice,
    required this.itemWeight,
    required this.itemDescription,
    required this.itemRequirements,
    required this.itemCost,
    required this.itemGroup,
    required this.itemSource,
    required this.itemFullText,
    required this.itemMinorArtifactFlag,
    required this.itemMajorArtifactFlag,
    required this.itemAbjuration,
    required this.itemConjuration,
    required this.itemDivination,
    required this.itemEnchantment,
    required this.itemEvocation,
    required this.itemNecromancy,
    required this.itemTransmutation,
    required this.itemAuraStrength,
    required this.itemWeightValue,
    required this.itemPriceValue,
    required this.itemCostValue,
    required this.itemLinkText,
  });
}

class SmallMagicItem
{
    final int id;
    final String itemName;
    final String itemAura;
    final String itemCL;
    final String itemSlot;
    final int itemPriceValue;
    final int itemCostValue;
    final String itemLinkText;

    SmallMagicItem(
      {
        required this.id,
        required this.itemName,
        required this.itemAura,
        required this.itemCL,
        required this.itemSlot,
        required this.itemPriceValue,
        required this.itemCostValue,
        required this.itemLinkText,
      });

    void printMagicItem()
    {
      print ("Name: $itemName CL: $itemCL Slot: $itemSlot Price: $itemPriceValue");
    }
}

class ClassLevel{
  final int sorLvl;
  final int wizLvl;
  final int clericLvl;
  final int druidLvl;
  final int rangerLvl;
  final int bardLvl;
  final int paladinLvl;
  final int alchemistLvl;
  final int summonerLvl;
  final int witchLvl;
  final int inquisitorLvl;
  final int antiPaladinLvl;
  final int magusLvl;
  final int adeptLvl;
  final int bloodragerLvl;
  final int psychicLvl;
  final int mediumLvl;
  final int mesmeristLvl;
  final int occultistLvl;
  final int spiritualistLvl;
  final int skaldLvl;
  final int investigatorLvl;
  final int hunterLevel;
  final int summonerLevel;

  ClassLevel(
  {
    required this.sorLvl,
    required this.wizLvl,
    required this.clericLvl,
    required this.druidLvl,
    required this.rangerLvl,
    required this.bardLvl,
    required this.paladinLvl,
    required this.alchemistLvl,
    required this.summonerLvl,
    required this.witchLvl,
    required this.inquisitorLvl,
    required this.antiPaladinLvl,
    required this.magusLvl,
    required this.adeptLvl,
    required this.bloodragerLvl,
    required this.psychicLvl,
    required this.mediumLvl,
    required this.mesmeristLvl,
    required this.occultistLvl,
    required this.spiritualistLvl,
    required this.skaldLvl,
    required this.investigatorLvl,
    required this.hunterLevel,
    required this.summonerLevel,
  });

}

class SmallSpell
{
  final int id;
  final String spellName;
  final String school;
  final String subSchool;
  final String descriptor;
  final String spellLevel;
  final String castingTime;
  final String range;
  final String area;
  final String effect;
  final String targets;
  final String duration;
  final String description;
  final int SLA;
  //final ClassLevel classLevel;
  final String materialCosts;

  SmallSpell(
      {
        required this.id,
        required this.spellName,
        required this.school,
        required this.subSchool,
        required this.descriptor,
        required this.spellLevel,
        required this.castingTime,
        required this.range,
        required this.area,
        required this.effect,
        required this.targets,
        required this.duration,
        required this.description,
        required this.SLA,
        required this.materialCosts,

      });

  void printSpell()
  {
    print ("$spellName# $school# $subSchool# $range# $targets# $description");
  }

  void writeSpell(File out)
  {
        out.writeAsString("$spellName, $SLA, $range, $castingTime, $targets");
  }

}

String checkNullS (String ?toCheck)
{
  if (toCheck == null)
    {return (" ");}
  else
    {return (toCheck);}
}

int checkNullI (int ?toCheck)
{
  if (toCheck == null)
  {return (0);}
  else
  {return (toCheck);}
}

bool checkPotionCastingTime (String castingTime)
{
  List<String> legitTimes = ["1 swift action", "3 rounds", "3 full rounds", "full-round action", "standard action", "1 standard action", "1 swift action", "1 round", "1 full round", "1 full-round action", "1 immediate action"];

  if (legitTimes.contains(castingTime))
    return (true);
  else
    return (false);

}

bool checkPotionTargets (String targets) {
  bool isLegit = false;

  List<String> legitTargetSubStrings = [
    "one",
    "creature",
    "object",
    "touched",
    "up to",
    "weapon"
  ];

  legitTargetSubStrings.forEach((subStr)
  {
   if (targets.contains(subStr)) {
        isLegit = true;
      }
  });

  return(isLegit);
}

bool checkPotion (SmallSpell s)
{

  bool inTime = false;
  bool onTarget = false;
  bool isNecro = false;

  if (s.school.contains("necro"))
    isNecro = true;


  if (checkPotionCastingTime(s.castingTime))
    inTime = true;

  if (checkPotionTargets(s.targets))
    onTarget = true;

  if ((s.range != "personal") && (s.SLA < 4) && inTime && onTarget && !isNecro)
    {
      return (true);
    }
  else
    {
      return (false);
    }
}

Future<List<SmallMagicItem>> getMagicItems(db) async {
  //final List<Map<String, dynamic>> results = await db.query('MagicItems');
  final List<Map<String, dynamic>> results = await db.rawQuery('SELECT * from "MagicItems" where CL = "5" and CostValue < 1000 ');
  //final List<Map<String, dynamic>> results2 = await db.rawQuery('SELECT * from "SpellFull" where descriptor = "acid" and sor = 2 ');


  return (List.generate(results.length, (i) {


    SmallMagicItem s = SmallMagicItem(
      id: results[i]['id'],
      itemAura: checkNullS(results[i]['Aura']),
      itemName: checkNullS(results[i]['Name']),
      itemCL: checkNullS(results[i]['CL']),
      itemSlot: checkNullS(results[i]['Slot']),
      itemPriceValue: checkNullI(results[i]['PriceValue']),
      itemCostValue: checkNullI(results[i]['CostValue']),
      itemLinkText: checkNullS(results[i]['LinkText']),
    );

    //s.printMagicItem();
    return (s);
  })
  );
}



Future<List<SmallSpell>> getSpellList(db) async {


  final List<Map<String, dynamic>> results = await db.rawQuery('SELECT * from "SpellFull" where SLA_Level < 4');
  int numPots = 0;


  return (List.generate(results.length, (i) {
    //print ("Name: ${results[i]['name']} spellLevel: ${results[i]['spell_level']} SLA Level: ${results[i]['SLA_Level']}");

    SmallSpell thisSpell = SmallSpell(
      id:results[i]['id'],
      spellName: checkNullS(results[i]['name']),
      school:checkNullS(results[i]['school']),
      subSchool:checkNullS(results[i]['subschool']),
      descriptor:checkNullS(results[i]['descriptor']),
      castingTime: checkNullS(results[i]['casting_time']),
      spellLevel:checkNullS(results[i]['spell_level']),
      range:checkNullS(results[i]['range']),
      area:checkNullS(results[i]['area']),
      effect:checkNullS(results[i]['effect']),
      targets:checkNullS(results[i]['targets']),
      duration:checkNullS(results[i]['duration']),
      description:checkNullS(results[i]['description']),
      SLA:checkNullI(results[i]['SLA_Level']),
      materialCosts:checkNullS(results[i]['material_costs']),
    );


      if(checkPotion (thisSpell))
        {
          //if (thisSpell.school.contains("evocation"))
          //{
              thisSpell.printSpell();
              //thisSpell.writeSpell(outFile);
           // }
        }
      return(thisSpell);

  })
  );

}


