#import "@preview/tiaoma:0.3.0"
#set page(width: 89mm, height: 36mm, 
	margin: (
		top: 2mm,
		bottom: 0mm,
		left: 3mm,
		right: 3mm,
	))
#set text(font: "DejaVu Sans Mono")
#let label(computer) = block[

#table(
  columns: (2cm,1fr,auto),
  align: (center,left,center),
  stroke: 0pt,
  inset: 0mm,
//  gutter: 0mm,
  [#image("logo_stack.png",width: 60%)],
[
  #set text(11pt)
  angestoepselt e.V. \
  #set text(20pt) 
  #computer.id
  #set text(10pt)
],[
 #tiaoma.barcode(
    computer.id,
    "QRCode",
    height: 20mm,
 ) 
  ]/*,
  table.cell(colspan: 3)[   
   #set text(8pt)
   #block(height: 0.5mm)
   #computer.distribution/#computer.version/#computer.cpu/#computer.memory/#computer.disk/ID:#computer.id
  ] */
  )

   #set text(8pt)
   #computer.distribution/#computer.version/#computer.cpu/#computer.memory/#computer.disk/
]

#let charger(computer) = block[
  #table(
    columns: (2cm,1fr,auto),
     align: (center,left,center),
    stroke: 0pt,
    inset: 1mm,
  [#image("logo_stack.png",width: 60%)],
  [
  #set text(8pt)
    Ladegerät:\
  #set text(20pt)
   #computer.id
  #set text(8pt)
  ],[
   #tiaoma.barcode(
    computer.id,
    "QRCode",
    height: 20mm,
   ) 
  ]
  )
]

#let computer = json(bytes(sys.inputs.computer))
#label(computer)
