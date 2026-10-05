#import "@local/perso:0.0.0": *
#import presentation: *
#import mymath: *

#show: template.with(
  title: [Initial-algebra Semantics],
  subtitle: [],
  date: [(Post)doc Days -- November 12, 2026],
  author: [Robin Jourde],
  institution: [Université Savoie Mont Blanc],
  yade-dictionary: (bluesubseteqdown: [#set text(blue); $subseteqdown$]),
)


#show regex("\bSkel\b"): [#set text(1.2em);`Skel`]

#let op = "_op_"
#let toβ = $scripts(->)_β$
#let ntoβ = $scripts(nto)_β$

#let ob = math.op("ob")
#let mor = math.op("mor")

#let arl = sym.arrow.r.curve
#let arL = [\ #arl]



#show "Goal": it => [#strong(it) #emoji.darts]

#let examplepen(body) = {
  show "Example": it => [#it #emoji.page.pencil]
  example(body)
}
#let hh = h(1fr)

#title-slide()

= Introduction <touying:hidden>

My object of study:

#align(center)[
  *PROGRAMMING LANGUAGES*

  #arl build mathematical models
]

#v(1em)

Goal Generic method
#grid(
  align: center + top,
  inset: .6em,
  columns: (1fr, auto, 1fr),
  [Description of a language], $mapsto.long$, [ Its model],
  [#pause #arl Skel],
  [],
  [#set align(left)
    Design a notion of model
    - suitable for Skel
    - good mathematical properties
  ],

  [#emoji.face.think my last year seminar],
  [],
  [#emoji.face.monocle this year's seminar?],
)


== Initial-algebra semantics

Goal Get a *mathematical* representation/definition of a language or system
#arL e.g. prove and apply abstract theorems, study properties, etc.

#v(2em)

Specify programming languages *implicitly*:

- first define a whole *category of models*,

- desired language implicitly defined as *initial object* therein

== (Category theory -- 1/4 Categories)

#definition[Category $C$][
  - a collection $ob C$ of *objects*
  - a collection $mor C$ of *morphisms* such that
    - each morphism $f ∈ mor C$ has a #text(green)[source $A$] and a #text(purple)[target $B$] ($A, B ∈ ob C$)
    #v(-.4em)
    $ f ∶ #text(green)[$A$] -> #text(purple)[$B$] $
    - morphisms *compose*: if $f ∶ A -> B$ and $g ∶ B → C$,
    #v(-.4em)
    $ g ∘ f ∶ A → C $
    - there are *identities*: for any $A ∈ ob C$,
    #v(-.4em)
    $ id_A ∶ A → A wide id_A ∘ f = f wide f ∘ id_A = f $
]
#v(-.2em)
#examplepen[
  Sets and functions ⤳ a category $Set$, groups and group homomorphisms ⤳  $"𝐆𝐫𝐩"$, any poset, ...
]

== (Category theory -- 2/4 Functors)

#v(-.5em)
#definition[Functor][
  $C$ and $D$ are categories, a *functor* $F ∶ C → D$ is
  - a function on *objects* $F ∶ ob C → ob D$
  - that extends to *morphisms*
    $ F(f ∶ A → B) quad = quad F(f) ∶ F A → F B $
  - that *preserves identities and composition*
    $ F(id_A) = id_(F A) wide F(g ∘ f) = F g ∘ F f $
]
#v(-.5em)
#examplepen[
  "Forgetful" functor $U : "𝐆𝐫𝐩" → Set$, ...
]
#v(-.5em)
#proposition[
  Categories and functors ⤳ a category $"𝐂𝐚𝐭"$
]


== (Category theory -- 3/4 Some limits and colimits)

#definition[Initial object][
  Object $I$ is #text(fill:blue, weight:700)[initial] in $C$ iff $∀ X ∈ ob C, ∃! f ∶ I → X ∈ mor C$ #h(1fr) ⤳ "smallest" object
]
#definition[Terminal object][
  Object $T$ is #text(fill:green, weight:700)[terminal] in $C$ iff $∀ x ∈ ob C, ∃! f ∶ X → T ∈ mor C$ #h(1fr) ⤳ "biggest" object
]
#grid(columns:(1fr, 1.1fr), align: center)[
```yade
{"graph":{"activeTabId":0,"latexBackgroundColor":"white","latexPreamble":"\\newcommand{\\coqproof}[1]{\\checkmark}","nextTabId":1,"tabs":[{"edges":[{"from":0,"id":6,"label":{"label":"","options":{},"zindex":4},"to":2},{"from":0,"id":7,"label":{"label":"","options":{},"zindex":0},"to":3},{"from":2,"id":8,"label":{"label":"","options":{},"zindex":1},"to":4},{"from":1,"id":9,"label":{"label":"","options":{"color ":"blue","dashed":true},"zindex":0},"to":0},{"from":1,"id":10,"label":{"label":"","options":{"color ":"blue","dashed":true},"zindex":0},"to":2},{"from":1,"id":11,"label":{"label":"","options":{"color ":"blue","dashed":true},"zindex":0},"to":4},{"from":4,"id":12,"label":{"label":"","options":{"color ":"green","dashed":true},"zindex":0},"to":5},{"from":3,"id":13,"label":{"label":"","options":{"color ":"green","dashed":true},"zindex":0},"to":5},{"from":2,"id":14,"label":{"label":"","options":{"bend":0.2,"color ":"green","dashed":true},"zindex":0},"to":5},{"from":2,"id":15,"label":{"label":"","options":{},"zindex":0},"to":3},{"from":0,"id":16,"label":{"label":"","options":{},"zindex":0},"to":4},{"from":0,"id":17,"label":{"label":"","options":{"bend":-0.1,"color ":"green","dashed":true},"zindex":0},"to":5},{"from":1,"id":18,"label":{"label":"","options":{"bend":0.1,"color ":"blue","dashed":true},"zindex":-3},"to":3}],"freehandDrawings":[],"id":0,"nextGraphId":19,"nodes":[{"id":0,"label":{"label":"X","options":{},"pos":[1183,169],"zindex":0}},{"id":1,"label":{"label":"I","options":{},"pos":[1105,169],"zindex":0}},{"id":2,"label":{"label":"Y","options":{},"pos":[1235,247],"zindex":0}},{"id":3,"label":{"label":"Z","options":{},"pos":[1287,195],"zindex":0}},{"id":4,"label":{"label":"W","options":{},"pos":[1261,117],"zindex":0}},{"id":5,"label":{"label":"T","options":{},"pos":[1365,169],"zindex":0}}],"sizeGrid":26,"title":"1"}]},"version":20}
```][
#examplepen[
  In a poset, #pause $⊥$ is initial and $⊤$ is terminal. #pause

  In $Set$, #pause $∅$ is initial and ${*}$ is terminal.
]]

== (Category theory -- 4/4 Some limits and colimits)

#definition[Product][
  A *product* of $X, Y ∈ ob C$ is an object $X × Y ∈ ob C$ such that
  #grid(columns:(1.5fr, 1fr), align: center)[
  ```yade
{"graph":{"activeTabId":0,"latexBackgroundColor":"white","latexPreamble":"\\newcommand{\\coqproof}[1]{\\checkmark}","nextTabId":1,"tabs":[{"edges":[{"from":2,"id":10,"label":{"label":"π_1","options":{"color ":"red","alignment":"right"},"zindex":0},"to":0},{"from":2,"id":11,"label":{"label":"π_2","options":{"color ":"red"},"zindex":0},"to":1},{"from":3,"id":12,"label":{"label":"f","options":{"bend":0.4,"alignment":"right"},"zindex":0},"to":0},{"from":3,"id":13,"label":{"label":"g","options":{"bend":-0.4},"zindex":0},"to":1},{"from":3,"id":14,"label":{"label":"⟨f, g⟩","options":{"position":0.6,"dashed":true},"zindex":0},"to":2},{"from":6,"id":15,"label":{"label":"π_1","options":{"color ":"red","alignment":"right"},"zindex":0},"to":4},{"from":6,"id":16,"label":{"label":"π_2","options":{"color ":"red"},"zindex":0},"to":5},{"from":9,"id":17,"label":{"label":"π_1","options":{"color ":"red","alignment":"right"},"zindex":0},"to":7},{"from":9,"id":18,"label":{"label":"π_2","options":{"color ":"red"},"zindex":0},"to":8},{"from":7,"id":19,"label":{"label":"f","options":{"alignment":"right"},"zindex":0},"to":4},{"from":8,"id":20,"label":{"label":"h","options":{},"zindex":0},"to":5},{"from":9,"id":21,"label":{"label":"f × h","options":{"position":0.7,"dashed":true},"zindex":0},"to":6}],"freehandDrawings":[],"id":0,"nextGraphId":22,"nodes":[{"id":0,"label":{"label":"X","options":{},"pos":[611,247],"zindex":0}},{"id":1,"label":{"label":"Y","options":{},"pos":[715,247],"zindex":0}},{"id":2,"label":{"label":"X × Y","options":{},"pos":[663,195],"zindex":0}},{"id":3,"label":{"label":"A","options":{},"pos":[663,117],"zindex":0}},{"id":4,"label":{"label":"X","options":{},"pos":[819,247],"zindex":0}},{"id":5,"label":{"label":"Y","options":{},"pos":[923,247],"zindex":0}},{"id":6,"label":{"label":"X × Y","options":{},"pos":[871,195],"zindex":0}},{"id":7,"label":{"label":"A","options":{},"pos":[819,169],"zindex":0}},{"id":8,"label":{"label":"B","options":{},"pos":[923,169],"zindex":0}},{"id":9,"label":{"label":"A × B","options":{},"pos":[871,117],"zindex":0}}],"sizeGrid":26,"title":"1"}]},"version":20}
  ```][
    #text(fill:red, weight:700)[projection morphisms]
    - $π₁ ∶ X × Y → X$
    - $π₂ ∶ X × Y → Y$
    #arl $Δ_X = ⟨id_X, id_X⟩ ∶ X → X × X$
  ]
]
#examplepen[
  In $Set$, cartesian product.
  $
    ⟨f, g⟩(a) = (f(a), g(a)) wide Δ_X (x) = #pause (x, x) wide (f × h)(a, b) = #pause (f(a), h(b))
  $
]

== Initial-algebra semantics: usual pattern

#align(center)[
  #table(
    columns: (auto, 1fr, auto, auto, auto, auto),
    inset: .4em,
    align: center,
    stroke: none,
    gutter: -1pt,

    [], [Presentation], [], [Theory], [], [Models],

    [Pattern:],
    [small and easy to \ write description],
    [$⟼$],
    [category $C ∈ #hla(2, yellow, $"𝐓𝐡"$)$],
    $⟼$,
    hla(2, yellow)[$"𝐌𝐨𝐝"(C)$],

    [#pauses(2) Ehresmann#footnotecite(<ehresmannCategoriesStructures1965>):],
    [finite limit sketch],
    $⟼$,
    [$C ∈ #hla(2, yellow)[$"𝐋𝐞𝐱"$]$],
    $⟼$,
    [$#hla(2, yellow, $"𝐋𝐄𝐗"(C, "𝐒𝐞𝐭")$)$],

    [], [], [], [], [], [#hide($"𝐕𝐃𝐁𝐓𝐇"(ℂ, "ℝ𝕖𝕝")$)],
  )
]
#meanwhile
#pause
#box(fill: yellow, outset: 2pt)["Locally presentable categories"]
#arL nice #emoji.thumb.up (in particular, have an initial object #emoji.face)
#pause

$"𝐋𝐞𝐱"$ = 𝐥eft 𝐞𝐱act = categories with *finite limits* (products, terminal object).

#pause
Let's do an example!

== Example: theory of groups

#v(-.5em)
#definition[Textbook definition of a group][
#v(-.6em)
  #image("./def-grp-wiki.png")
]
#v(-.3em)
#exampleinline[$(ZZ, +)$, $(RR^*, ×)$]
#v(-.6em)

--- 
#definition[Finite limit sketch of groups][
  - a sort $X$
  - operations
    $ ⊙ ∶ X × X → X wide wide e ∶ 1 → X wide wide i ∶ X → X $
  - equations:
  #cgrid(
    columns: 3,
    $(x ⊙ y) ⊙ z = x ⊙ (y ⊙ z)$,
    $x ⊙ i(x) = e$,
    $e ⊙ x = x$,
    ```yade
    {"graph":{"activeTabId":0,"latexBackgroundColor":"white","latexPreamble":"\\newcommand{\\id}{\\mathsf{id}}","nextTabId":1,"tabs":[{"edges":[{"from":0,"id":4,"label":{"label":"⊙ × \\id","options":{},"zindex":0},"to":1},{"from":1,"id":5,"label":{"label":"⊙","options":{},"zindex":0},"to":2},{"from":0,"id":6,"label":{"label":"\\id × ⊙","options":{"alignment":"right"},"zindex":0},"to":3},{"from":3,"id":7,"label":{"label":"⊙","options":{},"zindex":0},"to":2}],"freehandDrawings":[],"id":0,"nextGraphId":8,"nodes":[{"id":0,"label":{"label":"X × X × X","options":{},"pos":[1116.5,188.5],"zindex":0}},{"id":1,"label":{"label":"X × X","options":{},"pos":[1261.5,188.5],"zindex":0}},{"id":2,"label":{"label":"X","options":{},"pos":[1261.5,246.5],"zindex":0}},{"id":3,"label":{"label":"X × X","options":{},"pos":[1116.5,246.5],"zindex":0}}],"sizeGrid":29,"title":"1"}]},"version":20}
    ```,
    ```yade
    {"graph":{"activeTabId":0,"latexBackgroundColor":"white","latexPreamble":"\\newcommand{\\id}{\\mathsf{id}}","nextTabId":1,"tabs":[{"edges":[{"from":0,"id":5,"label":{"label":"Δ","options":{},"zindex":0},"to":1},{"from":1,"id":6,"label":{"label":"\\id × i","options":{},"zindex":0},"to":2},{"from":2,"id":7,"label":{"label":"⊙","options":{},"zindex":0},"to":3},{"from":0,"id":8,"label":{"label":"!","options":{"alignment":"right"},"zindex":0},"to":4},{"from":4,"id":9,"label":{"label":"e","options":{},"zindex":0},"to":3}],"freehandDrawings":[],"id":0,"nextGraphId":10,"nodes":[{"id":0,"label":{"label":"X","options":{},"pos":[681.5,188.5],"zindex":0}},{"id":1,"label":{"label":"X × X","options":{},"pos":[768.5,188.5],"zindex":0}},{"id":2,"label":{"label":"X × X","options":{},"pos":[884.5,188.5],"zindex":0}},{"id":3,"label":{"label":"X","options":{},"pos":[884.5,246.5],"zindex":0}},{"id":4,"label":{"label":"1","options":{},"pos":[681.5,246.5],"zindex":0}}],"sizeGrid":29,"title":"1"}]},"version":20}
    ```,
    ```yade
    {"graph":{"activeTabId":0,"latexBackgroundColor":"white","latexPreamble":"\\newcommand{\\id}{\\mathsf{id}}","nextTabId":1,"tabs":[{"edges":[{"from":0,"id":4,"label":{"label":"≅","options":{},"zindex":0},"to":1},{"from":1,"id":5,"label":{"label":"e × \\id","options":{},"zindex":0},"to":2},{"from":2,"id":6,"label":{"label":"⊙","options":{},"zindex":0},"to":3},{"from":0,"id":7,"label":{"label":"","options":{"bend":0.2,"head":"none","kind":"double"},"zindex":0},"to":3}],"freehandDrawings":[],"id":0,"nextGraphId":8,"nodes":[{"id":0,"label":{"label":"X","options":{},"pos":[768.5,420.5],"zindex":0}},{"id":1,"label":{"label":"1 × X","options":{},"pos":[855.5,420.5],"zindex":0}},{"id":2,"label":{"label":"X × X","options":{},"pos":[971.5,420.5],"zindex":0}},{"id":3,"label":{"label":"X","options":{},"pos":[971.5,478.5],"zindex":0}}],"sizeGrid":29,"title":"1"}]},"version":20}
    ```,
  )
  \+ $i(x) ⊙ x = e$ and $x ⊙ e = x$ #emoji.page.pencil
]
// #pause
// #definition[Theory of groups][
//   Category (with finite limits) generated from this sketch: $C_"grp"$
// ]
//
---
#definition[Theory of groups][
  #show ",": it => [#it #h(1em)]
  Category (with finite limits) $C_"grp"$ generated from this sketch:
  - $X, 1, X × X, X × X × X, ... quad ∈ ob C_"grp"$

  - $⊙ ∶ X × X → X, i ∶ X → X, e ∶ 1 → X quad ∈ mor C_"grp"$ \
    $Δ ∶ X → X × X, ! ∶ X → 1, id × e ∶ X × 1 → X × X, ... quad ∈ mor C_"grp"$ \
    $i ∘ e, ⊙ ∘ Δ, ... quad ∈ mor C_"grp"$
  - equations are satisfied
]

---

#definition[Models of $C_"grp"$][
  $
    "𝐌𝐨𝐝"(C_"grp") := "𝐋𝐄𝐗"(C_"grp", Set) #uncover("2-", $quad = "𝐆𝐫𝐩" #emoji.face.cool$)
  $
  Finite limit preserving _functors_ from $C_"grp"$ to $Set$.
  A model $M ∶ C_"grp" → Set$
  - maps $X$ to a *set* $G = M(X)$,
  - maps $⊙ ∶ X × X → X$ to a *function* $+ ∶ G × G → G$,
  - maps $e ∶ 1 → X$ to a *function* ${*} → G$ i.e. a element $0 ∈ G$,
  - maps $i ∶ X → X$ to a *function* $- ∶ G → G$,
  - preserves the equations: e.g. $$
    #grid(
      columns: (1fr, auto, 1fr),
      align: center,
      ```yade
      {"graph":{"activeTabId":0,"latexBackgroundColor":"white","latexPreamble":"\\newcommand{\\id}{\\mathsf{id}}","nextTabId":1,"tabs":[{"edges":[{"from":0,"id":5,"label":{"label":"Δ","options":{},"zindex":0},"to":1},{"from":1,"id":6,"label":{"label":"\\id × -","options":{},"zindex":0},"to":2},{"from":2,"id":7,"label":{"label":"+","options":{},"zindex":0},"to":3},{"from":0,"id":8,"label":{"label":"!","options":{"alignment":"right"},"zindex":0},"to":4},{"from":4,"id":9,"label":{"label":"\"0\"","options":{},"zindex":0},"to":3}],"freehandDrawings":[],"id":0,"nextGraphId":10,"nodes":[{"id":0,"label":{"label":"G","options":{},"pos":[1261.5,507.5],"zindex":0}},{"id":1,"label":{"label":"G × G","options":{},"pos":[1348.5,507.5],"zindex":0}},{"id":2,"label":{"label":"G × G","options":{},"pos":[1464.5,507.5],"zindex":0}},{"id":3,"label":{"label":"G","options":{},"pos":[1464.5,565.5],"zindex":0}},{"id":4,"label":{"label":"\\{\\ast\\}","options":{},"pos":[1261.5,565.5],"zindex":0}}],"sizeGrid":29,"title":"1"}]},"version":20}
      ```,
      [$⇔$],
      [$+ ∘ (id × -) ∘ Δ = 0$\  \ $∀ g ∈ G, g + -g = 0$],
    )
    ...
  // [$ul(⊙) ∘ (id × ul(i)) ∘ Δ = ul(e)$\  \ $∀ g ∈ G, g ul(⊙) ul(i)(g) = ul(e)$],)
]

---

#remark[Model morphism][
  Model morphism = function between the sets that preserves the operations
  #arL _group homomophism_
]

#remark[Initial group][
  Trivial group $G = {0}$

  (Not a very interesting programming language...)
]

== Conclusion <touying:unoutlined>

#align(center)[
  #table(
    columns: (auto, 1fr, auto, auto, auto, auto),
    inset: .4em,
    align: center,
    stroke: none,
    gutter: -1pt,

    [], [Presentation], [], [Theory], [], [Models],

    [Pattern:],
    [small and easy to \ write description],
    [$⟼$],
    [category $C ∈ #hla(1, yellow, $"𝐓𝐡"$)$],
    $⟼$,
    hla(1, yellow)[$"𝐌𝐨𝐝"(C)$],

    [Ehresmann#footnotecite(<ehresmannCategoriesStructures1965>):],
    [finite limit sketch],
    $⟼$,
    [$C ∈ #hla(1, yellow)[$"𝐋𝐞𝐱"$]$],
    $⟼$,
    [$#hla(1, yellow, $"𝐋𝐄𝐗"(C, "𝐒𝐞𝐭")$)$],

    [#pauses(2) *My work*:],
    [Skel program],
    $⟼$,
    [$ℂ ∈ #hla(2, yellow)[$"𝐕𝐃𝐛𝐓𝐡"$]$],
    $⟼$,
    [$#hla(2, yellow, $"𝐕𝐃𝐁𝐓𝐇"(ℂ, "ℝ𝕖𝕝")$)$],
  )
]
#meanwhile
#box(fill: yellow, outset: 2pt)["Locally presentable categories"]
#arL nice #emoji.thumb.up (e.g. there is an initial object #emoji.face)

#pause
Not so convenient for programming languages: need *relations* #pause
#arL $"𝐕𝐃𝐛𝐓𝐡"$ = 𝐕irtual 𝐃ou𝐛le 𝐓𝐡eories = to be defined...


#theend()

#show: appendix

= Appendix <touying:unoutlined>

== Bibliography

#bibliography("./these.bib", title: none)


