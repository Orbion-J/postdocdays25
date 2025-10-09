#import "@preview/touying:0.6.1": *
#import themes.metropolis: *

#import "@preview/curryst:0.5.0" as curryst : rule, prooftree
#import "@preview/fletcher:0.5.7" as fletcher: diagram, node, edge
#import "@preview/ctheorems:1.1.3" : *

#import "@preview/itemize:0.1.2" as el
#show: el.default-enum-list

#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  footer: self => [#self.info.title -- Robin Jourde],
  config-info(
    title: [An Introduction to the Theory of Programming Languages],
    subtitle: [LAMA (post)doc days],
    author: [*Robin Jourde*],
    date: [14-15 October 2025],
    // institution: [],
    // logo: [],
  ),
  config-common(handout: true)
)

#set text(font:"IBM Plex Sans")
#show math.equation: set text(font:"IBM Plex Math")

#set heading(numbering: "1.1")
// #show heading.where(level: 2): set heading(numbering: none)
#show outline.entry: it => it.indented(it.prefix(), it.body())
// #show outline.entry.where(level : 2) : set text(size: 0.9em)


#show: thmrules.with(qed-symbol: $square$)

#let remark = thmbox("remark", "Remark", fill: rgb("#eeeeee")).with(numbering: none)
#let claim = thmbox("claim", "Claim", fill: rgb("#eeffee")).with(numbering: none)
#let definition = thmbox("definition", "Definition", fill: rgb("#eeeeff")).with(numbering:none)
#let theorem = thmbox("theorem", "Theorem", fill: rgb("#eeffee")).with(numbering:none)
#let lemma = thmbox("lemma", "Lemma", fill: rgb("#ffffee")).with(numbering:none)
#let corollary = thmbox("corollary", "Corollary", fill: rgb("#eeffee")).with(numbering:none)

#let example = thmplain("example", "Example").with(numbering: none)
#let proof = thmproof("proof", "Proof")


#let app = $thick$

#let rule(..r) = box(curryst.prooftree(vertical-spacing:0.3em, curryst.rule(..r)))


#title-slide()

= Outline <touying:hidden>

#outline(title: none, indent: 2em, depth: 2)

= Introduction

== My motivation

- my PhD: "Mathematical Foundations of Skeletal Semantics" #pause
- semantics = giving a *meaning* to a *text* #pause 
- in computer science, text = code #pause $~>$ programming language #pause
- meaning = mathematical representation/"model" #pause
#remark["Skeletal" is for next time #emoji.face.wow, "Mathematical" (for my PhD) is category theory]

== Programming Languages

- computer = machine $≃$ big boolean circuit #pause
- only input (and output) = "binary code" #pause
- processor: set of instructions, encoded in binary = _assembly_ #pause
#example[`ret` = `0xc3`, `add(%rax,%rsi)` = `0x4801c6`, `mov(%rax,%rsi)` = `0x4889c6`... #pause

$~>$ Demo at the end if I have time...
] #pause
- no one wants to write binary/assembly #pause
- design *languages* to write instructions #pause $~>$ compiled to assembly #pause
  - ease: write and read ! $~>$ debugging
  - correctness
  - optimization
  - complex features, different paradigms eg. functional programming, OOP, parallel computing... #pause
  - #emoji.crossmark more powerful !

== Theory?

- plenty of languages: C, C++, Python, COBOL, Rust, OCaml, TeX, Gallina (Rocq), R... #pause
- very complex, lots of features #pause
- goals: #pause
  - better understand what they do
  - *verify* they do that they claim to do #pause
  - how to do it better
  - how to do new stuff #pause
  - do some cool math #emoji.face.cool

= $λ$-calculus

== Presentation

- a model of functionnal languages
- very simple language but... very powerful
#claim("Church-Turing Thesis")[A mathematical function on the natural numbers can be calculated by an _effective_ method  if and only if it can be defined in the $λ$-calculus (if and only if it can be computed by a Turing machine).]

The rest of this talk:
+ define $λ$-calculus
+ show some simple results
+ introduce a typed version of $λ$-calculus
+ present the strong normalization of this new calculus and why it's nice

== Syntax

#definition([$λ$-terms])[ 
  $ t, u... ::= x | t app u | λ x. t $
  $x ∈ X$ a set of variables. We consider terms equal up to renaming of *bound* variables.
] #pause
#example[
  $
  id = λ x . x = λ y. y pause
  wide λ y. x = λ z. x != λ y.z pause
  wide λ x. y app (z app x) 
  wide λ x. (y app z) app x = λ x. y app z app x pause
  $$
  (λ x. x app id) app  (y app (λ x. x app y)) pause
  wide ω = λ x. x app x 
  wide Ω = ω app ω = (λ x. x app x) app (λ x. x app x)
  $
]

== Semantics

#let bred = $scripts(->)_β$
#let nbred = $scripts(arrow.r.not)_β$

- reduction relation $t bred t'$ #pause
- defined by induction on the left-hand side term #pause

#definition[$β$-reduction][

  #rule(
    name:$β$,
    $(λ x . t) app u bred t[x slash u]$
  ) #pause
  #h(1fr)
  #rule(
    name:$λ$,
    $λ x . t bred λ x. t'$,
    $t bred t'$
  )
  #h(1fr)
  #rule(
    name:"appl",
    $t app u bred t' app  u$,
    $t bred t'$
  )
  #h(1fr)
  #rule(
    name:"appr",
    $t app u bred t app  u'$,
    $u bred u'$
  )

  #meanwhile
  where $t[x slash u]$ is the term $t$ where each occurence of $x$ is replaced by $u$
] #pause
#v(-1em)
#definition[Normal Form][
  $t$ is a *normal form* if there is no $u$ such that $t bred u$. Write $t nbred$.
]


  ---

  #rule(
    name:$β$,
    $(λ x . t) app u bred t[x slash u]$
  ) 
  #h(1fr)
  #rule(
    name:$λ$,
    $λ x . t bred λ x. t'$,
    $t bred t'$
  )
  #h(1fr)
  #rule(
    name:"appl",
    $t app u bred t' app  u$,
    $t bred t'$
  )
  #h(1fr)
  #rule(
    name:"appr",
    $t app u bred t app  u'$,
    $u bred u'$
  )

  #example[
    $
    id app y = (λ x.x) app y bred pause x[x slash y] = y
    $ #pause
    $
    f = λ x. λ y. y app x
    wide f app t bred λ y. y app t
    $ #pause
    $
    (λ z . f app z) app omega bred f app pause omega bred λ y. y app omega pause
    wide (λ z . f app z) app omega bred (λ z. λ y. y app z) app omega pause bred λ y. y app omega
    $ #pause
    $
    x nbred
    wide id nbred
    wide λ x . t nbred
    $ #pause
    $
    Ω = ω app ω = (λ x. x app x) app omega bred pause ω app ω pause bred ω app ω bred...
    $
  ]

== Confluence

#definition[ $t bred^* u <=> t bred ... bred u$ ]

#theorem[Confluence][
  For any terms $t, u, u'$ such that $t bred u$ and $t bred u'$, there exists a term $v$ such that $u bred^* v$ and $u' bred^* v$.
] #pause

#proof[
  The proof is by induction on the term $t$. We do it next slide.
]

#corollary[
  If $t bred^* u nbred$ then such a $u$ is unique.
]

---

- If $t = x$ then $t nbred$.
- If $t = λ x. t_0$, 
  #align(center)[
    #diagram(spacing:1.5em,
		node((2,0), $λ x . t_0$), edge($λ$, "->"), edge((3,1), $λ$, "->"),
		node((1,1), $λ x. u_0$), edge((2,2), $λ$, "->", label-side:right),
		node((3,1), $λ x. u'_0$), edge($λ$, "->", label-side:left),
		node((2,2), $λ x. v_0$),
	)
  #h(2em)
   #diagram(spacing:1.5em,
		node((2,0), $t_0$), edge("->"), edge((3,1),"->"),
		node((1,1), $u_0$), edge((2,2), "->", label-side:right),
		node((3,1), $u'_0$), edge("->", label-side:left),
		node((2,2), $v_0$),
	) 
 ]

- If $t = t_1 app t_2$,
  #align(center)[
    #diagram(spacing:1.5em,
		node((2,0), $t_1 app t_2$), edge($r$, "->"), edge((3,1), $r'$, "->"),
		node((1,1), $u$), 
      node((3,1), $u'$),
    )
  ]
  Inspect what $r, r'$ can be.

---

TODO

#lemma[Congruence][
  $u bred^* u' => forall t, t[x \/ u] bred^*t[x\/u'].$
]



= Simply Typed $λ$-calculus

