module namespace test = 'http://basex.org/modules/xqunit-tests';
import module namespace cts = "http://croala.ffzg.unizg.hr/cts" at '../../xqm/croalacts.xqm';

   

(: Retrieve a list of available textgroups from the croala-cts-1 db :)
(: Heading: "CroALa Textgroups in $dbname, $date" :)
(: Fields: label, CTS URN - linking to list of work CTSs, count of available texts :)
(:~ Retrieve a CTS URN from a tbody/tr/td sequence, a list of CTS URNs in croala-cts-1 db. :)
declare %unit:test %unit:ignore function test:retrieve-ctsurn-as-link() {
  let $urn := "urn:cts:croala:sivri01.croala853690.croala-lat1:text.body.div2.div6.div2.div1.l6"
  let $href := "http://croala.ffzg.unizg.hr/basex/cts/" || $urn
  return unit:assert-equals(cts:getcapabilities()//tr/td/a[@href=$href]/string()[.=$urn], $urn)
};

declare %unit:test function test:retrieve-textgroups-caption() {
  let $dbname := "croala-cts-1"
  let $date := "2016-10-01T22:05:11.000Z"
  let $head := "Textgroups available in CroALa db " || $dbname || ", updated on " || $date
  return unit:assert-equals(cts:gettextgroups()//caption/string(), $head)
};

declare %unit:test %unit:ignore function test:retrieve-textgroups-heading() {
  let $label := "Label"
  let $ctsurnlabel := "CTS URN"
  let $count := "Available works"
  return unit:assert-equals(for $ t in cts:gettextgroups()//thead/tr/td return $t/string(), ($label, $ctsurnlabel, $count))
};


declare %unit:test function test:retrieve-textgroups-urn() {
  let $urn := element td {
    element a { 
    attribute href {
      "http://croala.ffzg.unizg.hr/basex/ctsopera/urn:cts:croala:sivri01"
    } , "urn:cts:croala:sivri01" } }
  let $label := element td { "Sivrić, Antun" }
  let $editionhref := "http://croala.ffzg.unizg.hr/basex/ctsopera/" || $urn
  let $count := element td { element a { 
  attribute href { $editionhref } , 
  "1" } }
  let $href := "http://croala.ffzg.unizg.hr/basex/ctsopera/" || $urn
  return unit:assert-equals(
    for $r in cts:gettextgroups()//tbody/tr[td[2]/a[@href=$href]/string()[.=$urn]]/td return $r, ($label , $urn, $count))
};

(: given a URL, retrieve passage :)
declare %unit:test %unit:ignore function test:retrieve-passage-urn() {
  let $ctsurn := "urn:cts:croala:sivri01.croala853690.croala-lat1:text.body.div2.div6.div2.div2.l6"
  return unit:assert-equals(cts:getpassage($ctsurn)[name()="l"]/string(), "Vel Beronicei (58) verticis alma coma ,")
};

declare %unit:test function test:retrieve-works-caption() {
  let $dbname := "croala-cts-1"
  let $date := "2016-10-01T22:05:11.000Z"
  let $head := "urn:cts:croala:sivri01: works available in CroALa db " || $dbname || ", updated on " || $date
  return unit:assert-equals(cts:getworks("urn:cts:croala:sivri01")//caption[parent::*:table[@class="table-striped table-hover table-centered"]]/string(), $head)
};

declare %unit:test function test:retrieve-works-headrow() {
  let $label := "Label"
  let $ctsurnlabel := "CTS URN"
  let $count := "Editions available"
  return unit:assert-equals(for $ t in cts:getworks("urn:cts:croala:sivri01")//thead[parent::*:table[@class="table-striped table-hover table-centered"]]/tr/td return $t/string(), ($label, $ctsurnlabel, $count))
};

declare %unit:test function test:retrieve-works-urn() {
  let $urn := element td {
    element a { 
    attribute href {
      "http://croala.ffzg.unizg.hr/basex/ctseditiones/urn:cts:croala:sivri01.croala853690"
    } , "urn:cts:croala:sivri01.croala853690" } }
  let $label := element td { "Traduzione latina delle Anacreontiche ... e dei sonetti" }
  let $editionhref := "http://croala.ffzg.unizg.hr/basex/ctseditions/" || $urn
  let $count := element td { element a { 
  attribute href { $editionhref } , 
  "1" } }
  let $href := "http://croala.ffzg.unizg.hr/basex/ctseditiones/" || $urn
return unit:assert-equals(
    for $r in cts:getworks("urn:cts:croala:sivri01")//tbody[parent::*:table[@class="table-striped table-hover table-centered"]]/tr[td[2]/a[@href=$href]/string()[.=$urn]]/td return $r, ($label , $urn, $count))
    (:
    return unit:assert(
    for $r in cts:getworks()//tbody[parent::*:table[@class="table-striped table-hover table-centered"]]/tr[td[2]/a[@href=$href]/string()[.=$urn]]/td return $r)
    :)
};

declare %unit:test function test:retrieve-works-empty() {
unit:assert(
    cts:getworks("")//tbody[parent::*:table[@class="table-striped table-hover table-centered"]]/tr[td[2]/a[@href]]/td)
};