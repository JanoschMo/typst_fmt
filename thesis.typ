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
  set page(
    // general page layout
    paper: "a4",
    flipped: false,
    margin: (rest: 3cm),
  )

  set text(
    // general text layout
    font: "New Computer Modern Sans",
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

  // Generall table settings
  set table(
    stroke: 1pt + rgb("AAA"),
  )

  // ZHAW Logo and text on the first page
  let zhaw-logo-height = 3cm
  box(image("img/zhaw_logo.svg", height: zhaw-logo-height))
  h(1fr)
  box(height: zhaw-logo-height)[
    #set text(size: 16pt)
    // align top of "z" in zhaw logo with top of "School of Engineering" text
    #v(zhaw-logo-height * 36.555 / 225.641)
    *School of Engineering*\
    InES Institute of Embedded Systems
  ]

  // paragraph spacing
  set par(
    spacing: 0.65em,
    leading: 0.65em,
    justify: true,
    first-line-indent: 1.2em,
  ) // spacing - between pars, leading - between lines


  v(3fr)
  align(center, text(module, size: 18pt))
  align(center, text(title, size: 30pt))
  align(center, text(subtitle, size: 28pt))
  v(4fr)
  author-table(author, "Author", "Authors")
  author-table(superviser, "Superviser", "Supervisers")
  author-table(date, "Date", "Dates")


  colbreak()

  set page(footer: context [
    #set align(left)
    #set text(9pt, rgb("#555"))

    #text(title)
    #if subtitle != "" {
      [:]
      text(subtitle)
    }
    #h(1fr)
    #counter(page).display("1 / 1", both: true)
  ])

  doc
}


// adds a function which emphasizes an improvement
#let imp(t) = {
  set text(fill: orange, weight: "bold")
  text("Improvment: ")
  t
}
// adds todo function
#let tod(t) = {
  set text(fill: red, weight: "bold")
  text("TODO: ")
  t
}
