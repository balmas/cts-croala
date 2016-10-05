declare namespace functx = "http://www.functx.com";
declare function functx:substring-after-last
  ( $arg ,
    $delim ) {

   replace ($arg,concat('^.*',functx:escape-for-regex($delim)),'')
 } ;
 declare function functx:escape-for-regex
  ( $arg ) {

   replace($arg,
           '(\.|\[|\]|\\|\||\-|\^|\$|\?|\*|\+|\{|\}|\(|\))','\\$1')
 } ;
 
for $n in collection("croala-cts-1")//*:text//*/@n
let $newn := functx:substring-after-last($n, ".")
return replace value of node $n with $newn