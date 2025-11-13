#let number-until-with(max-level, schema) = (..numbers) => {
  if numbers.pos().len() <= max-level {
    numbering(schema, ..numbers)
  }
}
//
// Ths is for normal summary
// It has vibrant titles
//
// usage:
// #import "../Formatting/template.typ": summary_small, summary
// #show:doc => summary(doc, "TSM_AdvUseInf")
//
#let summary(doc, subject) = {
  set page( // general page layout
    footer: context [
      #set text(9pt, rgb("#555"))
      #datetime.today().display("[day]/[month]/[year]")
      #h(1fr)
      Morf Janosch
      #h(1fr)
      #text(subject)
      #h(20fr)
      #counter(page).display("1 / 1", both: true)
    ],
  )

  set text( // general text layout
    font: "Lato",
    weight: "regular",
    size: 11pt,
    lang: "en",
    rgb("#333"),
  )
  set columns(gutter: 8mm) // spacing between column
  set list(marker: [•])
  set heading(numbering: 1.)

  show heading.where(level: 1): set text(rgb("#ba4a00"))
  show heading.where(level: 2): set text(rgb("#ca6f1e"))
  show heading.where(level: 3): set text(rgb("#d68910"))
  show heading.where(level: 4): set text(rgb("#239b56"))
  show heading.where(level: 5): set text(rgb("#239b56"))
  show heading: set block(above: 1.2em, below: 0.8em)
  show heading: set text(weight: "extrabold")
  set par(spacing: 1.0em, leading: 0.6em, justify: true) // spacing - between pars, leading - between lines

  outline(depth: 1)

  doc
}

//
// This is a template, for a small school summary
// Main purpose is if site numbers are limited e.g.
// Text is small, three columns and vibrant titles
//
// usage:
// #import "../Formatting/template.typ": summary_small, summary
// #show:doc => summary_small(doc, "TSM_AdvUseInf")
//
#let summary_small(doc, subject) = {
  set page( // general page layout
    paper: "a4",
    flipped: true,
    margin: (rest: 8mm, bottom: 12mm),
    columns: 3,
    footer: context [
      #set align(left)
      #set text(9pt, rgb("#555"))
      #datetime.today().display("[day]/[month]/[year]")
      #h(1fr)
      Morf Janosch
      #h(1fr)
      #text(subject)
      #h(20fr)
      #counter(page).display("1 / 1", both: true)
    ],
  )

  set text( // general text layout
    font: "Lato",
    weight: "regular",
    size: 10pt,
    lang: "en",
    rgb("#333"),
  )
  set columns(gutter: 8mm) // spacing between column
  set list(marker: [•])
  set heading(numbering: "1.")

  show heading.where(level: 1): set text(rgb("#ba4a00"))
  show heading.where(level: 2): set text(rgb("#ca6f1e"))
  show heading.where(level: 3): set text(rgb("#d68910"))
  show heading.where(level: 4): set text(rgb("#239b56"))
  show heading: set block(above: 0.8em, below: 0.5em)
  set par(spacing: 0.8em, leading: 0.5em, justify: true) // spacing - between pars, leading - between lines

  set table(align: center, stroke: 0.2pt)
  doc
}