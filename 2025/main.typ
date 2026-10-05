#import "@preview/touying:0.6.1": *
#import themes.metropolis: *

#import "@preview/curryst:0.5.0" as curryst: prooftree, rule
#import "@preview/fletcher:0.5.7" as fletcher: diagram, edge, node
#import "@preview/ctheorems:1.1.3": *

#import "@preview/itemize:0.2.0" as el
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
  // config-common(handout: true),
)

#set text(font: "IBM Plex Sans")
#show math.equation: set text(font: "IBM Plex Math")

#set heading(numbering: "1.1")
// #show heading.where(level: 2): set heading(numbering: none)
#show outline.entry: it => it.indented(it.prefix(), it.body())
// #show outline.entry.where(level : 2) : set text(size: 0.9em)


#show: thmrules.with(qed-symbol: $square$)
#let thmbox = thmbox.with(padding: (top: 0.2em, bottom: 0.2em))
#let thmbox = (..x) => thmbox(..x).with(numbering: none)

#let remark = thmbox("remark", "Remark", fill: rgb("#eeeeee"))
#let claim = thmbox("claim", "Claim", fill: rgb("#eeffee"))
#let definition = thmbox("definition", "Definition", fill: rgb("#eeeeff"))
#let theorem = thmbox("theorem", "Theorem", fill: rgb("#eeffee"))
#let lemma = thmbox("lemma", "Lemma", fill: rgb("#ffffee"))
#let corollary = thmbox("corollary", "Corollary", fill: rgb("#eeffee"))

#let example = thmplain("example", "Example").with(numbering: none)
#let proof = thmproof("proof", "Proof")
#let proofnoqed = thmplain("proof", "Proof", namefmt: emph).with(numbering: none)


#let proves = $tack.r$
#let bred = $scripts(->)_β$
#let bredsim = $scripts(->>)_β$
#let nbred = $scripts(arrow.r.not)_β$

#show "␣": $thick$

#let rule(..r) = box(curryst.prooftree(vertical-spacing: 0.3em, curryst.rule(..r)))
#let crule = curryst.rule

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
- input (and output) = "binary code" #pause
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
  - find systematic methods of study #pause
  - do some cool math #emoji.face.cool

= $λ$-calculus

== Presentation

- a model of functionnal languages #pause
- very simple language but... very powerful #pause
#claim(
  "Church-Turing Thesis",
)[A mathematical function on the natural numbers can be calculated by an _effective_ method  if and only if it can be defined in the $λ$-calculus (if and only if it can be computed by a Turing machine).] #pause

The rest of this talk:
+ define $λ$-calculus
+ show some "simple" results
+ introduce a typed version of $λ$-calculus
+ present the strong normalization of this new calculus and why it's nice

== Syntax

#definition([$λ$-terms])[
  $ t, u... ::= x | t ␣ u | λ x. t $
  $x ∈ X$ a set of variables. We consider terms equal up to renaming of *bound* variables.
] #pause
#example[
  $
    id = λ x . x = λ y. y pause
    wide λ y. x = λ z. x != λ y.z pause
    wide λ x. y ␣ (z ␣ x)
    wide λ x. (y ␣ z) ␣ x = λ x. y ␣ z ␣ x pause
  $$
    (λ x. x ␣ id) ␣ (y ␣ (λ x. x ␣ y)) pause
    wide ω = λ x. x ␣ x
    wide Ω = ω ␣ ω = (λ x. x ␣ x) ␣ (λ x. x ␣ x)
  $
]

== Semantics

Reduction relation $t bred u$: "if I have the term $t$ and I do one step of computation I end up with $u$"#pause

#definition[$β$-reduction][Inductively,

  #rule(
    name: $β$,
    $(λ x . t) ␣ u bred t[x slash u]$,
  )
  #pause
  #h(1fr)
  #rule(
    name: $λ$,
    $λ x . t bred λ x. t'$,
    $t bred t'$,
  )
  #h(1fr)
  #rule(
    name: "appl",
    $t ␣ u bred t' ␣ u$,
    $t bred t'$,
  )
  #h(1fr)
  #rule(
    name: "appr",
    $t ␣ u bred t ␣ u'$,
    $u bred u'$,
  )

  #meanwhile
  where $t[x slash u]$ is the term $t$ where each occurence of $x$ is replaced by $u$
] #pause
// #v(-1em)
#definition[Normal Form][
  $t$ is a *normal form* if there is no $u$ such that $t bred u$. We write $t nbred$.
]
---

#rule(
  name: $β$,
  $(λ x . t) ␣ u bred t[x slash u]$,
)
#h(1fr)
#rule(
  name: $λ$,
  $λ x . t bred λ x. t'$,
  $t bred t'$,
)
#h(1fr)
#rule(
  name: "appl",
  $t ␣ u bred t' ␣ u$,
  $t bred t'$,
)
#h(1fr)
#rule(
  name: "appr",
  $t ␣ u bred t ␣ u'$,
  $u bred u'$,
)

#example[
  $
    id ␣ y = (λ x.x) ␣ y bred pause x[x slash y] = y
  $ #pause
  $
    f = λ x. λ y. y ␣ x
    wide f ␣ t bred λ y. y ␣ t
  $ #pause
  $
    (λ z . f ␣ z) ␣ omega bred f ␣ pause omega bred λ y. y ␣ omega pause
    wide (λ z . f ␣ z) ␣ omega bred (λ z. λ y. y ␣ z) ␣ omega pause bred λ y. y ␣ omega
  $ #pause
  $
    x nbred
    wide id nbred
    wide λ x . t nbred
  $ #pause
  $
    Ω = ω ␣ ω = (λ x. x ␣ x) ␣ omega bred pause ω ␣ ω pause bred ω ␣ ω bred...
  $
]

== Confluence

#definition[ $t bred^* u <=> t bred ... bred u$ ]
#theorem[Confluence][
  For any terms $t, u, u'$ such that $t bred u$ and $t bred u'$, there exists a term $v$ such that $u bred^* v$ and $u' bred^* v$.
] #pause

#corollary[
  If $t bred^* u nbred$ then such a $u$ is unique.
] #pause

#proof[of Confluence][Introduce a new relation $t bredsim u$, show it has the "diamond property" and show it entails confluence for $bred$. See rest of this section.
]

---

#definition[Simultaneous reduction][

  #rule(
    name: $β$,
    $(λ x . t) ␣ u bredsim t'[x slash u']$,
    $t bredsim t'$,
    $u bredsim u'$,
  )
  #h(1fr)
  #rule(
    name: $λ$,
    $λ x . t bredsim λ x. t'$,
    $t bredsim t'$,
  )
  #h(1fr)
  #rule(
    name: "app",
    $t ␣ u bredsim t' ␣ u'$,
    $t bredsim t'$,
    $u bredsim u'$,
  )
  #h(1fr)
  #rule(
    name: "id",
    $t bredsim t$,
  )
] #pause

#lemma[$t bred t' ==> t bredsim t' ==> t bred^* t'$.] #pause

#lemma[Diamond property][
  For any terms $t, u, u'$ such that $t bredsim u$ and $t bredsim u'$, there exists a term $v$ such that $u bredsim v$ and $u' bredsim v$.
]

---

#proof[of confluence][
  $
    t bred u and t bred u' & ==> t bredsim u and t bredsim u' \
                           & ==> exists v, u bredsim v and u' bredsim v & \
                           & ==> exists v, u bred^* v and u' bred^* v
  $
] #pause

#proofnoqed[of the Diamond Property lemma][By induction on $t bredsim u$.]
/ id vs.  anything: $u = t$
#align(center)[
  #diagram(
    spacing: 1em,
    node((2, 0), $t$),
    edge("->", [id]),
    edge((3, 1), "->"),
    node((1, 1), $t$),
    edge((2, 2), "->", label-side: right),
    node((3, 1), $u'$),
    edge("->", label-side: left),
    node((2, 2), $u'$),
  )
]
---

/ $λ$ vs. anything: $t = λ x. t_0$, $u = λ x. u_0$ and $t_0 bredsim u_0$
  #align(center)[
    #diagram(
      spacing: 1em,
      node((2, 0), $λ x . t_0$),
      edge($λ$, "->"),
      edge((3, 1), [?], "->"),
      node((1, 1), $λ x. u_0$),
      node((3, 1), $u'$),
      node((2, 2), []),
    )
    #h(2em)
    #diagram(
      spacing: 1em,
      node((2, 0), $λ x . t_0$),
      edge($λ$, "->"),
      edge((3, 1), $λ$, "->"),
      node((1, 1), $λ x. u_0$),
      edge((2, 2), $λ$, "->", label-side: right),
      node((3, 1), $λ x. u'_0$),
      edge($λ$, "->", label-side: left),
      node((2, 2), $λ x. v_0$),
    )
    #h(2em)
    #diagram(
      spacing: 1em,
      node((2, 0), $t_0$),
      edge("->"),
      edge((3, 1), "->"),
      node((1, 1), $u_0$),
      edge((2, 2), "->", label-side: right),
      node((3, 1), $u'_0$),
      edge("->", label-side: left),
      node((2, 2), $v_0$),
    )
  ]
  #pause
/ app vs. app: $t = t_1 ␣ t_2$, $u = u_1 ␣ u_2$, $u' = u'_1 ␣ u'_2$ and ...
  #align(center)[
    #diagram(
      spacing: 1em,
      node((2, 0), $t_1 ␣ t_2$),
      edge([app], "->"),
      edge((3, 1), [app], "->"),
      node((1, 1), $u_1 ␣ u_2$),
      edge((2, 2), [app], "->", label-side: right),
      node((3, 1), $u'_1 ␣ u'_2$),
      edge([app], "->", label-side: left),
      node((2, 2), $v_1 ␣ v_2$),
    )
    #h(2em)
    #diagram(
      spacing: 1em,
      node((2, 0), $t_1$),
      edge("->"),
      edge((3, 1), "->"),
      node((1, 1), $u_1$),
      edge((2, 2), "->", label-side: right),
      node((3, 1), $u'_1$),
      edge("->", label-side: left),
      node((2, 2), $v_1$),
    )  #h(2em)
    #diagram(
      spacing: 1em,
      node((2, 0), $t_2$),
      edge("->"),
      edge((3, 1), "->"),
      node((1, 1), $u_2$),
      edge((2, 2), "->", label-side: right),
      node((3, 1), $u'_2$),
      edge("->", label-side: left),
      node((2, 2), $v_2$),
    )
  ]
---
/ $β$ vs. $β$: $t = (λ x .t_1) ␣ t_2$ and ...
  #align(center)[
    #diagram(
      spacing: 1em,
      node((2, 0), $(λ x .t_1) ␣ t_2$),
      edge($β$, "->"),
      edge((3, 1), $β$, "->"),
      node((1, 1), $u_1[x\/u_2]$),
      edge((2, 2), [lemma], "->", label-side: right),
      node((3, 1), $u'_1[x\/u'_2]$),
      edge([lemma], "->", label-side: left),
      node((2, 2), $v_1[v_2\/v_1]$),
    )
    #h(2em)
    #diagram(
      spacing: 1em,
      node((2, 0), $t_1$),
      edge("->"),
      edge((3, 1), "->"),
      node((1, 1), $u_1$),
      edge((2, 2), "->", label-side: right),
      node((3, 1), $u'_1$),
      edge("->", label-side: left),
      node((2, 2), $v_1$),
    )  #h(2em)
    #diagram(
      spacing: 1em,
      node((2, 0), $t_2$),
      edge("->"),
      edge((3, 1), "->"),
      node((1, 1), $u_2$),
      edge((2, 2), "->", label-side: right),
      node((3, 1), $u'_2$),
      edge("->", label-side: left),
      node((2, 2), $v_2$),
    )
  ]

#lemma[
  $t bredsim t' and u bredsim u' => t[x \/ u] bredsim t'[x\/u'].$
]
---
/ $β$ vs. app: $t = (λ x .t_1) ␣ t_2$ and ...
  #align(center)[
    #diagram(
      spacing: 1em,
      node((2, 0), $(λ x .t_1) ␣ t_2$),
      edge($β$, "->"),
      edge((3, 1), [app], "->"),
      node((1, 1), $u_1[x\/u_2]$),
      edge((2, 2), [lemma], "->", label-side: right),
      node((3, 1), $(λ x .u'_1) ␣ u'_2$),
      edge($beta$, "->", label-side: left),
      node((2, 2), $v_1[v_2\/v_1]$),
    )
    #h(2em)
    #diagram(
      spacing: 1em,
      node((2, 0), $t_1$),
      edge("->"),
      edge((3, 1), "->"),
      node((1, 1), $u_1$),
      edge((2, 2), "->", label-side: right),
      node((3, 1), $u'_1$),
      edge("->", label-side: left),
      node((2, 2), $v_1$),
    )  #h(2em)
    #diagram(
      spacing: 1em,
      node((2, 0), $t_2$),
      edge("->"),
      edge((3, 1), "->"),
      node((1, 1), $u_2$),
      edge((2, 2), "->", label-side: right),
      node((3, 1), $u'_2$),
      edge("->", label-side: left),
      node((2, 2), $v_2$),
    )
  ]

  #h(1fr) $square$

= Simply Typed $λ$-calculus

== Types

Idea:
- for a function, what kind of input/ouput is expected #pause
- "static analysis" (without running the program) #pause
- pros: help the programmer + forbids some errors #pause

#definition[Types][ For some set $cal(T)$ of base types,
  $ A, B... ::= T in cal(T) | A -> B $
] #pause
#example[with $cal(T) = {"nat", "bool", "unit"}$
  $ "unit" wide "bool" pause wide "nat" -> "nat" wide "bool" -> "unit" pause wide "nat" -> ("nat" -> "nat") $
  $ ( "nat" -> "bool" ) -> ("bool" -> "nat") wide "unit" -> (("bool" -> "unit") -> "nat") $
]

== Typing

#definition[Context][List of "typed variables" $(x:A)$ :
  $ Γ ::= (x :A), (y: B), (z: C) ... $
]
#v(-1em)
#definition[Typing judgment][
  "Term $t$ has type $A$ in context $Γ$"
  $ Γ proves t : A $
] #pause

#v(-1em)
#definition[Typing rules][

  #rule(
    name: [var],
    $Γ proves x : A$,
    $(x : A) in Γ$,
  )
  #h(1fr)
  #rule(
    name: "app",
    $Γ proves t ␣ u : B$,
    $Γ proves t : A -> B$,
    $Γ proves u : A$,
  )
  #h(1fr)
  #rule(
    name: $λ$,
    $Γ proves λ x . t : A -> B$,
    $Γ, (x : A) proves t : B$,
  )
]

---

#example[$emptyset proves λ x. x : ?$ #h(1fr) $emptyset proves λ x. λ y. y ␣ x :?$ #h(
    1fr,
  ) $k:?, z : ? proves (λ x. λ y. z ␣ x) ␣ k : ?$ #pause
  #align(center)[
    #set text(size: 0.8em)
    #rule(
      name: $λ$,
      $emptyset proves λ x. x : A -> A$,
      crule(
        name: [var],
        $ (x:A) proves x : A $,
        $(x:A) in (x:A)$,
      ),
    ) #pause
    #h(3em)
    #rule(
      name: $λ$,
      $emptyset proves λ x. λ y. y ␣ x : A -> (A -> B) -> B$,
      crule(
        name: $λ$,
        $(x:A) proves λ y. y ␣ x : (A -> B) -> B$,
        crule(
          name: "app",
          $(x:A), (y: A->B) proves y ␣ x : B$,
          $(x:A), (y: A->B) proves y : A -> B$,
          $(x:A), (y: A->B) proves x : A$,
        ),
      ),
    )#pause

    #v(2em)
    #rule(
      name: [app],
      $k:A, z : A -> B proves (λ x. λ y. z ␣ x) ␣ k : C -> B$,
      crule(
        name: $λ$,
        $k:A, z: A -> B proves λ x. λ y. z ␣ x : A -> (C -> B)$,
        crule(
          name: $λ$,
          $k: A, z: A -> B, x :A proves λ y. z ␣ x : C -> B$,
          crule(
            name: "app",
            $k: A, z: A -> B, x : A, y: C proves z ␣ x : B$,
            crule(
              name: [var],
              $..., z: A -> B proves z : A -> B$,
            ),
            crule(
              name: [var],
              $..., x : A proves x : A$,
            ),
          ),
        ),
      ),
      crule(
        name: [var],
        $k:A, z : A -> B proves k : A$,
      ),
    )
  ]]

---
#remark[
  Recall $Ω = ω ␣ ω$ with $ω = λ x. x ␣ x$ such that $Ω bred Ω bred ...$ What is the type of $ω$? #pause
  #align(center)[
    #rule(
      name: $λ$,
      $Γ proves λ x . x ␣ x : A -> B$,
      crule(
        name: "app",
        $Γ, (x: A) proves x ␣ x : B$,
        $Γ, (x:A) proves x : C -> B$,
        $Γ, (x : A) proves x : C$,
      ),
    )
  ] #pause

  $C -> B = A = C ~>$ impossible, $ω$ cannot be typed ! Therefore, $Ω = ω ␣ ω$ can't be typed either.
]



== Strong Normalization


#theorem[Simply typed $λ$-calculus is strongly normalizing:
  $ forall t, (exists Γ, exists A, Γ proves t : A) ==> (exists u, t bred^* u nbred) $
]
#pause
Consequences:
- typed $λ$-calculus is more robust than untyped $λ$-calculus #emoji.face #pause
- but no longer Turing complete #emoji.face.sad

#pause

#align(bottom + right)[
  #text(fill: gray, size: 14pt)[Powered by #link("https://typst.app/")[Typst]]
]

#place(center + horizon)[
  #set text(
    size: 7em,
    fill: rgb(50%, 50%, 50%, 30%),
    // font: "z003"
  )
  Thx!
  Any questions?
]
