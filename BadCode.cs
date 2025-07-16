 //  Intentionally terrible C# to demonstrate linter failures


using  System; using   System.Collections.Generic;   // extra spaces + wrong on-line ordering
using System. Linq;                                   // misplaced space after “System.”
using System.Threading.Tasks; // comment trailing spaces                                

namespace BadlyFormattedNS   {     // brace on same line, double spaces
public  class bad_class   // wrong casing + double spaces
{
           private static   readonly  int  ANSWER   =42;// field casing, spacing, rogue constant

   public  BadCode( )   {Console . WriteLine( "Created" );}  // spaces everywhere & braces

   public  void    DoStuff(   IDictionary< string ,List <int>> data    )
       { if(data==null){throw new ArgumentNullException ( nameof ( data ) );}
               foreach(  var kvp   in data  ){
                Console.WriteLine(   $"Key:{kvp.Key}, Count = {kvp.Value.Count}"); }        /* crowded */
       }  // incorrect indentation + brace style
 
      internal  static async  Task  <   IEnumerable < int >   >GetValuesAsync(  )
{
           await Task . Delay (100 ) ;   // spaces around dot + inside parentheses
           return   new List<int>{1 ,2,3 ,  4}; // inconsistent spacing
}        // extra spaces before brace
}
} // No newline at end
