# DiagrammeR

library("DiagrammeR")

# basic
grViz("
digraph boxes_and_circles{
node [shape = box, fontname = Helvetica]
A ; B ; C ; D
A -> B ; A -> C ; C -> D
}
      ")
# shape , fontname
grViz("
digraph boxes_and_circles{
node [shape = box, fontname = Helvetica]
A ; B ; C ; D
A -> {B  C} ; C -> D
}
      ")
## subgraph rank = same
grViz("
digraph {
node [shape = box, fontname = Helvetica]
脂肪性肝疾患 ; B ; C ; D
脂肪性肝疾患 -> {B  C} ; C -> D
subgraph{
rank = same; A;C
}
}
      ")

grViz("
digraph {
node [shape = box, fontname = Helvetica]
node [color = red]
NASH
node [color = GreenYellow]
NAFL
脂肪性肝疾患 -> {アルコール性  非アルコール性NAFLD} ;非アルコール性NAFLD -> {NAFL NASH}
}
      ")

grViz("
digraph {
node [shape = box, fontname = Helvetica]
脂肪性肝疾患 -> {アルコール性  非アルコール性NAFLD} ;非アルコール性NAFLD -> {NAFL NASH}
}
      ")




mermaid("
        graph TB
a[脂肪性肝疾患]
b[アルコール性]        
c[非アルコール性]        
d[NAFL]        
e[NAFLD]        
a --> b        
a --> c        
c --> d
c --> e
        ")





