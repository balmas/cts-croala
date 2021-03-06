# CTS URNs in CroALa

## The background

Contrary to the so-called "classical" Greek and Latin literature (the corpus of works preserved from the twelve centuries between 750 BC and 500 AD), the works of Neo-Latin literature lack a standard, canonical, wide-spread citation schemes -- in the same way as Neo-Latin literature lacks a canon of "most important" or "representative" authors and works.

For a digital collection, this lack of established citation schemes is both a blessing and a curse. On the one hand, there are no complicated, sometimes even conflicting or competing citation systems to be reproduced.  On the other hand, the editors have to develop -- and implement! -- a citation scheme which will, ideally, be understandable to humans as well as actionable for machines.

Trying to solve this task for the Neo-Latin texts in the [Croatiae auctores Latini](http://croala.ffzg.unizg.hr), we propose the approach described below. We believe that, though to a degree departing from classical citation schemes, our approach nevertheless remains within the limits of the [CITE Architecture](http://cite-architecture.github.io/) specification. Of course, we welcome suggestions and comments -- that is why we're on Github!

## CroALa CTS URNs

Here is an example of a CroALa CTS URN, referring to a segment in an edition:

`urn:cts:croala:sivri01.croala853690.croala-lat1:text.body.div2.div6.div2.div2.l6`

We follow the [CapiTainS CTS Guidelines](http://capitains.github.io/pages/guidelines) to the level of edition: `urn:cts:croala:sivri01.croala853690.croala-lat1:`. (We diverge from the guidelines, however, in the location in which the CTS URN is noted in the actual XML edition; it is not in `TEI/text/body/@n`, as proposed by the guidelines, but in `TEI/text/@xml:base`, the attribute which, according to the [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-att.global.html), "provides a base URI reference with which applications can resolve relative URI references into absolute URI references".)

Below the level of edition, we did not see sufficient reason to imitate, in a collection of little known, non-canonical texts, the historically established canonical "Verg. A. 1.14" or "NT Lk 10.16" citation sigla shorthand system for classical literature. Moreover, our TEI XML editions often have to present complex hierarchical structures (compare Sivrić's URN above) which would become even less comprehensible when expressed only by numbers. Expressing the location in Sivrić's collection of translated Italian sonnets (with facing originals) as `urn:cts:croala:sivri01.croala853690.croala-lat1:2.6.2.2.6` does not seem significantly more elegant or clear. It is certainly possible that the TEI XML would, as a format, at one time become obsolete; for the time being, however, it seems to us that by discarding element names we are losing information which is already there, that we choose not to rely on some intellectual work that has already been done. 

While readers can guess that, in the case of `2.6.2.2.6`, the 6 is somehow subordinated to 2 and to 2 and to 6 and to 2, the URN fragment `text.body.div2.div6.div2.div2.l6` may also suggest something about the semantic relationships of the segments; relationship of a *l* to a *div* is different from the relationship of a *body* to a *div*. Our, admittedly verbose, URN is, of course, a simple reconstruction of the path to the XML element cited (presented in the reconstruction as a [descendant](http://www.xmlplease.com/axis#s2.4) of the `TEI/text`). While remaining awkwardly close to an individual, specific format (the TEI XML), the URN can, at the same time, easily be decoded by someone familiar with the scheme; it may be read as "the sixth line in the first section of the second section of the sixth section of the second section of the body of the text". The URN can also be transformed into an XPath (`//text/body/div2/div6/div2/div2/l6`) which, when applied to the document by an XPath processor, will retrieve words belonging to that segment.

It is clear that we do not expect someone who writes an article on Antun Sivrić (1765 - 1830) to actually write, or cite, the sesquipedalian "urn:cts:croala:sivri01.croala853690.croala-lat1:text.body.div2.div6.div2.div2.l6" in the same way and for the same purposes as they would write or cite "Verg. A. 1.14". We expect, however, that our system will enable authors and machines to supply a hyperlink behind the words (for example) [in the sixth line from Sivrić's translation of the sonet *Femmina, che si vanta di saper innamorare, ed altro non sa che innamorarsi*](http://croala.ffzg.unizg.hr/basex/cts/urn:cts:croala:sivri01.croala853690.croala-lat1:text.body.div2.div6.div2.div2.l6), and that the hyperlink would lead the (human or mechanical) reader to Sivrić's actual words in the actual CroALa digital edition of his poetic translations.

An advantage of this system, at least for our prototyping purposes, is that, once the URL is divided into its three components (the base URL `http://croala.ffzg.unizg.hr/basex/cts/`, the edition URN `urn:cts:croala:sivri01.croala853690.croala-lat1:`, the segment path `text.body.div2.div6.div2.div2.l6`), the required segment can be retrieved by a very simple XQuery:

```xquery

collection("croala-cts-1")//*:text[@xml:base="urn:cts:croala:sivri01.croala853690.croala-lat1:"]//*[@n="text.body.div2.div6.div2.div2.l6"]

```

With BaseX on our local system, the `cts:getpassage()` takes 14.72 ms to execute over the `croala-cts-1` database (154 MB in size, 2,390,070 nodes, 1148 documents). We are confident that a professional solution -- for example, an SQL implementation of this CTS setup -- could be even faster and more reliable.

## Navigating the CroALa CTS collection

CTS URNs present texts at several levels, which in the case of CroALa are accessed by [RESTXQ pages](http://docs.basex.org/wiki/RESTXQ):

+ **textgroups**, usually sharing the same author, or authors, or identity: [croala.ffzg.unizg.hr/basex/conglomerationes](http://croala.ffzg.unizg.hr/basex/conglomerationes)
+ **works** belonging to textgroups, instantiated in different editions:  [croala.ffzg.unizg.hr/basex/ctsconglomeratio/index](http://croala.ffzg.unizg.hr/basex/ctsconglomeratio/index) (an index of all available works), [croala.ffzg.unizg.hr/basex/ctsconglomeratio/urn:cts:croala:skrl01](http://croala.ffzg.unizg.hr/basex/ctsconglomeratio/urn:cts:croala:skrl01) (works in a particular textgroup)
+ **editions** as realizations of works, which may differ in textual variants, layout, language, annotations; at the moment, CroALa has only one edition per work: [croala.ffzg.unizg.hr/basex/ctsopus/index](http://croala.ffzg.unizg.hr/basex/ctsopus/index), [croala.ffzg.unizg.hr/basex/ctsopus/urn:cts:croala:anonymus_1066.croala842559](http://croala.ffzg.unizg.hr/basex/ctsopus/urn:cts:croala:anonymus_1066.croala842559)
+ **segments**, which are all divisions of an edition the editor has found necessary or interesting: [croala.ffzg.unizg.hr/basex/ctseditio/urn:cts:croala:selimb01.croala1579857.croala-lat1](http://croala.ffzg.unizg.hr/basex/ctseditio/urn:cts:croala:selimb01.croala1579857.croala-lat1) lists all available nodes in an edition,  [croala.ffzg.unizg.hr/basex/cts/urn:cts:croala:selimb01.croala1579857.croala-lat1:text.front.div](http://croala.ffzg.unizg.hr/basex/cts/urn:cts:croala:selimb01.croala1579857.croala-lat1:text.front.div) accesses a specific node

## CroALa and the CTS request parameters

It was not our intention to build an API for CTS in BaseX / XQuery; we don't have sufficient expertise to build APIs. But some functions listed above produce results similar to [CTS request parameter specifications](http://cite-architecture.github.io/cts_spec/). 

The *GetValidReff* request "identifies all valid values for one on-line version of a requested work, up to a specified level of the citation hierarchy"; part of this (without the level of hierarchy, at the moment) is achieved by the result of URLs such as [croala.ffzg.unizg.hr/basex/ctseditio/urn:cts:croala:selimb01.croala1579857.croala-lat1](http://croala.ffzg.unizg.hr/basex/ctseditio/urn:cts:croala:selimb01.croala1579857.croala-lat1). 

The *GetPassage* request, which "retrieves a passage of a text identified by a URN, optionally including a requested amount of adjacent context", is similar to our URLs of the type [croala.ffzg.unizg.hr/basex/cts/urn:cts:croala:selimb01.croala1579857.croala-lat1:text.front.div](http://croala.ffzg.unizg.hr/basex/cts/urn:cts:croala:selimb01.croala1579857.croala-lat1:text.front.div) (although in CroALa there currently is no capability to "request a number of preceding and following citation units").



