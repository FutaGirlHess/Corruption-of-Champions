package classes.Items.Weapons 
{
	import classes.GlobalFlags.kFLAGS;
	import classes.CoC;
	import classes.Items.Weapon;
	
	public class QueensGuard extends Weapon
	{
		
		public function QueensGuard() 
		{
			super("Q.Guard", "Q. Guard", "queen's guard", "a queen's guard", "slash", 20, 2400, "This weapon is made in the design of queen Lethice’s former nobility seal before the mage kingdom fell to corruption. It is said these swords were given to nobles entering knighthood to the queen. A pure hearted manly fencer seeking to protect that which he holds dearest will find his resolve empowered by this blade.");
		}
		override public function get attack():Number{
			var boost:int = 0;
			if (CoC.instance.flags[kFLAGS.RAPHAEL_RAPIER_TRANING] < 2) boost += CoC.instance.flags[kFLAGS.RAPHAEL_RAPIER_TRANING] * 2;
			else boost += 4 + (CoC.instance.flags[kFLAGS.RAPHAEL_RAPIER_TRANING] - 2);
			boost += ((100 - game.player.femininity) / 20) + ((100 - game.player.cor) / 20) / 2;
			return (20 + boost); 
		}
		
	}

}