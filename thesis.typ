//
// This is a helper to documentation documentation_short
//
#let author-table(people, label-singular, label-plural) = {
  table(stroke: none, gutter: -4pt, columns: (90pt, auto), ..if type(people) == array {
    let list = ()
    for item in people.enumerate().flatten() {
      if item == 0 {
        list.push(label-plural)
      } else if type(item) == int {
        list.push("")
      } else {
        list.push(item)
      }
    }
    list
  } else {
    (label-singular, people)
  })
}

//
// This is a template for short documentation work featuring an
// intro page with title, teachers, author and some logos
//
//
// #show:doc => documentation_short(
//   doc,
//   author: "Janosch Morf",
//   module: "mEVA_Asia",
//   title: "Personal Report",
//   subtitle: "Swiss, Greater Bay Area, and Tapei",
//   superviser: ("Andrea Bettoni", "Luca Canetta", "Joel Weingart"),
// )
#let documentation_short(
  doc,
  title: "title",
  subtitle: "subtitle",
  author: "author",
  module: "module",
  superviser: "superviser",
  date: datetime.today().display("[day].[month].[year]"),
) = {
  set page( // general page layout
    paper: "a4",
    flipped: false,
    margin: (rest: 3cm),
  )

  set text( // general text layout
    font: "Lato",
    weight: "regular",
    size: 11pt,
    lang: "en",
    rgb("#000"),
  )

  set columns(gutter: 8mm) // spacing between column
  set list(marker: [•])

  set heading(numbering: "1.")

  show heading.where(level: 1): set text(rgb("#000"))
  show heading.where(level: 2): set text(rgb("#000"))
  show heading.where(level: 3): set text(rgb("#000"))
  show heading.where(level: 4): set text(rgb("#000"))
  show heading: set block(above: 1.2em, below: 0.8em)
  show heading: set text(weight: "extrabold")

  set par(spacing: 0.65em, leading: 0.65em, justify: true, first-line-indent: 1.2em) // spacing - between pars, leading - between lines
  v(2fr)
  align(center, text(module, size: 18pt))
  align(center, text(title, size: 56pt))
  align(center, text(subtitle, size: 28pt))
  v(4fr)
  author-table(author, "Author", "Authors")
  author-table(superviser, "Superviser", "Supervisers")
  author-table(date, "Date", "Dates")
  v(2fr)
  outline()

  place(top + left, image("img/logo-mse.png", height: 15pt), dy: -20pt)

  colbreak()

  set page(footer: context [
    #set align(left)
    #set text(9pt, rgb("#555"))

    #text(title)
    $: $
    #text(subtitle)
    #h(1fr)
    #counter(page).display("1 / 1", both: true)
  ])

  doc
}

