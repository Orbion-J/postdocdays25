#import "@preview/touying:0.6.1": *
#import themes.metropolis: *

#import "@preview/curryst:0.5.0": rule, prooftree
#import "@preview/fletcher:0.5.7" as fletcher: diagram, node, edge
#import "@preview/ctheorems:1.1.3" : *

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
)

#set heading(numbering: "1.1")
#show outline.entry: it => it.indented(it.prefix(), it.body())
// #show outline.entry.where(level : 2) : set text(size: 10pt)

#set text(font:"IBM Plex Sans")
#show math.equation: set text(font:"IBM Plex Math")


#title-slide()

= Outline <touying:hidden>

#outline(title: none, indent: 2em, depth: 2)

= Introduction

== My motivation 

- bla

= (Untyped) $λ$-calculus

#slide[]

= Typed $λ$-calculus

#slide[]
