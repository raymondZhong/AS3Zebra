/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is CalistA Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2010
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
  Alternatively, the contents of this file may be used under the terms of
  either the GNU General Public License Version 2 or later (the "GPL"), or
  the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
  in which case the provisions of the GPL or the LGPL are applicable instead
  of those above. If you wish to allow use of your version of this file only
  under the terms of either the GPL or the LGPL, and not to allow others to
  use your version of this file under the terms of the MPL, indicate your
  decision by deleting the provisions above and replace them with the notice
  and other provisions required by the LGPL or the GPL. If you do not delete
  the provisions above, a recipient may use your version of this file under
  the terms of any one of the MPL, the GPL or the LGPL.
  
*/

package zebra.system.compress
{
    import flash.utils.Dictionary;

    /**
     * Compresses and decompresses text with the LZW algorithm.
     */
    public class LZW 
    {
        /**
         * Compresses the specified text.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import calista.utils.LZW ;
         * 
         * var source:String = "hello world with LZW algorithm" ;
         * 
         * var compress:String = LZW.compress( source ) ;
         * trace("compress : " + compress) ;
         * </pre>
         */
        public static function compress( source:String ):String
        {
            var i:int    ;
            var size:int ;
            
            var xstr:String;
            
            var chars:int = 256;
            
            var dict:Dictionary = new Dictionary();
            
            for ( i = 0 ; i < chars ; i++ ) 
            {
                dict[String(i)] = i;
            }
            
            var current:String ;
            
            var result:String = "";
            
            var splitted:Array = source.split("");
            
            var buffer:Vector.<Number> = new Vector.<Number>() ;
            
            size = splitted.length ;
            
            for ( i = 0 ; i<=size ; i++) 
            {
                current = new String(splitted[i]) ;
                xstr = (buffer.length == 0) ? String(current.charCodeAt(0)) : ( buffer.join("-") + "-" + String(current.charCodeAt(0) ) ) ;
                
                if (dict[xstr] !== undefined)
                {
                    buffer.push(current.charCodeAt(0));
                } 
                else 
                {
                    result += String.fromCharCode(dict[buffer.join("-")]);
                    
                    dict[xstr] = chars;
                    
                    chars++;
                    
                    buffer = new Vector.<Number>() ;
                    buffer.push(current.charCodeAt(0));
                }
            }
            return result;
        }
        
        /**
         * Decompresses the specified text with the LZW algorithm.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import calista.utils.LZW ;
         * 
         * var source:String = "hello world with LZW algorithm" ;
         * 
         * var compress:String = LZW.compress( source ) ;
         * trace("compress : " + compress) ; // compress : hello worldąith LZW algćČhm
         * 
         * var decompress:String = LZW.decompress( compress ) ;
         * trace("decompress : " + decompress) ; // decompress : hello world with LZW algorithm
         * </pre>
         */
        public static function decompress( source:String ):String
        {
            var i:int ;
            var chars:int = 256;
            var dict:Array = [] ;
            
            for (i = 0; i<chars; i++) 
            {
                dict[i] = String.fromCharCode(i);
            }
            var splitted:Array  = source.split("");
            var size:int        = splitted.length ;
            var buffer:String   = "" ;
            var chain:String    = "" ;
            var result:String   = "" ;
            var current:String ;
            var code:Number ;
            for ( i = 0; i<size ; i++ ) 
            {
                code    = source.charCodeAt(i);
                current = dict[code];
                if (buffer == "") 
                {
                    buffer = current;
                    result += current;
                }
                else 
                {
                    if (code<=255) 
                    {
                        result += current ;
                        chain   = buffer + current ;
                        dict[chars] = chain ;
                        chars++ ;
                        buffer = current ;
                    } 
                    else 
                    {
                        chain = dict[code];
                        if (chain == null) 
                        {
                            chain = buffer + buffer.slice(0,1) ;
                        }
                        result += chain;
                        dict[chars] = buffer + chain.slice(0,1);
                        chars++;
                        buffer = chain;
                    }
                }
            }
            return result;
        }
    }
}
