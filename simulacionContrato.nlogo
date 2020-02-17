turtles-own [felicidad]

globals [
  hogar-centro-x hogar-centro-y
  empresa-uno-x empresa-uno-y
  empresa-dos-x empresa-dos-y
  empresa-tres-x empresa-tres-y
  empresa-cuatro-x empresa-cuatro-y
]

to setup
  clear-all
  setup-lugares
  setup-proletariado
  reset-ticks
end

to setup-lugares
  set hogar-centro-x 0
  set hogar-centro-y 0

  set empresa-uno-x min-pxcor + 6
  set empresa-uno-y max-pycor - 6

  set empresa-dos-x max-pxcor - 6
  set empresa-dos-y max-pycor - 6

  set empresa-tres-x max-pxcor - 6
  set empresa-tres-y min-pycor + 6

  set empresa-cuatro-x min-pxcor + 6
  set empresa-cuatro-y min-pycor + 6

  ask patches [set pcolor 92]

  ask patch hogar-centro-x hogar-centro-y [
    sprout 1 [
      set color 28
      set shape "house bungalow"
      set size 5
      ;set plabel "Centro de Viviendas"
      stamp
      die
    ]
  ]

  ask patch empresa-uno-x empresa-uno-y [
    sprout 1 [
      set color 58
      set shape "building store"
      set size 5
      ;set plabel "Casa de Desarrollo de Software"
      stamp
      die
    ]
  ]

  ask patch empresa-dos-x empresa-dos-y [
    sprout 1 [
      set color 68
      set shape "building store"
      set size 5
      ;set plabel "Firma de Abogados"
      stamp
      die
    ]
  ]

  ask patch empresa-tres-x empresa-tres-y [
    sprout 1 [
      set color 78
      set shape "building store"
      set size 5
      ;set plabel "Fabrica de Textiles"
      stamp
      die
    ]
  ]

  ask patch empresa-cuatro-x empresa-cuatro-y [
    sprout 1 [
      set color 88
      set shape "building store"
      set size 5
      ;set plabel "Ensambladora de Autobuses"
      stamp
      die
    ]
  ]
end

to setup-proletariado
  create-turtles cantidad-trabajadores
  ask turtles [
    set shape "person"
    setxy random-xcor random-ycor
    set felicidad 0
  ]
end

to go
  if ticks >= 1000 or not any? turtles [
    stop
  ]
  mover-trabajadores
  trabajar
  reproducirse
  indice-felicidad
  generar-nuevos-empleos
  tick
end

to mover-trabajadores
  ask turtles [
    left random angulo-busqueda
    right random angulo-busqueda
    forward 1
    set felicidad (felicidad - depresion)
  ]
end

to trabajar
  ask turtles [
    if pcolor = 92 [
      set pcolor 90
      set felicidad (felicidad + satisfaccion-laboral)
    ]
    ifelse mostrar-felicidad?
      [set label felicidad]
      [set label ""]
  ]
end

to reproducirse
  ask turtles[
    if felicidad > 30 [
      set felicidad (felicidad - costo-reproduccion)
      hatch 1 [set felicidad costo-reproduccion]
    ]
  ]
end

to indice-felicidad
  ask turtles [
    if felicidad <= 0 [
      die
    ]
  ]
end

to generar-nuevos-empleos
  ask patches [
    if pcolor < 92 [
      set pcolor pcolor + 0.25
    ]
  ]
end

;to generar-nuevos-empleos
;  ask patches [
;    if random 100 < 3 [
;      set pcolor 52
;    ]
;  ]
;end
