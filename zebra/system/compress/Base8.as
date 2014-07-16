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
    /**
     * The Base8 algorithm encoding tool class.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import calista.utils.Base8 ;
     * 
     * var source:String = "hello world with a base 8 algorithm" ;
     * 
     * var encode:String = Base8.encode( source ) ;
     * trace("encode : " + encode) ;
     * 
     * var decode:String = Base8.decode( encode ) ;
     * trace("decode : " + decode) ;
     * 
     * // encode : 68656c6c6f20776f726c64207769746820612062617365203820616c676f726974686d
     * // decode : hello world with a base 8 algorithm
     * </pre>
     */
    public class Base8 
    {
        /**
         * Encodes a base8 string.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import calista.utils.Base8 ;
         * var encode:String = Base8.encode( "hello world with a base 8 algorithm" ) ;
         * trace("encode : " + encode) ; // encode : 68656c6c6f20776f726c64207769746820612062617365203820616c676f726974686d
         * </pre>
         */
        public static function encode( source:String ):String
        {
            if ( !source || source == "" )
            {
                return "" ;
            }
            var output:String = "" ;
            var size:int = source.length ;
            for (var i:int ; i<size ; i++) 
            {
                output += source.charCodeAt(i).toString(16);
            }
            return output;
        }
        
        /**
         * Decodes a base8 string.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import calista.utils.Base8 ;
         * var decode:String = Base8.decode( "68656c6c6f20776f726c64207769746820612062617365203820616c676f726974686d" ) ;
         * trace("decode : " + decode) ; // decode : "hello world with a base 8 algorithm"
         * </pre>
         */
        public static function decode( source:String ):String
        {
            if ( !source || source == "" )
            {
                return "" ;
            }
            var result:String = "" ;
            var size:int = source.length ;
            for ( var i:int ; i < size ;  i+=2 ) 
            {
                result += String.fromCharCode( parseInt(source.substr(i, 2), 16));
            }
            return result;
        }
    }
}
