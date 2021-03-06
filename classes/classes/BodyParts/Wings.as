package classes.BodyParts {
import classes.Creature;

public class Wings extends BodyPart {
	public static const NONE:int                 = 0;
	public static const BEE_LIKE_SMALL:int       = 1;
	public static const BEE_LIKE_LARGE:int       = 2;
	public static const HARPY:int                = 4;
	public static const IMP:int                  = 5;
	public static const BAT_LIKE_TINY:int        = 6;
	public static const BAT_LIKE_LARGE:int       = 7;
	public static const SHARK_FIN:int            = 8;
	public static const FEATHERED_LARGE:int      = 9;
	public static const DRACONIC_SMALL:int       = 10;
	public static const DRACONIC_LARGE:int       = 11;
	public static const GIANT_DRAGONFLY:int      = 12;
	public static const BAT_LIKE_LARGE_2:int     = 13;
	public static const DRACONIC_HUGE:int        = 14;
	public static const FEATHERED_PHOENIX:int    = 15;
	public static const FEATHERED_ALICORN:int    = 16;
	public static const MANTIS_LIKE_SMALL:int    = 17;
	public static const MANTIS_LIKE_LARGE:int    = 18;
	public static const MANTIS_LIKE_LARGE_2:int  = 19;
	public static const GARGOYLE_LIKE_LARGE:int  = 20;
	public static const PLANT:int                = 21;
	public static const MANTICORE_LIKE_SMALL:int = 22;
	public static const MANTICORE_LIKE_LARGE:int = 23;
	public static const BAT_ARM:int              = 24;
	public static const VAMPIRE:int              = 25;
	public static const FEY_DRAGON_WINGS:int     = 26;
	
	public function Wings(creature:Creature, publicPrimitives:Array) {
		super(creature, publicPrimitives);
	}
}
}
