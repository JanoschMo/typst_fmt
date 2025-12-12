#import "@preview/polylux:0.4.0": *

#let common(doc) = [
  #set page(paper: "presentation-16-9")

  #set text(
    size: 32pt,
    font: ("Lato", "New Computer Modern"),
    ligatures: false,
    rgb("#000"),
  )
  #set par(spacing: 1em, leading: 1em)
  #show heading: set block(above: 1.2em, below: 1em)
  #show heading.where(level: 1): set text(weight: "medium", size: 42pt)
  #show heading.where(level: 1): set align(center)


  // hide list markers (tufte <3)
  #set list(marker: none, body-indent: 0em, spacing: 1em)

  #doc
]

#let cover-slide(title-text) = [
  #set align(center + horizon)

  #text(title-text, size: 52pt, weight: "bold")

  #place(
    top + right,
    box(image("img/zhaw_logo.svg"), height: 2.5cm),
  )
]

/*
This function enables a table that is uncovered row by row und thus, the content boxes
align with each other

number-of-columns:   How many columns should the table have?
uncover-start:       On which slide should be  uncovering start? 1 = first slide, 2 = second slide ...
table-content:       Array of content which should be displayed in the table

Example usage:
#table-row-by-row(3, 1, (
[Code-along style], [], [],
[Understand code], [$arrow$], [discuss with colleagues/ask],
[Answer questions], [$arrow$], [discuss with colleagues/ask],
))

 */
#let table-row-by-row(number-of-columns, uncover-start, table-content) = [
  #let enum-start = uncover-start * number-of-columns
  #table(
    align: left,
    columns: (number-of-columns),
    column-gutter: 1fr,
    row-gutter: 1.3em,
    stroke: none,
    ..table-content
      .enumerate(start: enum-start)
      .map(field => uncover(str(int(field.at(0) / number-of-columns)) + "-")[#field.at(1)])
  )
]
