# CTS URNs in CroALa

## The background

Contrary to the so-called "classical" Greek and Latin literature, the corpus of works preserved from the twelve centuries between 750 BC and 500 AD, the works of Neo-Latin literature lack a standard, canonical, wide-spread citation schemes, in the same way as Neo-Latin literature lacks a canon. For a digital collection this is both a blessing and a curse. On the one hand, there are no complicated, sometimes even conflicting or competing systems to be reproduced; on the other hand, it is a task of the collection editors to develop and implement a citation scheme which will be understandable to humans and actionable for machines.

Trying to solve this task for the Neo-Latin texts in the [Croatiae auctores Latini](http://croala.ffzg.unizg.hr), we propose the approach described below. We believe that, though somewhat novel and different from classical citation schemes, the approach nevertheless remains within the limits of the [CITE Architecture](http://cite-architecture.github.io/) specification.

## CroALa CTS URNs

Here is an example of a CroALa CTS URN, referring to a segment in an edition:

`urn:cts:croala:sivri01.croala853690.croala-lat1:text.body.div2.div6.div2.div2.l6`

We follow the [CapiTainS CTS Guidelines](http://capitains.github.io/pages/guidelines) to the level of edition: `urn:cts:croala:sivri01.croala853690.croala-lat1:`. (We diverge from the guidelines, however, in the location in which the CTS URN is noted in the actual XML edition; it is not in `TEI/text/body/@n`, as proposed by the guidelines, but in `TEI/text/@xml:base`, the attribute which, according to the [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-att.global.html), "provides a base URI reference with which applications can resolve relative URI references into absolute URI references".)

Below the level of edition, we did not see sufficient reason to imitate, in a collection of little known, non-canonical texts, the historically established canonical "Verg. A. 1.14" or "NT Lk 10.16" citation sigla shorthand system for classical literature.

Ours, admittedly verbose, reconstruction of the path to the XML element cited (presented in the reconstruction as a [descendant](http://www.xmlplease.com/axis#s2.4) of the `TEI/text`), can easily be decoded by someone familiar with the TEI scheme as "the sixth line in the first section of the second section of the sixth section of the second section of the body of the text". The URN can also be expressed as an XPath (`//text/body/div2/div6/div2/div2/l6`) which, when applied to the document by an XPath processor, will retrieve words belonging to that segment.

It is clear that we do not expect someone who writes an article on Antun Sivrić (1765 - 1830) to actually write, or cite, the sesquipedalian "urn:cts:croala:sivri01.croala853690.croala-lat1:text.body.div2.div6.div2.div2.l6" in the same way and for the same purposes as they would write or cite "Verg. A. 1.14". We expect, however, that our system will enable authors and machines to supply a hyperlink behind the words (for example) [in the sixth line from Sivrić's translation of the sonet *Femmina, che si vanta di saper innamorare, ed altro non sa che innamorarsi*](http://croala.ffzg.unizg.hr/basex/cts/urn:cts:croala:sivri01.croala853690.croala-lat1:text.body.div2.div6.div2.div2.l6), and that the hyperlink would lead the (human or mechanical) reader to Sivrić's actual words in the actual CroALa digital edition of his poetic translations.

An advantage of this system, at least for our prototyping purposes, is that, once the URL is divided into its three components (the base URL `http://croala.ffzg.unizg.hr/basex/cts/`, the edition URN `urn:cts:croala:sivri01.croala853690.croala-lat1:`, the segment path `text.body.div2.div6.div2.div2.l6`), the required segment can be retrieved by a very simple XQuery:

```xquery

collection("croala-cts-1")//*:text[@xml:base="urn:cts:croala:sivri01.croala853690.croala-lat1:"]//*[@n="text.body.div2.div6.div2.div2.l6"]

```

With BaseX on our local system, the `cts:getpassage()` takes 14.72 ms to execute over the `croala-cts-1` database (154 MB in size, 2,390,070 nodes, 1148 documents). We are confident that a professional solution -- for example, an SQL implementation of this CTS setup -- could be even faster and more reliable.


