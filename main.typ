#import "@preview/touying:0.6.1": *
#import themes.metropolis: *

#import "@preview/curryst:0.5.0": rule, prooftree
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

#set heading(numbering: "1.1")
// #show heading.where(level: 2): set heading(numbering: none)
#show outline.entry: it => it.indented(it.prefix(), it.body())
// #show outline.entry.where(level : 2) : set text(size: 0.9em)

#show: thmrules.with(qed-symbol: $square$)

#let remark = thmbox("remark", "Remark", fill: rgb("#eeeeee")).with(numbering: none)
#let claim = thmbox("claim", "Claim", fill: rgb("#eeffee")).with(numbering: none)
#let definition = thmbox("definition", "Definition", fill: rgb("#eeeeff")).with(numbering:none)

#let theorem = thmbox("theorem", "Theorem", fill: rgb("#eeffee"))
#let corollary = thmplain(
  "corollary",
  "Corollary",
  base: "theorem",
  titlefmt: strong
)
#let example = thmplain("example", "Example").with(numbering: none)
#let proof = thmproof("proof", "Proof")

#set text(font:"IBM Plex Sans")
#show math.equation: set text(font:"IBM Plex Math")

#let app = $thick$

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
]
#example[
  $
  "id" = λ x . x = λ y. y
  wide λ y. x = λ z. x != λ y.z
  wide λ x. y app (z app x) 
  wide λ x. (y app z) app x = λ x. y app z app x 
  $$
  (λ x. x app ω) app  (y app (λ x. x app y))
  wide ω = λ x. x app x 
  wide Ω = ω app ω = (λ x. x app x) app (λ x. x app x)
  $
]

== Semantics

= Simply Typed $λ$-calculus

