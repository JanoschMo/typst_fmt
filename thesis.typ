//
// This is a helper to documentation documentation_short
//
#let author-table(people, label-singular, label-plural) = {
  table(stroke: none, gutter: -4pt, columns: (70pt, auto), ..if type(people) == array {
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


#let start_appendix(body) = [
  = Appendix
  #set heading(numbering: "A-a", supplement: [Appendix])
  #counter(heading).update(0)
  #outline(target: heading.where(supplement: [Appendix]), title: none)
  #body
]


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
#let thesis(
  doc,
  title: "title",
  subtitle: "subtitle",
  author: "author",
  module: "module",
  superviser: "superviser",
  date: datetime.today().display("[day].[month].[year]"),
  path-correction: "../",
  abstract: "",
  bib: "",
  appendix: "",
) = {
  // table of content nicer
  show outline.entry.where(level: 1): it => {
    show repeat: none
    v(0.1cm)
    strong(it)
  }

  /*Additional spacing between figures and the text*/
  let figure_spacing = 1em
  show figure: it => {
    if it.placement == none {
      block(it, inset: (y: figure_spacing))
    } else if it.placement == top {
      place(
        it.placement,
        float: true,
        block(width: 100%, inset: (bottom: figure_spacing), align(center, it)),
      )
    } else if it.placement == bottom {
      place(
        it.placement,
        float: true,
        block(width: 100%, inset: (top: figure_spacing), align(center, it)),
      )
    }
  }

  // general page layout
  set page(
    paper: "a4",
    flipped: false,
    margin: (x: 3.2cm, y: 4.5cm),
  )

  // general text layout
  set text(
    font: "New Computer Modern Sans",
    weight: "regular",
    // size: 11pt,
    lang: "en",
    rgb("#000"),
  )

  // general paragraph spacing
  set par(
    spacing: 1.3em, //0.65em,
    leading: 0.65em,
    justify: true,
    first-line-indent: 0em, //1.2,
  )

  // Generall table settings
  set table(
    stroke: 1pt + rgb("999"),
  )


  /* First Page setting up */
  // ZHAW Logo and text on the first page
  let zhaw-logo-height = 1.8cm
  box(image("img/zhaw_logo.svg", height: zhaw-logo-height))
  h(1fr)
  box(height: zhaw-logo-height)[
    #set text(size: 16pt)
    // align top of "z" in zhaw logo with top of "School of Engineering" text
    #v(zhaw-logo-height * 36.555 / 225.641)
    *School of Engineering*\
    InES Institute of Embedded Systems
  ]

  v(3fr)
  align(center, text(module, size: 18pt))
  align(center, text(title, size: 30pt, weight: "semibold"))
  align(center, text(subtitle, size: 28pt))
  v(1fr)
  align(center, text(author, size: 18pt))
  v(10pt)
  align(center, text(date, size: 18pt))
  v(4fr)
  // author-table(author, "Author", "Authors")
  author-table(superviser, "Superviser", "Supervisers")
  // author-table(date, "Date", "Dates")

  colbreak()

  // numberin up to including outline ()
  set page(numbering: "i", number-align: right)
  counter(page).update(1)
  include path-correction + abstract

  // Title setup for the main body
  set list(marker: [•])

  set heading(numbering: "1.1")

  show heading.where(level: 1): set text(rgb("#000"), size: 22pt)
  show heading.where(level: 2): set text(rgb("#000"), size: 18pt)
  show heading.where(level: 3): set text(rgb("#000"), size: 14pt)
  // show heading.where(level: 4): set text(rgb("#000"))
  show heading: set block(above: 1.8em, below: 1em)
  show heading: set text(weight: "extrabold")

  // footer setup for the main body
  // set page(footer: context [
  //   #set align(left)
  //   #set text(9pt, rgb("#555"))

  //   #text(title)
  //   #if subtitle != "" {
  //     [:]
  //     text(subtitle)
  //   }
  //   #h(1fr)
  //   #counter(page).display("1 / 1", both: true)
  // ])

  // the outlone of the document
  outline(target: heading.where(supplement: [Section]))
  pagebreak()

  // the main body of the document
  set page(numbering: "1", number-align: right)
  counter(page).update(1)
  doc

  // the bibliography
  set heading(numbering: none)
  bibliography(path-correction + bib)

  set page(numbering: (..nums) => "A-" + nums.pos().map(str).at(0))
  counter(page).update(1)
  include path-correction + appendix
}
