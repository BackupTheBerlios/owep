package owep.vue.transfert.convertor ;


/**
 * Cette classe est utilis� par le syst�me de transfert pour r�cup�rer et 
 * convertir en double.
 */
public class VDoubleConvertor
{
  /**
   * Retourne la classe Double.
   * @return Classe Double.
   */
  public static Class getType ()
  {
    return Double.TYPE;  
  }
  
  
  /**
   * Permet de convetir la valeur pass�e en Double.
   * @param pValeur Valeur que l'on doit convertir.
   * @return Valeur convertit au format Double.
   */
  public static Object getObject (String pValeur)
  {
    return new Double (pValeur) ; 
  }


  /**
   * R�cup�re la fonction javascript permettant de valider ce type. Celle-ci retourne un bool�en.
   * @return Fonction javascript permettant de valider ce type.
   */
  public static String getValidation ()
  {
    return "" ; 
  }
}
